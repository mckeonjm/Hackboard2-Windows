using System.Management;

namespace Hackboard2;

public enum PinValue
{
    Low,
    High
}

public static class HackboardGpio
{
    public static PinValue Read(int gpioNumber)
    {
        ArgumentOutOfRangeException.ThrowIfNotEqual(gpioNumber, 6);

        using var result = Invoke("ReadSnapshotTrace");
        var status = ReadUInt32(result, "Status");
        if (status != 0)
        {
            throw ControllerError(status);
        }

        // Data3 byte 1 is EC register 0x47. The board trace verified mask 0x40.
        return (ReadUInt32(result, "Data3") & 0x4000u) == 0 ? PinValue.Low : PinValue.High;
    }

    /// <summary>
    /// Drives GPIO6 for about one second, then requests input mode.
    /// The bench setup must weakly bias the pin to the opposite level before the call.
    /// </summary>
    public static void Pulse(int gpioNumber, PinValue value)
    {
        ArgumentOutOfRangeException.ThrowIfNotEqual(gpioNumber, 6);

        var method = value switch
        {
            PinValue.Low => "TestPin31Output",
            PinValue.High => "TestPin31OutputHigh",
            _ => throw new ArgumentOutOfRangeException(nameof(value))
        };

        using var result = Invoke(method);
        var response = ReadUInt32(result, "Result");
        if (response <= 6)
        {
            throw ControllerError(response);
        }

        var drive = response & 0xFF;
        var release = (response >> 8) & 0xFF;
        if (drive != 0x55 || release != 0x55)
        {
            throw new InvalidOperationException(
                $"The embedded controller did not acknowledge both operations. Drive=0x{drive:X2}, release=0x{release:X2}.");
        }
    }

    private static ManagementBaseObject Invoke(string method)
    {
        using var searcher = new ManagementObjectSearcher(
            @"root\wmi", "SELECT * FROM Hackboard2_Pin31Test");
        using var devices = searcher.Get();
        using var enumerator = devices.GetEnumerator();
        if (!enumerator.MoveNext())
        {
            throw new InvalidOperationException("The Hackboard GPIO test device is unavailable.");
        }

        using var device = (ManagementObject)enumerator.Current;
        if (enumerator.MoveNext())
        {
            using var extraDevice = enumerator.Current;
            throw new InvalidOperationException("More than one Hackboard GPIO test device was found.");
        }

        return device.InvokeMethod(method, null, null)
            ?? throw new InvalidOperationException($"WMI method {method} returned no result.");
    }

    private static uint ReadUInt32(ManagementBaseObject result, string name) =>
        result[name] is uint value
            ? value
            : throw new InvalidOperationException($"The GPIO operation returned no valid {name}.");

    private static Exception ControllerError(uint status) => status switch
    {
        2 => new InvalidOperationException("The embedded controller is unavailable."),
        3 => new InvalidOperationException("The embedded controller mailbox is busy or the request was interrupted."),
        4 => new TimeoutException("Timed out waiting for the embedded controller mutex."),
        5 => new InvalidOperationException("The requested method is unavailable in the installed test table."),
        6 => new InvalidOperationException("The pin did not read the required opposite level before the pulse."),
        _ => new InvalidOperationException($"Unexpected GPIO status {status}.")
    };
}
