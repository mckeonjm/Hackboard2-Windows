# Hackboard 2 header routing

Three pin-card labels point to the ITE embedded controller as the leading routing candidate for the header’s SPI data and clock signals. Hackboard’s published specification lists an `ITE8987` embedded controller. An unrelated IT8987 board schematic independently shows the same GPIO names paired with the corresponding SPI functions. This is evidence for the pad naming and alternate functions. The electrical routing on this Hackboard 2 remains unverified. [Hackboard 2 specification](https://docs.rs-online.com/7aa6/A700000008351987.pdf) · [IT8987 reference schematic](https://www.e-weekly.co.uk/download/rnd/drivers/clevo/w515gu/esm5.pdf?lce=)

| Physical pin | Raspberry Pi-style label on card | Candidate controller pad and alternate function |
| --- | --- | --- |
| 19 | GPIO 10 / MOSI | ITE8987 `GPC3` / `SMOSI` |
| 21 | GPIO 9 / MISO | ITE8987 `GPC5` / `SMISO` |
| 23 | GPIO 11 / SCK | ITE8987 `GPA6` / `SSCK` |

Source for the first two columns is the [supplied pin card transcription](Hackboard2-GPIO-pinout.txt). The remaining signals, including SPI chip selects on pins 24 and 26, still have unknown controller routing. The card does not establish logic voltage, mux state, or whether the EC firmware permits application control.

## Windows implications

Windows enumerates one healthy Microsoft ACPI-Compliant Embedded Controller, `ACPI\PNP0C09\1`. The main ACPI table declares it as `_SB.PCI0.SBRG.H_EC` and defines an `EmbeddedControl` operation region. `PNP0C09` is a generic ACPI identity. It establishes a firmware-managed EC on the host, while the system specification supplies the candidate chip model. The EC and the four Intel GPIO controllers should be investigated as separate hardware paths. No documented application-facing EC GPIO interface was identified in this pass. [Windows GPIO findings](Windows-Inventory.md)

## Evidence still needed

- Read the PCB revision and EC package marking. Use the board photos to orient the header and identify any accessible test pads or intervening components.
- Obtain the vendor's header-to-controller map, electrical limits, or a factory Linux image or GPIO package. The publicly available FCC exhibits include photographs. The applicant requested indefinite confidentiality for the schematic and block diagram. [FCC exhibits](https://fccid.io/2BAIC-N4P5000) · [Applicant confidentiality request](https://fcc.report/FCC-ID/2baicn4p5000/6586620.pdf)
- Inspect any factory GPIO package offline to learn whether it uses the embedded controller, Intel GPIO, or both. Preserve firmware ownership while investigating. Verify a candidate route through a schematic or an unpowered continuity check where accessible, then establish the pin's electrical limits before attempting an input or output test.
