# Full header continuity map

On November 22, 2026, the owner measured continuity from 26 of the 28 signal contacts to the IT8987E on PCB PZ08C20045B0. The [original bench notes](Header%20Pins%20to%20ITE%20pins%20mapping.txt) record the measured leads. Pad names come from the [Quanta IT8987E/BX schematic, page 30](https://forums.futura-sciences.com/attachments/materiel-hardware/384315d1551389528-reparation-carte-mere-hp-vinafix.com_quanta-x12_6l-r1a.pdf#page=30). Firmware rows were matched by GPIO data register and bit mask.

| Physical header | Card label | ITE lead | ITE pad | EC selector | Live bitmap byte / mask |
| ---: | --- | ---: | --- | ---: | --- |
| 3 | GPIO 2 (SDA) | 111 | GPB4 | 3 | `0x44 / 0x04` |
| 5 | GPIO 3 (SCL) | 110 | GPB3 | 5 | `0x44 / 0x10` |
| 7 | GPIO 4 (GPCLK0) | 84 | GPE3 | 7 | `0x44 / 0x40` |
| 8 | GPIO 14 (TXD) | 109 | GPB1 | 8 | `0x44 / 0x80` |
| 10 | GPIO 15 (RXD) | 108 | GPB0 | 10 | `0x45 / 0x02` |
| 11 | GPIO 17 | 82 | GPE1 | 11 | `0x45 / 0x04` |
| 12 | GPIO 18 (PCM_CLK) | 86 | GPF1 | 12 | `0x45 / 0x08` |
| 13 | GPIO 27 | 124 | GPC6 | 13 | `0x45 / 0x10` |
| 15 | GPIO 22 | 85 | GPF0 | 15 | `0x45 / 0x40` |
| 16 | GPIO 23 | 77 | GPJ1 | 16 | `0x45 / 0x80` |
| 18 | GPIO 24 | 73 | GPI7 | 18 | `0x46 / 0x02` |
| 19 | GPIO 10 (MOSI) | 56 | GPC3 | 19 | `0x46 / 0x04` |
| 21 | GPIO 9 (MISO) | 57 | GPC5 | 21 | `0x46 / 0x10` |
| 22 | GPIO 25 | 78 | GPJ2 | 22 | `0x46 / 0x20` |
| 23 | GPIO 11 (SCK) | 32 | GPA6 | 23 | `0x46 / 0x40` |
| 24 | GPIO 8 (CE0) | 100 | GPG2 | 24 | `0x46 / 0x80` |
| 26 | GPIO 7 (CE1) | 125 | GPG0 | 26 | `0x47 / 0x02` |
| 27 | GPIO 0 (ID_SD) | None found | Unknown | None identified | Unmapped |
| 28 | GPIO 1 (ID_SC) | None found | Unknown | None identified | Unmapped |
| 29 | GPIO 5 | 97 | GPH4 | 29 | `0x47 / 0x10` |
| 31 | GPIO 6 | 99 | GPH6 | 31 | `0x47 / 0x40` |
| 32 | GPIO 12 (PWM0) | 28 | GPA2 | 32 | `0x47 / 0x80` |
| 33 | GPIO 13 (PWM1) | 31 | GPA5 | 33 | `0x48 / 0x01` |
| 35 | GPIO 19 (PCM_FS) | 94 | GPH1 | 35 | `0x48 / 0x04` |
| 36 | GPIO 16 | 90 | GPF5 | 36 | `0x48 / 0x08` |
| 37 | GPIO 26 | 18 | GPD0 | 37 | `0x48 / 0x10` |
| 38 | GPIO 20 (PCM_DIN) | 117 | GPF6 | 38 | `0x48 / 0x20` |
| 40 | GPIO 21 (PCM_DOUT) | 47 | GPD6 | 40 candidate | `0x48 / 0x80` candidate |

All 26 matching rows agree with the physical header number. The bitmap columns use the one-position offset measured on physical pins 19, 21, 23, 24, and 31. The other bitmap entries and write selectors are bench-test candidates.

ITE lead 47 on physical pin 40 is GPD6/TACH0. A recheck found a populated selector 40 row at `0x28C6`, immediately after the empty row 39. It names GPIO data register `0x1604`, mask `0x40`, and control register `0x162E`, consistent with GPD6. The configuration command accepts selectors 1 through 40, while the dumped snapshot loop uses indices 0 through 39. The guided test uses selector 40 for the output pulses and logs the candidate input bit and full snapshot. Verify the output and release with the scope and evaluate the read mapping separately.

The populated rows at selectors 27 and 28 correspond to GPH3 and GPH2. Neither has a measured route to the header, so those selectors cannot be assigned to physical pins 27 and 28.

The card labels agree with the ITE alternate functions for SDA/SCL on 3/5, TXD/RXD on 8/10, and SPI on 19/21/23/24/26. The reference calls the PWM-capable pads on physical pins 32/33 PWM2 and PWM5. That differs from the header labels PWM0/PWM1. The GPCLK and PCM labels likewise do not establish the corresponding ITE peripheral functions. The bench script verifies digital GPIO only.
