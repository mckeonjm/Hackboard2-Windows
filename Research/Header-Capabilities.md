# Hackboard 2 header capability assessment

See the [full bench results](Header-Bench-Results.md) for the expanded run. It confirmed both output directions and electrical release on 25 contacts and found inconsistent post-release reads on several pins, including three that tracked both levels in earlier runs.

The [full continuity map](Header-Continuity-Map.md) extends the routing survey to every signal contact. The guided script covers all 28 contacts, with active tests on 26 and passive voltage observations on pins 27 and 28. Pin 40's live bitmap mapping and output remain untested. Use `-StartAt 23` to resume the default sequence at pin 23, or `-Pin 40` to run pin 40 alone.

The test ACPI table exposes snapshot reads, single-pin reads, standalone input configuration, and high and low pulses with release for all 26 mapped pins. Single-pin reads decode the same EC bitmap as the snapshot method. The [input initialization script](Test-HackboardInputInitialization.ps1) defaults to pins 7 and 11, accepts `-Pin 40` for a single pin, and accepts `-All` for all mapped pins.

On PCB PZ08C20045B0, Windows has verified digital input, drive low, drive high, and release to input on physical header pin 31 (GPIO6). The verified path uses the ITE embedded controller's mailbox through the Windows ACPI test table. The output test confirmed selector 31 on this specimen. See the [firmware analysis](ITE-Firmware-Analysis.md) and [continuity measurements](Header-Routing.md).

## Digital GPIO candidates

| Physical pin | Card label | Continuity to IT8987E | Candidate write selector from dump | Candidate live read byte and mask |
| --- | --- | --- | ---: | --- |
| 19 | GPIO10 / MOSI | GPC3, lead 56 | **19 verified** | **`0x46 / 0x04` verified** |
| 21 | GPIO9 / MISO | GPC5, lead 57 | **21 verified** | **`0x46 / 0x10` verified** |
| 23 | GPIO11 / SCK | GPA6, lead 32 | **23 verified** | **`0x46 / 0x40` verified** |
| 24 | GPIO8 / CE0 | GPG2, lead 100 | **24 verified** | **`0x46 / 0x80` verified** |
| 31 | GPIO6 | GPH6, lead 99 | **31 verified** | **`0x47 / 0x40` verified** |

The dump has 27 populated GPIO rows. The supplied header card lists 28 signal contacts. The similar counts make a broad EC mapping worth investigating. The remaining rows need a physical correlation before being exposed as header pins.

### Read bitmap hypothesis

The live trace at rest reported `14-00-10-00-00`. Numbering bits from zero starting at EC byte `0x44`, it sets positions 2, 4, and 20. All three have empty rows at those indices in the dump. Their successors, 3, 5, and 21, are all populated. Pin 31 then set bitmap position 30 when pulled high, and output selector 31 controlled that same pin.

These observations support a candidate one-position offset between the live bitmap and the command selector. The table above applies the hypothesis to the three other continuity-verified pads. The at-rest bits have no individual physical correlation yet. Verify at least one more pad before applying the offset as a general decoder rule. The existing `-SnapshotTrace` mode already captures every candidate bit without a new ACPI table. Pins 19 and 21 give two clean comparisons with continuity, matching card pad names, and matching firmware rows.

The first guided run measured near 0 V in all three phases, including with the pull-up, and the bitmap stayed `14-00-10-00-00`. There was no physical transition with which to verify the candidate input bit.

The [guided test script](Test-HackboardHeader.ps1) runs high and low pulses, release checks, and input measurements on the matched pads. Load the updated test table and MOF once, then run in Administrator PowerShell. Results append to `header-test-results.txt`.

### November 22 live results

- **Pin 3, partial run** started at 3.3 V without an external resistor. With the 10 kΩ pull-down, the high pulse produced approximately 1.7 V → 3.3 V → 1.7 V and both EC commands returned `0x55`. The EC bit remained high, so this run establishes drive-high and return to the biased baseline. Drive-low and input threshold tracking remain to be checked. The guided script now accepts a nonzero biased baseline and distinguishes an unusual waveform that returns from an uncertain release.

- **Pin 19** passed both output pulses and release checks. After output release, the weak pull-up and pull-down produced opposite voltages and the candidate input bit followed. The initial pull-up held near 0 V before the firmware had explicitly returned the pad to input.
- **Pin 21** passed both output pulses and release checks. After output release, the input bit followed the measured pull-up and pull-down levels. The initial step labeled pull-up logged near 0 V between two readings of about 2.6 V. The cause is unresolved and is independent of the consistent pulse and post-output results.
- **Pins 23 and 24** passed both scope pulse and release checks. Both input bits tracked the pull-up and pull-down after release. During drive-high, EC byte `0x46` was `0x50` for pin 23 and `0x90` for pin 24. During drive-low it was `0x10` for both. Unbiased pin 24 was about 1 V. The log confirms all five tested pads follow the observed selector-to-bitmap offset.

## Alternate functions

| Function | Evidence today |
| --- | --- |
| SPI on 19, 21, 23, 24, 26 | The measured pads match MOSI, MISO, SSCK, SSCE0#, and SSCE1#. Hardware SPI bus operation still needs a live test. The WMI probe is designed for bench pulses and slow sampling. |
| I²C on 3/5 and 27/28 | Pins 3/5 reach the ITE SMDAT0/SMCLK0 pads. Pins 27/28 have no measured ITE connection. Bus operation and Windows access remain unverified. |
| UART on 8/10 | The measured routes match ITE TXD/RXD. Windows exposed no COM port in the inventory. |
| PWM on 32/33, GPCLK on 7, PCM on 12/35/38/40 | The measured PWM pads are ITE PWM2 and PWM5. GPCLK and PCM card labels have no demonstrated hardware function. The [continuity map](Header-Continuity-Map.md) records the corresponding pads. |

Sources include the [header card](Hackboard2-GPIO-pinout.txt), [Windows inventory](Windows-Inventory.md), and [Linux inventory](Linux-Inventory.md).
