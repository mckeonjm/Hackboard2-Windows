# Initial Windows GPIO findings

Collected November 19, 2026, on Windows 11 Pro x64 build 22621. The processor reports Intel Celeron N4020 and the AMI BIOS reports version 5.13. SMBIOS baseboard identity fields contain placeholder values, so the board revision needs to be read from the PCB.

| Check | Result |
| --- | --- |
| Intel GPIO controller | Four present ACPI INT3453 devices, each with configuration manager problem code 0 |
| Intel controller driver | `iaLPSS2i_GPIO2_GLK` running |
| Microsoft GPIO class extension | `GPIOClx0101` running |
| Resource Hub proxy | `rhproxy` registered and stopped at collection |
| Windows Runtime GPIO | `GpioController.GetDefault()` returned null in an unpackaged Windows PowerShell process |

The controllers are enumerated and their driver is running. Header routing and user-mode exposure remain open. Read-only ACPI inspection is the next step to distinguish the four instances and look for GPIO resource consumers and a proxy device node.

## ACPI capture

- Present PnP devices include `ACPI\INT3453\1` through `ACPI\INT3453\4`, all reporting OK. The present-device scan found no instance ID matching `MSFT8000`.
- Running `python Research/dump_acpi.py` captured the FACP and first SSDT under `Research/local/acpi/`. Windows listed ten SSDTs and its firmware API can retrieve only the first table for a repeated signature. The API enumeration omitted the DSDT. [Microsoft firmware table API](https://learn.microsoft.com/en-us/windows/win32/api/sysinfoapi/nf-sysinfoapi-getsystemfirmwaretable)
- The Windows hardware registry under `HKLM\HARDWARE\ACPI\DSDT` supplied a 52,782-byte DSDT with a matching declared length and valid ACPI checksum. A raw string scan found `INT3453` and found zero occurrences of `MSFT8000` and `RHPX`. The other SSDTs and the interpreted AML namespace still need examination before drawing a conclusion about firmware exposure. [Microsoft RhProxy ACPI requirements](https://learn.microsoft.com/en-us/windows/apps/develop/devices-sensors/enable-usermode-access)

## ACPI disassembly

ACPICA 20250807 `acpidump.exe -n SSDT -b` recovered ten SSDT files, matching the Win32 enumeration. The utility printed `AE_NOT_FOUND` after writing those files. All ten passed signature, length, and checksum checks. Disassembling the tables together with `iasl -da` encountered duplicate namespace names (`AE_ALREADY_EXISTS`). Running `iasl -d` on each file separately succeeded for the DSDT and all ten SSDTs. No disassembly contained `MSFT8000`, `RHPX`, or `rhproxy`. Together with the PnP and WinRT results, this points to missing RhProxy resource exposure on this installation. [ACPICA release](https://github.com/open-acpica/acpica/releases/tag/20250807)

| DSDT path | ACPI UID | Firmware controller name | Pin IDs in explicit GPIO descriptors (hex) |
| --- | --- | --- | --- |
| `\_SB.GPO1` | 1 | Northwest | 12, 14, 1A, 27, 43, 4D, 50, 54 |
| `\_SB.GPO0` | 2 | North | 34, 35, 36, 44, 45, 46, 6E |
| `\_SB.GPO2` | 3 | Audio | 00, 02, 03 |
| `\_SB.GPO3` | 4 | SCC | 01, 0B |

The last column lists references found in `GpioIo` and `GpioInt` descriptors in the DSDT, `ssdt4`, and `ssdt9`. Some descriptors are conditional. The list records firmware claims to investigate and cannot establish which pins are free at runtime. No physical header pin has been tied to a controller and native line yet.

Reproduce the inventory from the repository root with `& ./Research/Get-WindowsGpioInventory.ps1`. To repeat the WinRT check, run the following in Windows PowerShell 5.1.

```powershell
$type = [Windows.Devices.Gpio.GpioController,Windows.Devices.DevicesLowLevelContract,ContentType=WindowsRuntime]
$type::GetDefault()
```
