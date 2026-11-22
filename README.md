# Hackboard 2 GPIO on Windows

This project investigates how to access the Hackboard 2’s onboard 40-pin header from Windows. The goal is a documented, installable GPIO interface for .NET applications.

The API and examples will use conventions familiar to Raspberry Pi developers, with a pin reference that shows physical header numbers alongside the Raspberry Pi-style GPIO labels.

## Status

On one Hackboard 2, Windows diagnostics verified input, drive-low, drive-high, and release to input on physical pin 31 (GPIO6). The C# prototype passed a live read and now exposes both pulse operations. These experiments use a temporary ACPI table and Windows' built-in ACPI/WMI drivers. Installation on a normal Windows boot remains open.

- [Supplied GPIO pin map](Research/Hackboard2-GPIO-pinout.txt)
- [Research plan and initial sources](Research/Research-Plan.md)
- [Windows inventory findings](Research/Windows-Inventory.md)
- [Header routing findings](Research/Header-Routing.md)
- [Firmware analysis and Windows input test](Research/ITE-Firmware-Analysis.md)
- [C# GPIO6 reader prototype](Research/Pin31Reader)
- [Draft implementation and release roadmap](Research/Project-Roadmap.md)
