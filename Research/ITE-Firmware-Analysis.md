# IT8987E firmware host interface

Static analysis of the GD25Q80E dump, SHA-256 `0daa1f256bcadd0046a0e3ef7ff8fde505d087a55492a9bb92f0b0585ac65bc5`. The offsets below refer to the first 64 KiB of the supplied image, interpreted as 8051 code space. No firmware was executed or modified.

## Host command path

- Code at `0x083B` checks status at internal address `0x1500`. Helpers at `0x0A27` and `0x0A3A` consume incoming bytes at `0x1504`. The helper at `0x08BE` returns a byte through `0x1501`. These accesses match the status, input, and output register layout of ITE's related IT8512E power-management channel 1 and are consistent with the ACPI EC interface observed on the Hackboard. [ITE IT8512E reference, section 6.6](https://datasheet4u.com/pdf/705813/IT8512E.pdf)
- The local command and data dispatch tables at `0x09D3` and `0x099E` contain the standard ACPI EC operations. The standard data handlers use an internal address in page `0x04xx` for their host-visible byte store. That store is separate from the GPIO register range suggested by the firmware. Standard EC debug reads alone therefore do not read the pad registers.
- A separate command handler beginning at `0xE605` confirms that the image implements vendor-specific operations. It includes platform-management and diagnostic branches. The diagnostic machinery is broad, and its live availability, prerequisites, and ownership are unknown. The analysis found no dedicated, bounded host GPIO operation for the four mapped pads. A broad EC diagnostic interface would be unsuitable as the application-facing Windows GPIO API.

## Mapped pads and static evidence

