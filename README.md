# Hackboard 2 GPIO on Windows

This hobby beta brings Raspberry Pi-style digital GPIO to the Hackboard 2’s onboard 40-pin header on Windows. The .NET 10 library lets a C# application select a pin by physical header number or by the GPIO label on the card, read an input, or hold an output high or low until the application changes it or returns the pin to input.

# How this came to be and things you should know
I was an original backer of the Hackboard2 because I thought it would be cool to have a Raspberry Pi style board with GPIO that ran Windows.
When I finally received the board, like many, I was quite let down to find no software support for using the GPIO pins.
I reached out to Hackboard support and got no response.  That's when the board went in a drawer for several years.

Now, you should know - I am not a hardware guy.  I don't have a computer engineering, electrical engineering, or even computer science degree.  I have
a business degree.  I write business applications using high level languages.  I do a tiny bit of electrical circuit work for fun - things like Arduino and
Raspberry Pi basic projects.

It occurred to me on a whim that AI has gotten pretty darn good and it might be fun to see what would happen if I installed Codex on the Hackboard2, gave it
full access, and asked it to figure it out.  Well - it wasn't quite that simple but it did do an amazing job at guiding me through investigating and testing
to gather the information needed to get some functionality up and running.  If you look in the Research folder of this project, you'll see the fruits of that work.

In the past some people have noticed that you can see two Intel GPIO controllers as available ACPI devices on the system.  It turns out those have nothing
to do with the GPIO header on the Hackboard2.  Instead there is an ITE IT8987E embedded controller that is what the GPIO header pins are wired to.  That
EC gets its operating code from a GigaDevice 25Q80ES1G chip.  I read the code off of that chip and that's how the AI was able to figure out how to send commands to the ITE chip and pins.  

I mapped the header pins to the ITE pins manually with a multimeter and then verified the mapping with software tests.

The Hackboard2 comes with a chart that labels the pins - for example Pin 11 is GPIO 17.  Some pins, for example pin 5 which is GPIO 3, also have a secondary function.  In this case SCL.  I have not done any work to decode how to use or test any of those functions.

Currently this code only works for digital functions.  I would love to expand it in the future.

Note: header pins 27 and 28, labeled GPIO 0 and 1 respectively, are not wired to the ITE chip.  I have not figured out any way to use them.  Also pin 40 (GPIO 21) is wired to the chip but has something funky about how it is addressed so this code doesn't currently work with it.

Finally, I'm just a guy, so creating signed Windows drivers that you just install is beyond my scope.  The installation instructions here tell you how to set up test drivers on Windows.  It's a few steps but nothing crazy.

Finally, I make no guarantees that any of this works or that it won't screw up your Hackboard2.  Use it all at your own risk.  It's mostly made by AI and overseen buy a non-hardware guy who barely knows how any of it works.  You've been warned.

## Getting started

Follow the [installation and rollback guide](WinDriver/Documents/Bench-Preview.md) to install the temporary ACPI table and register the WMI interface. The beta uses Windows’ built-in ACPI/WMI drivers and requires a test boot and Administrator PowerShell for the example. MOF registration persists across reboots. Run it on installation and when the schema changes.

To use GPIO from your own .NET 10 Windows project, add a project reference to the [C# library](WinDriver/CSLibrary/HackboardGpio.csproj). The [C# bench example](WinDriver/Example_Code/Program.cs) uses the same library and walks through input, sustained high and low output, and release on GPIO6 (physical pin 31).

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
