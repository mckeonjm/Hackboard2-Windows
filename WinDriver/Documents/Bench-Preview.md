# Hackboard 2 digital GPIO bench preview

This package uses a temporary ACPI table, Windows' built-in ACPI/WMI drivers, and a .NET 10 library. It targets the tested Hackboard 2 PCB PZ08C20045B0. The persistent output methods need live scope verification before beta release.

## Install or update

Use Administrator PowerShell. This procedure assumes the Hackboard test boot is already configured. For a first-time test boot, see [Microsoft's test-signing instructions](https://learn.microsoft.com/en-us/windows-hardware/drivers/install/the-testsigning-boot-configuration-option) and [ACPI test-table procedure](https://learn.microsoft.com/en-us/windows/apps/develop/devices-sensors/enable-usermode-access#compile-and-load-asl-with-acpitabldat).

Disconnect header wiring before restarting. If `ACPITABL.dat` already exists, confirm that it belongs to this project and preserve a copy before replacing it.

```powershell
Set-Location 'C:\SW_Dev\hackboard2-windows\WinDriver'
$table = Join-Path $env:windir 'System32\ACPITABL.dat'
if (Test-Path -LiteralPath $table) {
    $backup = Join-Path $PWD ('ACPITABL-before-preview-' + (Get-Date -Format 'yyyyMMdd-HHmmss') + '.dat')
    Copy-Item -LiteralPath $table -Destination $backup -ErrorAction Stop
}
Copy-Item .\Driver\HackboardGpio.aml $table -Force -ErrorAction Stop
```

Restart Windows, then run from Administrator PowerShell.

```powershell
Set-Location 'C:\SW_Dev\hackboard2-windows\WinDriver'
mofcomp.exe .\Driver\HackboardGpio.mof
if ($LASTEXITCODE -ne 0) { throw 'WMI registration failed.' }
dotnet run --project .\Example_Code\GpioBench.csproj
```

The example uses physical pin 31 and a 10 kΩ resistor. Confirm the pin holds high and low for several seconds **after each API call returns**. The last step checks that a pull-up raises the pad once input mode is restored. If a scope is available, observe both transitions and check for a brief unintended level when output is first enabled.

## Use from C#

```csharp
using Hackboard2.Gpio;

using var pin = GpioPin.Open(6, PinNumbering.GpioLabel);
pin.SetInput();
PinValue level = pin.Read();
pin.SetOutput(PinValue.High);
pin.Write(PinValue.Low);
pin.SetInput();
```

`Open(31)` selects the same contact by physical header number. An explicit initial value is required for output. Each read requests a fresh snapshot. Normal disposal requests input when necessary. A per-pin file lease excludes other applications using this library, including applications that address the same pin by its alternate numbering. Direct WMI callers and the research scripts bypass the lease.

## Known limits

- Persistent output needs bench confirmation. Firmware appears to enable output before writing the level, so a glitch-free mode transition has not been established.
- A crash, forced termination, or power transition can prevent managed cleanup. An output may remain driven until a subsequent input command or controller reset. Confirm the pin state before reusing it after a failed write.
- The preview exposes the 25 contacts that passed both electrical pulse tests. Earlier snapshot reads disagreed with the meter on some contacts. Physical pins 27, 28, and 40 are outside the C# preview.
- Pull controls, edge interrupts, hardware buses, PWM, and normal-boot deployment are outside this digital bench preview.

## Rollback

Close programs using GPIO and disconnect the bench wiring. Restore the saved test table and re-register its matching MOF to return to the research setup. To remove the test setup entirely, remove the project-owned `ACPITABL.dat`, remove its WMI class in Administrator Windows PowerShell with `([wmiclass]'\\.\root\wmi:Hackboard2_Pin31Test').Delete()`, and restore the original test-signing setting before restarting. Restore any boot security settings changed during initial setup.
