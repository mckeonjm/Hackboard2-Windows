# Read the Hackboard 2 SPI flash with a Raspberry Pi 4B

The `25Q80ES1G` marking is consistent with the GigaDevice GD25Q80E. The GD25Q80E uses a 2.7–3.6 V supply and has a 1,048,576-byte main flash array. The script checks for JEDEC ID `c8 40 14` before dumping it. The dump captures the contents of this flash chip. Its role in booting the IT8987E remains unverified. [GigaDevice datasheet](https://cdn.ozdisan.com/public/product/assets/GD25Q80E-GIGADEVICE.pdf)

## Power and the shared SPI bus

Disconnect the Hackboard from power and any peripherals that could feed it power. Shut down and unplug the Pi before fitting the clip or changing wiring. Use 3.3 V logic throughout. Keep the Pi's 5 V pins away from the clip.

The soldered flash shares its power rail and SPI lines with the Hackboard. Applying 3.3 V at flash pin 8 can feed other components, and the IT8987E can drive the same lines as the Pi. An unplugged board alone does not establish that the flash rail is isolated or that the SPI lines are high impedance. Use the Pi's 3.3 V supply only for an electrically isolated flash, for example with the chip removed and held in a clip or mounted on an adapter. For an in-circuit read, first establish from the board circuitry that the flash can be safely powered and that the controller leaves the SPI lines high impedance. Use a current-limited 3.3 V source for externally powering an in-circuit flash and join its ground to Pi ground. Leave the Pi's 3.3 V header disconnected in that setup. If you cannot establish those conditions, read the chip off-board.

## Clip wiring

Find the chip's pin-1 dot or dimple and use a multimeter in continuity mode to map the clip contacts to the loose leads while everything is unpowered. Use the pin-1 mark to orient the clip. Keep the leads short. The numbers in the Pi column are **physical header pin numbers**. [Raspberry Pi SPI0 header mapping](https://www.raspberrypi.com/documentation/computers/raspberry-pi.html#spi)

```text
GD25Q80E top view
           ┌───────┐
 CS#   1 ──┤●      ├── 8  VCC
 SO    2 ──┤       ├── 7  HOLD#
 WP#   3 ──┤       ├── 6  SCLK
 GND   4 ──┤       ├── 5  SI
           └───────┘
```

| Flash pin | Signal | Connection |
|---|---|---|
| 1 | CS# | Pi pin 24, GPIO8 / SPI0 CE0 |
| 2 | SO / IO1 | Pi pin 21, GPIO9 / SPI0 MISO |
| 3 | WP# / IO2 | Pull up to flash VCC through 10 kΩ |
| 4 | GND | Pi pin 6, ground |
| 5 | SI / IO0 | Pi pin 19, GPIO10 / SPI0 MOSI |
| 6 | SCLK | Pi pin 23, GPIO11 / SPI0 SCLK |
| 7 | HOLD# / IO3 | Pull up to flash VCC through a separate 10 kΩ resistor |
| 8 | VCC | Pi pin 1 (3.3 V) for isolated flash, or the verified in-circuit supply described above |

For an isolated chip, add a 10 kΩ pull-up from CS# to flash VCC so it stays deselected during Pi startup. On an in-circuit chip, existing pull-ups can serve the same purpose if verified. Check clip alignment and adjacent contacts before powering up. With power applied, measure between flash pins 8 and 4 to verify the supply is near 3.3 V.

## Capture the flash

On Raspberry Pi OS, enable SPI and install the Python binding.

```sh
sudo raspi-config nonint do_spi 0
sudo apt install python3-spidev
sudo reboot
```

From this project directory after reboot, check for SPI0 CE0 and run the reader.

```sh
ls -l /dev/spidev0.0
/usr/bin/python3 read_firmware.py firmware.bin
```

The reader sends only JEDEC ID (`0x9F`) and array read (`0x03`) commands. It saves a new file after two full reads match and prints the SHA-256. For an independent check at a lower clock, use a second filename.

```sh
/usr/bin/python3 read_firmware.py --speed 100000 firmware-slow.bin
cmp firmware.bin firmware-slow.bin
```

A successful `cmp` prints nothing. If the ID is all `ff` or `00`, or the two reads disagree, power down and check orientation, VCC, ground, clip contact, and whether the ITE is sharing or driving the bus. If the device node is missing, revisit the SPI setting and reboot. If the device exists but opening it fails with a permission error, run the reader with `sudo /usr/bin/python3` or use an account with access to that device.
