# Hackboard 2 GPIO on Windows

This hobby beta brings Raspberry Pi-style digital GPIO to the Hackboard 2’s onboard 40-pin header on Windows. The .NET 10 library lets a C# application select a pin by physical header number or by the GPIO label on the card, read an input, or hold an output high or low until the application changes it or returns the pin to input.

## Getting started

Follow the [installation and rollback guide](WinDriver/Documents/Bench-Preview.md) to install the temporary ACPI table and register the WMI interface. The beta uses Windows’ built-in ACPI/WMI drivers and requires a test boot and Administrator PowerShell for the example. MOF registration persists across reboots. Run it on installation and when the schema changes.

The [C# bench example](WinDriver/Example_Code/Program.cs) walks through input, sustained high and low output, and release on GPIO6 (physical pin 31).

```csharp
using Hackboard2.Gpio;

using var pin = GpioPin.Open(6, PinNumbering.GpioLabel);
pin.SetInput();
PinValue level = pin.Read();
pin.SetOutput(PinValue.High);
// The pin holds its level while the application does other work.
pin.Write(PinValue.Low);
pin.SetInput();
```

## Beta status and limitations

- **Bench verified on PCB PZ08C20045B0.** Windows diagnostics drove high, drove low, and returned to baseline on 25 contacts. A live C# input read was verified on pin 31. The sustained-output implementation and example build successfully. Sustained output and the transition into output mode still need scope verification.
- **Input reliability.** Each read requests a fresh EC snapshot. A targeted test on pins 7 and 11 matched the meter in all 48 readings, while the broader bench run recorded intermittent disagreements.
- **Supported scope.** The library exposes the 25 pulse-verified contacts. See the [header map](Research/Header-Continuity-Map.md) for numbering. Physical pins 27 and 28 have unknown routes. Pin 40 showed no physical output pulse.
- **Cleanup and deployment.** Normal disposal requests input mode after driving a pin. Forced termination can leave an output driven. Normal-boot deployment, configurable pulls, edge events, and hardware I²C, SPI, UART, and PWM remain outside this beta.

## Research and bench records

- [Supplied GPIO pin map](Research/Hackboard2-GPIO-pinout.txt)
- [Research plan and initial sources](Research/Research-Plan.md)
- [Windows inventory findings](Research/Windows-Inventory.md)
- [Header routing findings](Research/Header-Routing.md)
- [Full header continuity map](Research/Header-Continuity-Map.md)
- [Full header bench results](Research/Header-Bench-Results.md)
- [Header capability assessment](Research/Header-Capabilities.md)
- [Firmware analysis and Windows input test](Research/ITE-Firmware-Analysis.md)
- [C# GPIO6 reader prototype](Research/Pin31Reader)
- [Draft implementation and release roadmap](Research/Project-Roadmap.md)