The internal register addresses below are hypotheses derived from a **related ITE part**, supported in part by the access patterns in this dump. They require confirmation against the IT8987E or a live, pad-specific read. They are internal 8051 addresses, distinct from host I/O ports. [ITE IT8512E GPIO register map, section 7.5](https://datasheet4u.com/pdf/705813/IT8512E.pdf)

| Header pin | Verified pad | Candidate pad control address | Evidence in dump |
| --- | --- | --- | --- |
| 19 | GPC3 | `0x1623` | A routine starting at `0x9CB8` writes zero to this address and reads it back. |
| 21 | GPC5 | `0x1625` | The same routine writes zero to this address and reads it back. |
| 23 | GPG2 | `0x1642` | No direct literal DPTR load of this address found. |
| 31 | GPH6 | `0x164E` | Code at `0xF2D8` writes `0x80` here after writing the same value to three adjacent candidate H-port control addresses. |

The dump also contains repeated internal accesses at `0x1603`, `0x1607`, and `0x1608`, consistent with the candidate data registers for GPIO groups C, G, and H. The directly examined bit operations did not establish a host path for the mapped C3, C5, G2, or H6 bits. Literal searches miss indexed register tables and computed addresses. The write observed for H6 resembles input setup on the related part, but its conditions, execution on the live board, and current pin configuration remain unverified.

## Windows decision

### GPIO snapshot found in the dump

The second pass found a 40-entry, 12-byte-per-entry table at code offset `0x26E6`. Each row starts with its index. Rows 19, 21, and 31 match the corresponding measured header contacts, which corroborates the candidate register map independently of the related-chip datasheet. The row at index 23 contains `GPA6`. Index 24 contains `GPG2`, which continuity places at physical contact 23 on this specimen. Keep the firmware index and physical header number distinct for that case.

| Physical contact | Verified pad | Firmware index | Data register and mask | Snapshot byte and mask in host EC space |
| --- | --- | ---: | --- | --- |
| 19 | GPC3 | 19 | `0x1603` / `0x08` | `0x46` / `0x08` |
| 21 | GPC5 | 21 | `0x1603` / `0x20` | `0x46` / `0x20` |
| 23 | GPG2 | 24 | `0x1607` / `0x04` | `0x47` / `0x01` |
| 31 | GPH6 | 31 | `0x1608` / `0x40` | `0x47` / `0x40` observed live. Static prediction was `0x80`. |

Code at `0xBB26` checks the GPIO request/status byte and, in the snapshot branch, clears five host-visible bytes before walking the table. For each valid entry it reads the data register, applies the row mask, and sets the indexed bit in the host-visible bitmap. The function entry is referenced by the firmware function table via the jump at `0xBED7`. This is specific firmware evidence of a GPIO-to-host data path, beyond the earlier literal register scan. Static analysis has not confirmed that the factory firmware runs this service under normal Windows, how frequently the bitmap refreshes, or whether there is a reliable freshness signal. The stock DSDT does not name these snapshot bytes in the EC field list.

For a live proof, use a diagnostic that requests the snapshot through the OS-managed ACPI EC path and reads only the pin 31 bit. Compare multiple observations before attempting to publish the result as a GPIO value. Verify that the snapshot is fresh and that Windows continues handling its ordinary EC activity. The snapshot service also has a separate pin-configuration branch. Keep that branch outside the initial read test.

The [pin 31 diagnostic SSDT](HackboardPin31.asl) defines `RD31` under test device `PNP0C14` with UID `HB2P31`. It uses the existing EC operation region and firmware mutex. It requests a snapshot only if the request byte is zero, then clears its own request before sampling the bitmap. The delay is experimental because no completion flag was identified. The method never sets pin direction or drives the header.

ACPICA iASL compiled the SSDT with zero errors or warnings. The 458-byte AML passed header length and checksum validation. ACPICA AcpiExec with simulated EC storage returned the expected low, high, occupied, and EC unavailable results. It also confirmed request cleanup and preservation of an occupied mailbox. This verifies method logic in a mock. It leaves Windows binding, live timing, and electrical correlation untested.

### Windows live-test caller

The [PowerShell caller](Test-HackboardPin31.ps1) uses the [test MOF class](HackboardPin31.mof) to call `ReadPin31` through the in-box `WmiAcpi.sys` and `Acpi.sys` drivers. It addresses one fixed ACPI WMI method and prints a timestamp and result per sample. The mapper binary is present on this Windows installation. The final 522-byte SSDT compiled with zero errors and warnings. AcpiExec on simulated EC storage verified WMI method dispatch and rejected an unknown method ID. The MOF and PowerShell syntax checks passed. Live WMI binding and sampling are pending.

An elevated Windows test session with a recovery path is needed to load the diagnostic SSDT. Use Microsoft's documented additive `ACPITABL.dat` mechanism with test signing for the experiment. Preserve any existing test table and check recovery before staging. Verify the test ACPI WMI device is present and started after reboot, then register the temporary class from the `Research` directory and sample:

```powershell
mofcomp.exe .\HackboardPin31.mof
.\Test-HackboardPin31.ps1 -Samples 20 -IntervalMs 500
```

Start with passive observation of pin 31. A returned 0 or 1 shows the call returned a bitmap bit. A controlled correlation is still needed to demonstrate a fresh sample. The current session is unelevated and no boot, firmware, or WMI registration changes were made. [Microsoft ACPI test-table example](https://learn.microsoft.com/en-us/windows/apps/develop/devices-sensors/enable-usermode-access) · [Microsoft ACPI WMI sample](https://learn.microsoft.com/en-us/samples/microsoft/windows-driver-samples/wmi-acpi-sample/) · [Microsoft MOF registration guidance](https://learn.microsoft.com/en-us/windows-hardware/drivers/kernel/troubleshooting-specific-wmi-problems)

### First live Windows result

On November 21, 2026, the board owner reported that the diagnostic repeatedly returned `LOW` while a multimeter measured 0 V at physical pin 31 (GPIO6). This establishes that the SSDT, WMI binding, and method invocation worked on the board and that the returned bit agreed with the observed steady level. A constant bitmap bit would give the same result. Confirming freshness requires a measured transition and a corresponding change in the reported bit. Verify the pad's permitted input voltage and current configuration before applying an external signal.

In the follow-up test, a 10 kΩ pull-up to the header's 3.3 V rail brought physical pin 31 to 3.0 V at the meter while Windows continued reporting `LOW`. The first live test therefore verified method delivery only. The firmware row for index 31 was rechecked in the dump at `0x285A`. It encodes `0x1608` with mask `0x40`, and the snapshot routine packs that index into bit 7 of `0x0447`. The snapshot routine clears all five bitmap bytes at the start of each execution with request `0x55` and has no completion indicator. The current Windows method checks that its request byte still reads `0x55`, which confirms neither execution nor completion. The remaining questions are whether the service runs in this boot state and whether its sampled register reflects the pad in the current mux mode.

### Snapshot trace

The revised SSDT adds WMI method `ReadSnapshotTrace`. Its PowerShell caller accepts `-SnapshotTrace` and reports the five bytes at EC offsets `0x44` through `0x48` in address order. It captures them before issuing the request, after 100 ms with the request active, and 20 ms after clearing it. The five-byte reads are sequential, so a capture during a refresh can contain bytes from different refresh cycles. Status 0 means the request remained ours and was cleared, 2 means the EC was unavailable, 3 means the mailbox was occupied or the request changed, and 4 means the EC mutex timed out.

The 762-byte SSDT compiled with no errors or warnings. ACPICA simulation verified buffer layout, request cleanup, and preservation of an occupied mailbox. The MOF syntax check and a mocked PowerShell decode passed.

The board owner then toggled the pull-up several times during a 240-sample Windows trace. All requests returned status 0. The only changing bitmap bit was `0x40` in EC byte `0x47`. In six rising and six falling samples, the first bitmap had the old value and both the active and post-request bitmaps had the new value. This confirms live GPIO input on physical pin 31 on this board. The reason the firmware dump predicts mask `0x80` remains unresolved. The PowerShell reader now decodes the observed mask through the trace method, which works with the installed trace table. Newly compiled tables also use the observed mask for the single-read WMI method.

The board owner confirmed the corrected PowerShell reader worked on the bench. The [C# prototype](Pin31Reader/HackboardGpio.cs) uses the same WMI method and exposes `HackboardGpio.Read(6)` using the header's GPIO label. With the diagnostic table and MOF already installed, run `dotnet run --project .\Pin31Reader` from an Administrator PowerShell in the `Research` directory.

The board owner confirmed that the C# prototype reads successfully on the live board. This verifies the direct .NET-to-WMI path under the ACPI test boot.

### Output command in the EC dump

Static inspection found a separate command branch at `0xB9F3` entered when request byte `0x0442` contains `0xAA`. It checks the selector at `0x0440` against the firmware pin table and consumes the configuration byte at `0x0441`. The low two configuration bits select paths that appear to set input mode, drive low, or drive high. The output paths change the pad control register before changing the data register. The branch writes `0x55` back on its usual completion path, which also leaves the controller in snapshot mode. Rejection paths write `0x11` or `0x22`.

This identifies a candidate output operation. The live snapshot mask differs from the dump prediction, so neither that mask nor the physical pin number establishes the write selector on this running board. No output command has been sent. A pin-specific output probe needs independent evidence for the selector and a way to restore the entry state.

### First output probe

The probe uses selector 31 because its firmware row directly names the GPH6 port data bit and control register, and continuity independently places GPH6 at physical pin 31. The selector is still a hypothesis on the running EC. The probe requires a HIGH reading through the previously verified snapshot mask with a weak external pull-up in place. It requests a one-second drive-low pulse, followed by a GPIO input command. The options in `0x26` and `0x24` skip the optional alternate-function and pull configuration branches in the dump. The restore operation selects GPIO input and does not recover an arbitrary prior pad configuration.

`PulsePin31Low` serializes under the existing EC mutex, uses the mailbox only when idle, and restores the saved argument bytes. The probe reports both firmware response bytes. In ACPICA simulation the method refused a low preflight, reported two timeouts for a mock EC without the firmware service, and cleared the request afterward.

On November 22, 2026, the owner observed physical pin 31 fall from 3.0 V to 0 V and stay there with the 10 kΩ pull-up connected. The method returned `drive=0x55 release=0x55`. This verifies drive-low control on the measured contact and fails the electrical release criterion. The firmware's `0x55` is a mailbox response shared by configuration paths, so it cannot certify that the resulting pad state is high impedance. The dumped input branch changes the control register and leaves the output data latch untouched. Whether the live EC disabled the output buffer is unresolved. Keep further writes paused until a read-only baseline after a cold power cycle establishes whether the pull-up can again raise the pin.

After a cold boot, the owner measured 3.0 V with the pull-up attached before running any scripts. Re-decoding the 8051 branch at `0xBAB3` showed why the first release failed. Mode 0 falls through to the shared acknowledgment, bypassing the pad control write. Mode 1 reaches the input-mode write at `0xBABF`, mode 2 reaches drive low, and mode 3 reaches drive high. The corrected probe sends `0x25` for input and uses a new WMI method ID so the updated script cannot trigger the original pulse method. The corrected release still needs live scope confirmation.

The owner confirmed a 3 V to 0 V to 3 V transition on the corrected run. With only the weak pull-up connected, this verifies both drive-low and return to input. The complementary drive-high probe uses a weak pull-down, a LOW preflight, and the same verified input release command. Live drive-high remains unverified.

The owner confirmed the complementary test returned `drive=0x55 release=0x55` and measured 0 V to 3.3 V to 0 V with the 10 kΩ pull-down attached. This verifies sourcing current into the pull-down and release to input on physical pin 31. With the current test table and MOF installed, the C# prototype exposes the same commands as `HackboardGpio.Pulse(6, PinValue.Low)` and `HackboardGpio.Pulse(6, PinValue.High)`. From Administrator PowerShell in `Research`, use `dotnet run --project .\Pin31Reader -- pulse-low` with the pull-up or `dotnet run --project .\Pin31Reader -- pulse-high` with the pull-down.
