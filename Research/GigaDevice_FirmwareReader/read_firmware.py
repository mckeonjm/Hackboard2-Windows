#!/usr/bin/env python3
"""Read the main array of a GD25Q80E using Raspberry Pi SPI0 CE0."""

import argparse
import hashlib
from pathlib import Path

SIZE = 1024 * 1024
CHUNK = 1024
JEDEC_ID = bytes.fromhex("c8 40 14")


def read_array(spi):
    result = bytearray()
    for address in range(0, SIZE, CHUNK):
        command = [0x03, *address.to_bytes(3, "big")]
        response = spi.xfer2(command + [0] * CHUNK)
        if len(response) != len(command) + CHUNK:
            raise OSError(f"Short SPI transfer at 0x{address:06x}")
        result.extend(response[len(command):])
    return result


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("output", type=Path, nargs="?", default=Path("firmware.bin"))
    parser.add_argument("--speed", type=int, default=500_000, help="SPI clock in Hz")
    args = parser.parse_args()
    if args.speed <= 0:
        parser.error("--speed must be positive")

    try:
        import spidev
    except ImportError:
        parser.exit(1, "Install python3-spidev and run with /usr/bin/python3.\n")

    if args.output.exists():
        parser.exit(1, f"Output already exists: {args.output}\n")

    try:
        spi = spidev.SpiDev()
        spi.open(0, 0)
        try:
            spi.mode = 0
            spi.max_speed_hz = args.speed
            chip_id = bytes(spi.xfer2([0x9F, 0, 0, 0])[1:])
            print(f"JEDEC ID: {chip_id.hex(' ')}", flush=True)
            if chip_id != JEDEC_ID:
                raise OSError("Expected c8 40 14. Check chip power, wiring and clip contact.")

            print("Reading flash, pass 1 of 2", flush=True)
            first = read_array(spi)
            print("Reading flash, pass 2 of 2", flush=True)
            second = read_array(spi)
        finally:
            spi.close()

        if first != second:
            offset = next(i for i, (a, b) in enumerate(zip(first, second)) if a != b)
            raise OSError(f"Reads disagree at 0x{offset:06x}. Check wiring and bus contention.")
        if first == b"\xff" * SIZE or first == b"\x00" * SIZE:
            raise OSError("Both reads are all FF or all 00. Check the setup before accepting a dump.")

        with args.output.open("xb") as output:
            try:
                output.write(first)
                output.flush()
            except OSError:
                args.output.unlink()
                raise
        print(f"Saved {len(first):,} bytes to {args.output}")
        print(f"SHA-256: {hashlib.sha256(first).hexdigest()}")
    except (OSError, OverflowError) as error:
        parser.exit(1, f"{error}\n")


if __name__ == "__main__":
    main()
