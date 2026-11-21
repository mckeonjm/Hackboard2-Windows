# Hackboard 2 header routing

## External ITE flash lead

On November 21, 2026, the board owner measured continuity from IT8987E lead 102 (`FMOSI/GPG4`) to lead 5 (`SI/IO0`) of the GigaDevice chip marked `25Q80ES1G`. This is the expected data-out to data-in connection for the ITE's external flash interface. The 8-Mbit GD25Q80E holds 1 MiB and is a separate device from the 8 MiB GD25LQ64(B) identified by the host BIOS read. Its contents and role at boot remain unknown. [IT8987E/BX schematic](https://forums.futura-sciences.com/attachments/materiel-hardware/384315d1551389528-reparation-carte-mere-hp-vinafix.com_quanta-x12_6l-r1a.pdf#page=30) · [GigaDevice GD25Q80E datasheet](https://www.mouser.com/datasheet/2/870/DS_00478_GD25Q80E_Rev1_3-3435732.pdf)

Additional unpowered checks are flash lead 1 to ITE 101 (chip select), flash 2 to ITE 103 (data back), and flash 6 to ITE 105 (clock). Flash lead 4 is ground and lead 8 is VCC. Check lead 8 against ground with the board powered before selecting a programmer setup. In-circuit flash readout requires accounting for bus contention and possible back-powering through the clip.

## Continuity results on PCB PZ08C20045B0

The board owner reported the following unpowered connections on November 20, 2026. ITE lead 1 also showed continuity to verified header ground, corroborating the package orientation. Exact resistance values were unspecified.

| Physical header pin | Supplied card label | Measured ITE lead | IT8987E/BX pad and alternate function |
| --- | --- | ---: | --- |
| 19 | GPIO 10 / MOSI / GPC3 | 56 | GPC3 / SMOSI |
| 21 | GPIO 9 / MISO / GPC5 | 57 | GPC5 / SMISO |
| 23 | GPIO 11 / SCK / GPA6 | 100 | GPG2 / SSCE0# |
| 31 | GPIO 6 | 99 | GPH6 / HMOSI / ID6 |

Lead 100 is fourth from the top on the left edge with the package text upright. The card's GPA6 would be lead 32. The measured route supersedes that proposed assignment. The reference names lead 100 as a chip-select alternate function. Its active function on this board remains unknown. [IT8987E/BX reference schematic, page 30](https://forums.futura-sciences.com/attachments/materiel-hardware/384315d1551389528-reparation-carte-mere-hp-vinafix.com_quanta-x12_6l-r1a.pdf#page=30)

