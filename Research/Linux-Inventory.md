# Live Debian GPIO findings

The [live report](hackboard-linux-gpio.txt) came from this Hackboard 2 running Debian 13.7 with kernel 6.12.107. It lists four GPIO character devices and four Intel `INT3453` pinctrl instances. The ACPI paths and UIDs match the [Windows inventory](Windows-Inventory.md).

| Linux ACPI instance | ACPI path | UID | Controller | Registered pads |
| --- | --- | --- | --- | ---: |
| `INT3453:00` | `\_SB.GPO1` | 1 | Northwest | 80 |
| `INT3453:01` | `\_SB.GPO0` | 2 | North | 80 |
| `INT3453:02` | `\_SB.GPO2` | 3 | Audio | 20 |
| `INT3453:03` | `\_SB.GPO3` | 4 | SCC | 35 |

- The ITE EC appears separately as `PNP0C09:00` and binds to Linux's ACPI `ec` driver. Its boot log reports the same ACPI ports as Windows. The report provides no evidence of an EC-backed GPIO character device in this live system.
- `gpiodetect` and `gpioinfo` were unavailable. The debugfs ranges establish the Intel controllers and their pad counts, but the report lacks explicit character-device labels and line consumers. A second inventory with those tools could fill that gap. It would still need independent evidence to map a pad to the 40-pin header.
- An Intel pad name such as `GPIO_10` does not establish a match to the card's Raspberry Pi-style GPIO 10. That card entry refers to physical pin 19 and includes the stronger board-specific ITE `GPC3` clue. Also, some ACPI resource pin IDs exceed the respective Linux pad index range. For example, ACPI references North pin `0x6E`, while Linux reports North pad indices 0–79. Verify the numbering translation before carrying ACPI IDs into a Linux or Windows backend. [Header routing](Header-Routing.md)
- Some native-mode pads show `[ACPI]` or `[LOCKED, ACPI]` even when the corresponding pinmux row says `UNCLAIMED`. The latter is a Linux pinctrl ownership observation and is insufficient to establish that a line is safe for application use.

## Second live capture

The [second report](hackboard-linux-gpio-pass2.txt) includes `gpiodetect` and `gpioinfo`. It ties `gpiochip0` through `gpiochip3` to `INT3453:00` through `INT3453:03`, respectively, in this boot. All 215 lines were unnamed and none reported a GPIO consumer. The debug GPIO summary also shows no requested lines. The pinctrl capture still shows ACPI-owned and locked pads, so the empty consumer list cannot establish that these lines are available or routed to the header. The ITE EC has no separate gpiochip in this capture.

The serial inventory shows eight DesignWare I²C adapters and four DesignWare UART bindings. The report also contains four `ttyS` nodes, with no `i2c-*` or `spidev*` nodes under `/dev`. The ACPI tables contain platform consumers on some buses, including a UART resource on `URT2` and conditional I²C resources on `I2C4` and `I2C7`. These names and bindings do not identify which nets reach the header. A bus scan or transmit test on an unidentified bus could involve onboard devices.

The second pass closes the line-metadata gap from the first pass. Repeating the same inventory would add little. For the ITE path, the missing evidence is a board-matched EC firmware image or another source that identifies a host GPIO operation. For the Intel path, it is an independent route from at least one header pin to an Intel pad. Neither live report establishes a software control path for the onboard header.

The [single-line probe](probe_intel_gpio.sh) is ready for a candidate backed by board routing evidence. In Debian 13 Live with `gpiod` installed, run `sudo sh probe_intel_gpio.sh CHIP_LABEL OFFSET` to inspect the candidate. Use the Intel controller label and the Linux line offset from the capture. If the preflight passes and there is independent evidence for that route, start the scope capture on the physical header contact and repeat the command with `--pulse`. Expect a 3-second low/high/low/high/low sequence with intervals of 0.5/0.75/0.5/0.75/0.5 seconds. Record the chip and offset, physical pin, and scope result. The probe releases the output request and then requests the pad as input again for subsequent trials. [Debian gpioset manual](https://manpages.debian.org/trixie/gpiod/gpioset.1.en.html)

The board owner observed no voltage change on physical pin 31 (card label GPIO 6) across the initial sweep. This rules out an observed response among the candidates tested under those conditions. The first version left tested pads in output mode, which likely caused subsequent discovery to reject them.

The `--sweep-expanded` mode tests only additional Intel I²C, UART, SPI, and PWM pads that are already configured as unclaimed GPIO inputs. It retains the live lock and ownership checks and restores input direction after pulsing. The saved capture has 13 additional candidates before the full live preflight. For this group, prioritize scope channels on the card's bus-labeled contacts. Try pins 3 and 5 first, where the capture provides several I²C pad pairs to investigate. The pad list is a set of hypotheses and does not demonstrate board routing.

The board owner monitored physical pins 3 (SDA) and 5 (SCL), both initially at approximately 3.3 V, through the generic and expanded Intel sweeps and observed no voltage change. Together with the earlier pin 31 result, this lowers confidence in a direct route from the tested Intel pads to those contacts. Untested Intel pads and intervening hardware remain possible. Interpret individual negative results only for pulse requests that completed successfully. The results are consistent with an EC-backed header but do not map SDA, SCL, or physical pin 31 to the EC.
