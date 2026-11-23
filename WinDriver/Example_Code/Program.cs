using Hackboard2.Gpio;

try
{
    using var pin = GpioPin.Open(6, PinNumbering.GpioLabel);
    Wait("Connect a 10 kOhm resistor from physical pin 31 to ground. Verify near 0 V, then press Enter.");
    pin.SetInput();
    Console.WriteLine($"Input with pull-down: {pin.Read()}.");
    pin.SetOutput(PinValue.High);
    Wait("The high command returned. Verify pin 31 stays near 3.3 V for several seconds, then press Enter.");
    pin.Write(PinValue.Low);
    Wait("Move the resistor ground end to physical pin 17 (3.3 V). Verify pin 31 stays near 0 V for several seconds, then press Enter.");
    pin.SetInput();
    Console.WriteLine($"Input with pull-up after release: {pin.Read()}.");
    Console.WriteLine("Verify pin 31 rises with the pull-up, then remove the resistor.");
    return 0;
}
catch (Exception ex)
{
    Console.Error.WriteLine($"GPIO bench test failed: {ex.Message}");
    return 1;
}

static void Wait(string instruction)
{
    Console.WriteLine(instruction);
    if (Console.ReadLine() is null) { throw new InvalidOperationException("Interactive input is required."); }
}
