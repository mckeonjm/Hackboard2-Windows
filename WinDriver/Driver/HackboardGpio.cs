using System.Management;

namespace Hackboard2.Gpio;

public enum PinValue { Low, High }
public enum PinNumbering { Physical, GpioLabel }

public sealed class GpioPin : IDisposable
{
    private static readonly IReadOnlyDictionary<int, int> LabelToPhysical =
        new Dictionary<int, int>
        {
            [2] = 3, [3] = 5, [4] = 7, [14] = 8, [15] = 10,
            [17] = 11, [18] = 12, [27] = 13, [22] = 15, [23] = 16,
            [24] = 18, [10] = 19, [9] = 21, [25] = 22, [11] = 23,
            [8] = 24, [7] = 26, [5] = 29, [6] = 31, [12] = 32,
            [13] = 33, [19] = 35, [16] = 36, [26] = 37, [20] = 38
        };

    private readonly object gate = new();
    private readonly FileStream lease;
    private bool disposed;
    private bool needsRelease;
    private bool input;
    private bool output;

    private GpioPin(int physicalPin, FileStream lease)
    {
        PhysicalPin = physicalPin;
        this.lease = lease;
    }

    public int PhysicalPin { get; }

    public static GpioPin Open(int pin, PinNumbering numbering = PinNumbering.Physical)
    {
        var physicalPin = numbering switch
        {
            PinNumbering.Physical when LabelToPhysical.Values.Contains(pin) => pin,
            PinNumbering.GpioLabel when LabelToPhysical.TryGetValue(pin, out int physical) => physical,
            _ => throw new ArgumentOutOfRangeException(nameof(pin), "Unsupported header pin or numbering scheme.")
        };

        var directory = Path.Combine(
            Environment.GetFolderPath(Environment.SpecialFolder.CommonApplicationData),
            "Hackboard2", "GpioLeases");
        Directory.CreateDirectory(directory);
        try
        {
            var lease = new FileStream(Path.Combine(directory, $"pin-{physicalPin}.lock"),
                FileMode.OpenOrCreate, FileAccess.ReadWrite, FileShare.None);
            return new GpioPin(physicalPin, lease);
        }
        catch (IOException ex)
        {
            throw new IOException($"Could not claim physical pin {physicalPin}. Check for another GPIO application.", ex);
        }
    }

    public void SetInput()
    {
        lock (gate)
        {
            ObjectDisposedException.ThrowIf(disposed, this);
            ReleaseToInput();
        }
    }

    public void SetOutput(PinValue initialValue)
    {
        lock (gate)
        {
            ObjectDisposedException.ThrowIf(disposed, this);
            Drive(initialValue);
        }
    }

    public void Write(PinValue value)
    {
        lock (gate)
        {
            ObjectDisposedException.ThrowIf(disposed, this);
            if (!output) { throw new InvalidOperationException("Call SetOutput before writing."); }
            Drive(value);
        }
    }

    public PinValue Read()
    {
        lock (gate)
        {
            ObjectDisposedException.ThrowIf(disposed, this);
            if (!input) { throw new InvalidOperationException("Call SetInput before reading."); }
            using var result = Invoke($"ReadPin{PhysicalPin}Level");
            return ReadUInt32(result, "Result") switch
            {
                0 => PinValue.Low,
                1 => PinValue.High,
                var status => throw new InvalidOperationException($"GPIO read failed with EC status 0x{status:X2}.")
            };
        }
    }

    public void Dispose()
    {
        lock (gate)
        {
            if (disposed) { return; }
            try
            {
                if (needsRelease) { ReleaseToInput(); }
            }
            finally
            {
                disposed = true;
                lease.Dispose();
            }
        }
    }

    private void Drive(PinValue value)
    {
        var level = value switch
        {
            PinValue.Low => "Low",
            PinValue.High => "High",
            _ => throw new ArgumentOutOfRangeException(nameof(value))
        };
        // A failed invocation may have reached the hardware.
        needsRelease = true;
        input = false;
        output = false;
        RequireAcknowledgment($"SetPin{PhysicalPin}{level}");
        output = true;
    }

    private void ReleaseToInput()
    {
        needsRelease = true;
        input = false;
        output = false;
        RequireAcknowledgment($"ConfigurePin{PhysicalPin}Input");
        input = true;
        needsRelease = false;
    }

    private static void RequireAcknowledgment(string method)
    {
        using var result = Invoke(method);
        uint status = ReadUInt32(result, "Result");
        if (status != 0x55)
        {
            throw new InvalidOperationException($"{method} failed with EC status 0x{status:X2}.");
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

}
