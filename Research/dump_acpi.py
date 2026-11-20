"""Capture the first ACPI table of each listed signature using Win32."""

import ctypes
from ctypes import wintypes
from pathlib import Path


def main():
    kernel32 = ctypes.WinDLL("kernel32", use_last_error=True)
    enumerate_tables = kernel32.EnumSystemFirmwareTables
    enumerate_tables.argtypes = (wintypes.DWORD, wintypes.LPVOID, wintypes.DWORD)
    enumerate_tables.restype = wintypes.UINT
    get_table = kernel32.GetSystemFirmwareTable
    get_table.argtypes = (
        wintypes.DWORD, wintypes.DWORD, wintypes.LPVOID, wintypes.DWORD
    )
    get_table.restype = wintypes.UINT
    provider = int.from_bytes(b"ACPI", "big")
    signatures = read_buffer(enumerate_tables, provider)
    if len(signatures) % 4:
        raise ValueError("Invalid ACPI signature list length")

    output = Path(__file__).resolve().parent / "local" / "acpi"
    output.mkdir(parents=True, exist_ok=True)
    seen = set()
    for offset in range(0, len(signatures), 4):
        signature = signatures[offset:offset + 4]
        if signature in seen:
            print(f"{signature!r}: duplicate signature, Win32 returns the first table")
            continue
        seen.add(signature)
        if signature not in (b"DSDT", b"SSDT", b"FACP"):
            continue
        try:
            data = read_buffer(get_table, provider, int.from_bytes(signature, "little"))
        except OSError as error:
            print(f"{signature!r}: {error}")
            continue
        name = signature.decode("ascii")
        (output / f"{name}.bin").write_bytes(data)
        print(f"{name}: {len(data)} bytes")


def read_buffer(function, *arguments):
    size = function(*arguments, None, 0)
    if not size:
        raise ctypes.WinError(ctypes.get_last_error())
    buffer = ctypes.create_string_buffer(size)
    actual = function(*arguments, buffer, size)
    if not actual:
        raise ctypes.WinError(ctypes.get_last_error())
    if actual > size:
        raise ValueError("Firmware table size changed during capture")
    return buffer.raw[:actual]


if __name__ == "__main__":
    main()