The board owner measured 3.3 V at ITE lead 106 with the board powered on. The package reference identifies lead 106 as `VSTBY_FSPI`. This records the voltage at that supply lead in the measured state. The voltage limits for the mapped GPIO pads and the programming interface remain unverified. [IT8987E/BX reference schematic, page 30](https://forums.futura-sciences.com/attachments/materiel-hardware/384315d1551389528-reparation-carte-mere-hp-vinafix.com_quanta-x12_6l-r1a.pdf#page=30)

Three pin-card labels point to the ITE embedded controller as the leading routing candidate for the header’s SPI data and clock signals. Hackboard’s published specification lists an `ITE8987` embedded controller. An unrelated IT8987 board schematic independently shows the same GPIO names paired with the corresponding SPI functions. This is evidence for the pad naming and alternate functions. The continuity results above supersede these initial routing hypotheses. [Hackboard 2 specification](https://docs.rs-online.com/7aa6/A700000008351987.pdf) · [IT8987 reference schematic](https://www.e-weekly.co.uk/download/rnd/drivers/clevo/w515gu/esm5.pdf?lce=)

| Physical pin | Raspberry Pi-style label on card | Candidate controller pad and alternate function |
| --- | --- | --- |
| 19 | GPIO 10 / MOSI | ITE8987 `GPC3` / `SMOSI` |
| 21 | GPIO 9 / MISO | ITE8987 `GPC5` / `SMISO` |
| 23 | GPIO 11 / SCK | ITE8987 `GPA6` / `SSCK` |

Source for the first two columns is the [supplied pin card transcription](Hackboard2-GPIO-pinout.txt). The remaining signals, including SPI chip selects on pins 24 and 26, still have unknown controller routing. The card does not establish logic voltage, mux state, or whether the EC firmware permits application control.

## Board photo evidence

- The underside photo shows an ITE package marked `IT8987E` and `2152-BXA`. This confirms the controller model on this specimen and strengthens the candidate mapping for pins 19, 21, and 23. [Controller close-up](Board%20Photos/IMG_8500.JPG)
- The underside silkscreen reads `PZ08C20045B0`. Record the full string as the specimen's PCB identifier. The meaning of the `B0` suffix is unconfirmed. [PCB marking](Board%20Photos/IMG_8499.JPG)
- With the component side up, USB-A ports on the left, and the GPIO header along the near edge, a small white triangle sits just outside the board-edge row at the end nearest the white `FAN` connector. It marks the working pin 1 position. Pins 19, 21, and 23 are the 10th, 11th, and 12th positions in the edge row, counted from the fan end. The board owner measured continuity between the suspected ground contacts and found them commonly connected, supporting this orientation. The exact contacts and resistance readings were unspecified. [Header close-up](Board%20Photos/IMG_8504.JPG)

## Windows implications

The board owner confirmed the card's power connections at the header. Physical pins 1 and 17 are 3.3 V, and pins 2 and 4 are 5 V. Along with the common-ground continuity check, this confirms the header orientation on this specimen. Exact meter readings were unspecified. The rail measurements do not establish the GPIO signal voltage limits.

Windows enumerates one healthy Microsoft ACPI-Compliant Embedded Controller, `ACPI\PNP0C09\1`. The main ACPI table declares it as `_SB.PCI0.SBRG.H_EC` and defines an `EmbeddedControl` operation region. `PNP0C09` is a generic ACPI identity. It establishes a firmware-managed EC on the host, while the system specification supplies the candidate chip model. The measured header connections give the EC path priority for these three pins. No documented application-facing EC GPIO interface was identified in this pass. [Windows GPIO findings](Windows-Inventory.md)

## Evidence still needed

### Original unpowered ITE test targets

The IT8987E/BX reference shows package leads 56 for `GPC3`, 57 for `GPC5`, and 32 for `GPA6`. These are candidate endpoints for this board, based on the photographed `IT8987E` / `2152-BXA` marking and the supplied header labels. [Quanta IT8987E/BX schematic, page 30](https://forums.futura-sciences.com/attachments/materiel-hardware/384315d1551389528-reparation-carte-mere-hp-vinafix.com_quanta-x12_6l-r1a.pdf#page=30)

| Header contact | Card signal | Candidate ITE lead |
| --- | --- | ---: |
| 19 | MOSI / GPC3 | 56 |
| 21 | MISO / GPC5 | 57 |
| 23 | SCK / GPA6 | 32 |

Use the package top view with the ITE text upright, as in the [controller close-up](Board%20Photos/IMG_8500.JPG). The small dimple and chamfer at the lower-left corner indicate the likely pin 1 corner. In that orientation, leads 1–32 run left to right along the bottom edge. Leads 33–64 run bottom to top on the right edge, putting 56 ninth from the top and 57 eighth from the top. Confirm the marker and check the presumed ITE lead 1, shown as VSS in the reference, against a verified header ground before relying on the count.

Disconnect the DC supply, battery if fitted, and external cables. Use resistance mode after confirming the rails are de-energized. Measure and record the probe-tip short resistance, then each of the three header-to-lead readings in ohms. Use a fine tip at the chip so adjacent leads stay separate. A stable reading near the probe-tip baseline supports a direct path. A repeatable finite resistance could be a series component or another circuit path, and an open reading leaves buffered routing possible. If the first three readings are ambiguous and the leads are accessible, cross-check header pins 19 and 21 against both adjacent candidate leads to catch a counting or probe-placement error.

On November 20, 2026, the board owner reported approximately 1.12 V on physical pin 23 (card label SCK) and 0 V on physical pin 19 (card label MOSI), with no changes observed during a reboot. This establishes the observed levels for that test. It leaves the signal voltage limits, direction, mux state, and controller routing unresolved. Repeating the same no-stimulus test is low priority. The next useful routing evidence is a targeted unpowered resistance check at a verified controller lead or a traceable passive.

The Windows and Debian inventories have reached the limit of what they can tell us about physical routing. Targeted unpowered continuity tracing can now advance that part of the project, starting with one of the three named ITE candidates if the exact package lead or a traceable passive is accessible. An open reading is inconclusive when a buffer or series component may intervene. Physical confirmation would narrow the backend choice. It would not establish a firmware command or a Windows interface.

- Obtain the vendor's header-to-controller map, electrical limits, or a factory Linux image or GPIO package. The publicly available FCC exhibits include photographs. The applicant requested indefinite confidentiality for the schematic and block diagram. [FCC exhibits](https://fccid.io/2BAIC-N4P5000) · [Applicant confidentiality request](https://fcc.report/FCC-ID/2baicn4p5000/6586620.pdf)
- Inspect any factory GPIO package offline to learn whether it uses the embedded controller, Intel GPIO, or both. Preserve firmware ownership while investigating. Verify a candidate route through a schematic or an unpowered continuity check where accessible, then establish the pin's electrical limits before attempting an input or output test.
