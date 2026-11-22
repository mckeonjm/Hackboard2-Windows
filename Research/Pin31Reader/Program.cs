using System.Management;
using Hackboard2;

if (args.Length > 1 || (args.Length == 1 && args[0] is not ("pulse-low" or "pulse-high")))
{
    Console.Error.WriteLine("Usage: Pin31Reader [pulse-low|pulse-high]");
    return 2;
}

try
{
    if (args.Length == 0)
    {
        Console.WriteLine($"GPIO6 (physical pin 31): {HackboardGpio.Read(6)}");
    }
    else
    {
        var value = args[0] == "pulse-low" ? PinValue.Low : PinValue.High;
        HackboardGpio.Pulse(6, value);
        Console.WriteLine($"GPIO6 (physical pin 31): {value} pulse and input release acknowledged.");
    }
    return 0;
}
catch (Exception ex) when (ex is ManagementException or UnauthorizedAccessException
    or InvalidOperationException or TimeoutException)
{
    Console.Error.WriteLine($"GPIO operation failed: {ex.Message}");
    return 1;
}
