# Hackboard 2 WinForms GPIO example

Click **Start blinking** to turn the LED on and begin blinking, with approximately 500 ms per on or off phase. Click **Stop blinking** to turn it off. The read-only text box shows **Pressed** or **Released** for the physical pushbutton whether or not the LED is blinking.

## Parts and wiring

Use a low-current red LED, a 2.2 kΩ series resistor, a 10 kΩ pull-up resistor, and a normally open momentary pushbutton. Shut down the Hackboard 2 and disconnect power before wiring. Locate pin 1 using the board marking or supplied pinout card. All numbers in the wiring diagram are **physical header positions**.

```text
Pin 31 (GPIO 6) ---- 2.2 kΩ ---- LED anode (+)
                                 LED cathode (-) ---- Pin 30 (GND)

Pin 17 (3.3 V) ----- 10 kΩ -----+---- Pin 29 (GPIO 5)
                                |
                        Normally open pushbutton
                                |
                                +---- Pin 30 (GND)
```

1. Connect pin 31 through the 2.2 kΩ resistor to the LED anode (usually the longer lead). Connect the LED cathode (usually the shorter lead on the flat side) to ground.
2. Connect the 10 kΩ resistor between pin 17 and pin 29. Connect the switch between pin 29 and ground. For a four-leg tactile switch, use terminals from different contact pairs. Check with a continuity meter that the selected terminals connect only while pressed.
3. Use pin 30 for ground, or another ground contact from the [header pinout](../Research/Hackboard2-GPIO-pinout.txt). Use the 3.3 V header supply for the pull-up. Pins 2 and 4 carry 5 V and should be left disconnected.

The resistor pulls pin 29 high when the switch is open. Pressing the switch connects pin 29 to ground, so a low reading means **Pressed**.

## Build and run

Install the .NET 10 SDK and set up the Hackboard GPIO ACPI table and WMI registration using the [bench preview instructions](../WinDriver/Documents/Bench-Preview.md). The app references the GPIO library in this repository. Close any GPIO bench programs before running it.

Open PowerShell as Administrator on the Hackboard so the app can access the GPIO WMI provider. From the repository root, run the following command.

```powershell
dotnet run --project .\WinForms_Example\HackboardGpioDemo.csproj
```

Check that the text box starts at **Released** with the switch open, changes to **Pressed** when held, and returns to **Released** when released. Start the LED and repeat the switch test while it blinks. Stop the blink and verify that the LED stays dark. Start it again and close the window to verify that the LED turns off during shutdown.

The app uses the bench preview's persistent output methods. Their behavior under load still needs verification on the Hackboard. If the app reports a GPIO error at startup, check the ACPI table and WMI setup and confirm that another program does not have either pin open.

### If the text box says GPIO unavailable

Check the error dialog for the underlying error. If it says **Access denied**, launch the app from Administrator PowerShell. If it reports an invalid WMI class, an unavailable test device, or a missing GPIO method, check that the installed ACPI table matches the current preview:

```powershell
Get-FileHash "$env:windir\System32\ACPITABL.dat", .\WinDriver\Driver\HackboardGpio.aml
```

If the hashes differ, follow the [bench preview update procedure](../WinDriver/Documents/Bench-Preview.md#install-or-update) to back up the existing table, install the preview table, restart Windows, and register the matching MOF.
