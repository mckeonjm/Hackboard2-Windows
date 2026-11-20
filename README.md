# Hackboard 2 GPIO on Windows

This project investigates how to access the Hackboard 2’s onboard 40-pin header from Windows. The goal is a documented, installable GPIO interface for .NET applications.

The API and examples will use conventions familiar to Raspberry Pi developers, with a pin reference that shows physical header numbers alongside the Raspberry Pi-style GPIO labels.

## Status

The project is in the research planning phase. The supplied pin map comes from the card shipped with this board and awaits electrical verification. Python is the first choice for small diagnostic probes. The .NET implementation will depend on the Windows hardware interface we can verify.

- [Supplied GPIO pin map](Research/Hackboard2-GPIO-pinout.txt)
- [Research plan and initial sources](Research/Research-Plan.md)
- [Windows inventory findings](Research/Windows-Inventory.md)
- [Header routing findings](Research/Header-Routing.md)
- [Draft implementation and release roadmap](Research/Project-Roadmap.md)
