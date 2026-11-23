using System.Diagnostics;
using Hackboard2.Gpio;

namespace HackboardGpioDemo;

internal sealed class MainForm : Form
{
    private const int LedPin = 31;
    private const int ButtonPin = 29;
    private static readonly TimeSpan BlinkInterval = TimeSpan.FromMilliseconds(500);
    private static readonly TimeSpan PollInterval = TimeSpan.FromMilliseconds(50);

    private readonly Button blinkButton = new() { Text = "Start blinking", Enabled = false, AutoSize = true };
    private readonly TextBox buttonState = new() { Text = "Connecting...", ReadOnly = true, Dock = DockStyle.Fill };
    private readonly CancellationTokenSource shutdown = new();
    private Task gpioLoop = Task.CompletedTask;
    private bool blinking;
    private bool closing;

    public MainForm()
    {
        Text = "Hackboard 2 GPIO";
        AutoScaleMode = AutoScaleMode.Font;
        ClientSize = new Size(320, 125);
        FormBorderStyle = FormBorderStyle.FixedDialog;
        MaximizeBox = false;

        var layout = new TableLayoutPanel
        {
            Dock = DockStyle.Fill,
            Padding = new Padding(12),
            ColumnCount = 1,
            RowCount = 3
        };
        layout.ColumnStyles.Add(new ColumnStyle(SizeType.Percent, 100));
        layout.RowStyles.Add(new RowStyle(SizeType.AutoSize));
        layout.RowStyles.Add(new RowStyle(SizeType.AutoSize));
        layout.RowStyles.Add(new RowStyle(SizeType.AutoSize));
        layout.Controls.Add(blinkButton, 0, 0);
        layout.Controls.Add(new Label { Text = "Physical pushbutton (pin 29)", AutoSize = true }, 0, 1);
        layout.Controls.Add(buttonState, 0, 2);
        Controls.Add(layout);

        blinkButton.Click += (_, _) =>
        {
            blinking = !blinking;
            blinkButton.Text = blinking ? "Stop blinking" : "Start blinking";
        };
        Shown += (_, _) => gpioLoop = RunGpioAsync(shutdown.Token);
        FormClosing += StopGpioBeforeClosing;
    }

    private async Task RunGpioAsync(CancellationToken cancellationToken)
    {
        try
        {
            using var led = GpioPin.Open(LedPin);
            using var pushbutton = GpioPin.Open(ButtonPin);
            bool ledSetupAttempted = false;
            try
            {
                await Task.Run(() =>
                {
                    pushbutton.SetInput();
                    ledSetupAttempted = true;
                    led.SetOutput(PinValue.Low);
                });

                blinkButton.Enabled = !cancellationToken.IsCancellationRequested;
                buttonState.Text = "Reading...";
                var phaseClock = Stopwatch.StartNew();
                bool ledOn = false;
                bool wasBlinking = false;
                PinValue? previousSample = null;

                while (!cancellationToken.IsCancellationRequested)
                {
                    bool shouldBlink = blinking;
                    bool nextLedOn = ledOn;
                    if (shouldBlink != wasBlinking)
                    {
                        nextLedOn = shouldBlink;
                    }
                    else if (shouldBlink && phaseClock.Elapsed >= BlinkInterval)
                    {
                        nextLedOn = !ledOn;
                    }

                    bool updateLed = nextLedOn != ledOn;
                    var sample = await Task.Run(() =>
                    {
                        if (updateLed)
                        {
                            led.Write(nextLedOn ? PinValue.High : PinValue.Low);
                        }

                        return pushbutton.Read();
                    });

                    if (updateLed)
                    {
                        phaseClock.Restart();
                    }

                    ledOn = nextLedOn;
                    wasBlinking = shouldBlink;

                    // Require two consecutive matching samples to suppress switch bounce.
                    if (sample == previousSample)
                    {
                        buttonState.Text = sample == PinValue.Low ? "Pressed" : "Released";
                    }

                    previousSample = sample;
                    await Task.Delay(PollInterval, cancellationToken);
                }
            }
            finally
            {
                // Release the output even if driving it low fails.
                await Task.Run(() =>
                {
                    try
                    {
                        if (ledSetupAttempted)
                        {
                            led.SetOutput(PinValue.Low);
                        }
                    }
                    finally
                    {
                        led.Dispose();
                        pushbutton.Dispose();
                    }
                });
            }
        }
        catch (OperationCanceledException) when (cancellationToken.IsCancellationRequested)
        {
        }
        catch (Exception ex)
        {
            blinkButton.Enabled = false;
            buttonState.Text = "GPIO unavailable";
            MessageBox.Show(this, ex.Message, "Hackboard GPIO error", MessageBoxButtons.OK, MessageBoxIcon.Error);
        }
    }

    private async void StopGpioBeforeClosing(object? sender, FormClosingEventArgs e)
    {
        if (gpioLoop.IsCompleted)
        {
            shutdown.Dispose();
            return;
        }

        e.Cancel = true;
        if (closing)
        {
            return;
        }

        closing = true;
        blinkButton.Enabled = false;
        shutdown.Cancel();
        await gpioLoop;
        Close();
    }
}
