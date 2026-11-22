# Initial Windows GPIO findings

## Windows-first prototype decision

- All four Intel `INT3453` devices are started on `iaLPSS2i_GPIO2_GLK`. PnP reported no interfaces for those four device instances. The Northwest instance reports Intel driver version `30.100.1820.1`. A documented KMDF peripheral driver opens an assigned GPIO connection using a Resource Hub connection ID supplied by PnP. An INF and a controller pin number alone do not supply that resource. [Microsoft GPIO driver overview](https://learn.microsoft.com/en-us/windows-hardware/drivers/gpio/gpio-driver-support-overview) · [Microsoft GPIO sample](https://learn.microsoft.com/en-us/samples/microsoft/windows-driver-samples/gpio-sample-drivers/)
- This Windows 11 Pro installation has a valid Microsoft-signed `rhproxy.sys` binary and a staged `rhproxy.inf` that explicitly matches `ACPI\MSFT8000`. The service is demand-start. The captured ACPI namespace lacks the matching device declaration and header resources. Presence of the package is stronger evidence than the service entry alone, while successful binding and WinRT enumeration on this installation remain untested. [Microsoft RhProxy bring-up documentation](https://learn.microsoft.com/en-us/windows/apps/develop/devices-sensors/enable-usermode-access)
- The Secure Boot state registry value is `0`. The direct UEFI query was denied in the current session, and test-signing status remains unverified. Microsoft documents an `ACPITABL.dat` test method that appends an ACPI table at boot with test signing enabled. That is a development experiment. Normal deployment would still need an authorized way to supply the ACPI resources.

**First Windows experiment:** if one header contact can be tied to a specific Intel controller and Windows-native pad ID, try the in-box RhProxy path before writing a custom KMDF driver. Define one input-only GPIO resource in a test table and verify that the proxy binds and WinRT exposes the controller before opening the pin. This separates device binding from hardware access. Check boot recovery and rollback before any test configuration change. The current pass changed no boot or firmware settings. The unresolved Intel pad assignment prevents choosing a meaningful GPIO resource today. The ITE route would require its own firmware interface.

## Embedded-controller software path

### Possible LPC configuration path

The DSDT declares I/O ranges `0x2E–0x2F` and `0x4E–0x4F` under `LDRC` (`PNP0C02`, UID 2). Windows reports both ranges assigned to `ACPI\PNP0C02\2` as motherboard resources, separate from the ACPI EC's `0x62` and `0x66`. These assignments are leads for investigating a host configuration interface. They do not identify what responds or establish any GPIO access. A register map from an ITE IT87 Super I/O or a different IT8987 board is insufficient evidence for this device. The next offline check is to identify firmware code that uses these ranges and determine whether it checks for the IT8987E and exposes a host GPIO window. No runtime I/O was performed.

The offline check scanned executable sections in 205 x86 PE and 53 x86 TE images from the initial and late UEFI volumes. It looked for immediate-port `IN`/`OUT` instructions and nearby constant loads into DX/EDX for the configuration ranges and standard EC ports. Three apparent hits occurred in the bundled `Shell_Full` image. Their surrounding bytes are data, including repeated GUID bytes, interpreted as instructions by the linear scan. No credible IT8987E identification sequence or host GPIO window setup was recovered. This scan does not resolve addresses passed through helper calls, computed from tables, or used through indirect protocol methods. A port reservation alone is insufficient to design a Windows GPIO probe.

The owner confirmed this is the factory Windows installation and no Debian Hackboard is available. A shipping image or package would be useful corroboration if found. Research can proceed using this board's captured firmware and installed drivers.

- Static ASL inspection found internal EC helpers. `ECRD` and `ECWT` take references to firmware objects and serialize access with the same mutex. The DSDT's `ECMD` method has an empty body. The SSDT calls inspected use these helpers for platform functions such as thermal and battery management. No ACPI WMI device (`PNP0C14`) or `_WDG` declaration was found in the captured ASL, and no present PnP device matched that ID. This pass found no header GPIO method contract for a Windows driver to call. No methods were invoked. [Microsoft ACPI method evaluation](https://learn.microsoft.com/en-us/windows-hardware/drivers/acpi/evaluating-acpi-control-methods)
- Continue by identifying the host-to-EC transport and any board-specific firmware contract from read-only device resources and identifiable factory firmware artifacts. An EC-backed prototype needs a GPIO-specific operation and a documented way to share the controller with firmware. In parallel, investigate the Intel path for any header pins that can be independently mapped to an Intel controller.

### Host transport and firmware leads

- The DSDT declares the standard ACPI EC interface under `_SB.PCI0.SBRG.H_EC`. Windows resource associations independently tie the data port `0x62` and status/command port `0x66` to `ACPI\PNP0C09\1`. Windows also enumerates the Intel LPC controller (PCI device `31E8`). These findings establish the OS-visible transport and ownership. They leave the EC firmware's mapping from host operations to physical GPIO pads unresolved. [UEFI ACPI embedded-controller specification](https://uefi.org/specs/ACPI/6.6/12_Embedded_Controller_Interface_Specification.html)
- The EC operation region declares fields named `RCMD`, `RCST`, `OG4I`, `OG4D`, and `OGID`. An exact-name search across the captured DSDT and SSDTs found each name only at its declaration. Their purpose is unknown and the declarations provide no basis for testing them as GPIO controls.
- The connected Windows Firmware class lists only a generic System Firmware device with Microsoft's `c_firmware.inf`. No board-specific update package or standalone EC image was identified by that query or the targeted public search. ACPI tables describe the host interface. The executable EC firmware needed to trace command handlers is a separate artifact.

The EC branch now needs a board-matched firmware image, vendor protocol, or other evidence of a GPIO-specific interface. The parallel Intel branch needs one header signal mapped to an Intel pad before any Windows GPIO prototype can target it. All checks in this pass used existing firmware captures or Windows inventory. No I/O ports were accessed directly.

A follow-up check found no present Ports-class device and no `Win32_SerialPort` entries. While the firmware declares Intel UART controllers and some UART consumers, Windows currently exposes no COM port to test against the header's TXD/RXD labels. A generic live Linux boot on the existing board is the next available way to compare controller enumeration, pinmux and line ownership without requiring a second board.

The [live Debian inventory](Linux-Inventory.md) is now available. It matches all four Intel ACPI controller identities and shows the ITE device bound to Linux's standard ACPI EC driver.

### Factory firmware availability

See the [ITE firmware host-interface analysis](ITE-Firmware-Analysis.md) for the decoded command paths and the evidence tied to the four mapped header pads.

The external GD25Q80E dump obtained on November 21, 2026 contains ITE EC firmware. The 1,048,576-byte file has SHA-256 `0daa1f256bcadd0046a0e3ef7ff8fde505d087a55492a9bb92f0b0585ac65bc5`. At offset zero an 8051-style long jump targets startup code at `0x0070`, which initializes RAM and calls further routines. Embedded strings identify `ITE EC-V14.4`, `ITE Tech. Inc.`, build timestamp `2022/12/03 20:28:42`, and `Intel GLK-MRD`. Most non-erased bytes are in the first 64 KiB, with two additional bytes at `0x10000` and `0x18000`. The remaining bytes are `FF`. This identifies the contents of the external flash. It does not establish whether the chip is loaded on every boot or whether code offers GPIO control to the host.

The Debian flashrom read succeeded and identified an 8 MiB GigaDevice GD25LQ64(B). The saved 8 MiB file contains the descriptor-selected BIOS bytes at `0x001000–0x67EFFF`. The descriptor and the separately declared Device Expansion region (`reg5`, `0x67F000–0x77FFFF`) are zero-filled in this export. Their actual contents remain unknown. The input SHA-256 is `C51B181A5E21B45126D61A7A77A95FACBDBC08889B27912D3C2EB17D7A24AB7F`.

Initial offline extraction used UEFIExtract A76. Its whole-image pass classified a large span as padding, so the firmware volume beginning at flash offset `0x343000` was extracted separately using its declared length of `0x34F000`. The nested `ReFlash` DXE executable contains an EC firmware update option and help text describing an EC area. This is evidence of an update feature in the BIOS executable. It does not establish that the Hackboard uses it, that EC code is included, or that the BIOS programs the EC on normal boot. Initial ASCII and UTF-16LE searches found no explicit IT8987 or header GPIO identifiers in the examined sections. [UEFIExtract release](https://github.com/LongSoft/UEFITool/releases/tag/A76)

Follow-up inspection located the EC update strings in the `ReFlash` PE32 executable (FFS GUID `70E1A818-0BE1-4449-BFD4-9EF68C7F02A8`). The six related flash executables checked, including `ReFlashSmm` and `FlashDriverSmm`, had no matching EC-specific text. The 64 KiB freeform payload under FFS GUID `A0327FE0-1FDA-4E5B-905D-B510C45A61D0` identifies itself as a VGA BIOS option ROM. The populated part of the BIOS export ends with erased `FF` pages. These checks did not recover an identifiable EC payload or establish whether the menu option is connected to a board-specific update routine.

The second flashrom read captured the firmware descriptor and Device Expansion region (`reg5`) successfully. The 8 MiB export SHA-256 is `195d8d2f950e9713a27a33f79c12bea4d5110971dda8a24882abffa961072f29`. The descriptor, BIOS, and Device Expansion now have coverage across the two reads. The remaining 512 KiB at the end is outside the ranges captured in both exports.

An offline composite assembled from the two reads allowed UEFIExtract to recognize the flash descriptor and Device Expansion region. Device Expansion starts with an Intel `$FPT` partition table. All nine entries are bounded within the region, and UEFIExtract identifies them as data partitions (`PSVN`, `UEP`, `DNXP`, `NVMS`, `IVBP`, `FLOG`, `UTOK`, `DVLC`, and `AFSP`). The large `AFSP` partition spans region offsets `0xA000–0xF9FFF`. A signature scan found no identifiable IT8987 firmware or EC update payload in this region. The partition structure points to Intel platform data and supplies no evidence that the BIOS programs the ITE during startup. This does not rule out an opaque or compressed payload. Keep raw firmware and extracted data in the ignored research directories. [UEFIExtract](https://github.com/LongSoft/UEFITool)

#### ReFlash form and callback trace

Decoded the HII package in the `ReFlash` PE32 resource. English string IDs 10 and 11 are the EC update label and help text. No static form question references them. The form does reference the boot-block checkbox and the generic update actions. Disassembly confirms callback branches for the generic actions at question IDs `0x65` and `0x66`, which match “Proceed with flash update” and its confirmation. The EC strings yielded no question ID to follow into that callback. This weakens the inference that a usable EC option exists on the board. The static trace leaves dynamically constructed questions and indirect calls unresolved. It establishes neither an EC update payload nor a normal-boot load path. [UEFI form structure definitions](https://github.com/tianocore/edk2/blob/master/MdePkg/Include/Uefi/UefiInternalFormRepresentation.h)

An IT8987-capable EC programmer is a possible independent acquisition route. The programmer documentation explicitly covers IT8987, but the compatible connection and voltage on this Hackboard revision are unidentified. A repair lab that can identify the interface and perform a read-only dump is another option. If acquired, keep the image local and compare hashes from two independent reads before inspecting command handlers for GPIO access. A readable image may establish that a GPIO operation exists or show that the firmware provides only platform-management functions. [Vertyanov programmer documentation](https://comsystem-tlt.ru/files/Vertyanov/Instruction%20Vertyanov%20JIG%20ver3.pdf)

- Windows reports AMI system BIOS `5.13` and embedded-controller firmware release bytes `FF:FF`. SMBIOS uses those bytes to indicate that the system does not advertise field-upgradeable EC firmware through those fields. They do not identify the EC build or establish whether it is stored in the system BIOS image. [DMTF SMBIOS specification](https://www.dmtf.org/sites/default/files/standards/documents/DSP0134_3.9.0.pdf)
- A targeted file-name search in the Windows driver store, Windows Update download cache, Windows recovery configuration, and setup directories found no Hackboard or IT8987 filenames and no `.cap`, `.fd`, or `.rom` candidates. The current session could not inspect `C:\Recovery\OEM`. No board-matched image was located in public search.
- The available ACPI captures and Windows metadata establish the live host interface but provide no executable EC firmware for offline analysis. An internal firmware read would need a supported way to identify and read the correct storage device. The board photos show multiple flash packages, and their contents and relationship to the EC are unverified.

- `pnputil /enum-devices /instanceid 'ACPI\PNP0C09\1' /services /stack /drivers /interfaces` reports a started device with Microsoft's `machine.inf` and the ACPI stack. It listed no device interfaces or vendor function driver for that instance. Windows supports vendor-defined application interfaces through a function driver, so this EC's enumeration alone gives Python and .NET no known GPIO endpoint. [Microsoft ACPI function driver documentation](https://learn.microsoft.com/en-us/windows-hardware/drivers/acpi/operation-of-an-acpi-device-function-driver)
- A targeted check found no GPIO or Hackboard package in the active Python environment and no GPIO, Hackboard, Quantum, or ITE Tech name in the third-party driver inventory. The ACPI text contains no literal `GPC3`, `GPC5`, `GPA6`, or `IT8987` identifiers. These checks cover the inspected environment and names.
- The campaign advertised Python GPIO access in its Windows section and lists a Debian shipping edition. No downloadable GPIO package or factory image was located in this pass. A factory package from either edition could reveal the transport and whether a supported Windows interface was ever distributed. [Hackboard campaign](https://www.crowdsupply.com/hackboard/hb2) · [Hackboard technical contact](https://www.crowdsupply.com/hackboard/hb2/updates/unboxing-tips)

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
