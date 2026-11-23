[CmdletBinding()]
param(
    [ValidateRange(2, 30)]
    [int] $Samples = 6,

    [int[]] $Pin,

    [switch] $All
)

$ErrorActionPreference = 'Stop'
$mappedPins = @(3, 5, 7, 8, 10, 11, 12, 13, 15, 16, 18, 19, 21, 22, 23, 24, 26, 29, 31, 32, 33, 35, 36, 37, 38, 40)
if ($All -and $PSBoundParameters.ContainsKey('Pin')) { throw 'Choose either -All or -Pin.' }
if ($All) { $Pin = $mappedPins }
elseif (!$PSBoundParameters.ContainsKey('Pin')) { $Pin = @(7, 11) }
foreach ($requestedPin in $Pin) {
    if ($requestedPin -notin $mappedPins) { throw "Physical pin $requestedPin has no mapped EC selector." }
}

$log = Join-Path $PSScriptRoot 'input-initialization-results.txt'
$devices = @(Get-CimInstance -Namespace root/wmi -ClassName Hackboard2_Pin31Test)
if ($devices.Count -ne 1) { throw "Expected one Hackboard test device. Found $($devices.Count)." }

function Write-TestResult {
    param([string] $Message)
    Add-Content -LiteralPath $log -Encoding UTF8 -Value $Message
    Write-Host $Message
}

function Read-BenchVoltage {
    param([string] $Instruction)
    Write-Host $Instruction
    do {
        $entry = (Read-Host 'Enter measured voltage in V (e.g. 3.0) and press Enter, or Q to stop').Trim()
        if ($entry -eq 'Q') { return }
        $voltage = 0.0
        $valid = [double]::TryParse($entry, [Globalization.NumberStyles]::Float,
            [Globalization.CultureInfo]::InvariantCulture, [ref] $voltage) -and
            ![double]::IsNaN($voltage) -and ![double]::IsInfinity($voltage)
    } until ($valid)
    return $entry
}

function Write-SnapshotSeries {
    param([string] $Phase, [string] $Voltage, [int] $ByteIndex, [int] $Mask)

    Write-TestResult "$Phase | measured=$Voltage V"
    for ($index = 1; $index -le $Samples; $index++) {
        $trace = Invoke-CimMethod -InputObject $devices[0] -MethodName ReadSnapshotTrace
        if ($null -eq $trace.Status) { throw 'The EC snapshot returned no status.' }
        if ($trace.Status -ne 0) {
            Write-TestResult "  $index/$Samples | EC status=$($trace.Status)"
            continue
        }

        $bytes = [byte[]] @(foreach ($field in 'Data0', 'Data1', 'Data2', 'Data3') {
            if ($null -eq $trace.$field) { throw "The EC snapshot returned no $field." }
            [BitConverter]::GetBytes([uint32] $trace.$field)
        })
        $before = [BitConverter]::ToString($bytes, 0, 5)
        $during = [BitConverter]::ToString($bytes, 5, 5)
        $after = [BitConverter]::ToString($bytes, 10, 5)
        $state = if ($bytes[10 + $ByteIndex] -band $Mask) { 'HIGH' } else { 'LOW' }
        Write-TestResult "  $index/$Samples | read=$state | before=$before during=$during after=$after"
    }
}

Write-TestResult ""
Write-TestResult "Input initialization run $([DateTimeOffset]::Now.ToString('o'))"
Write-Host "Results append to $log"
try {
    foreach ($physicalPin in $Pin) {
        $bit = $physicalPin - 1
        $byteIndex = $bit -shr 3
        $mask = 1 -shl ($bit % 8)
        Write-TestResult "Physical pin $physicalPin | EC 0x$('{0:X2}' -f (0x44 + $byteIndex)) mask 0x$('{0:X2}' -f $mask)"

        $voltage = Read-BenchVoltage "Disconnect the resistor from any previous pin. Connect a 10 kOhm resistor between physical pins 17 (3.3 V) and $physicalPin. Measure pin $physicalPin relative to header ground."
        if ($null -eq $voltage) { Write-TestResult "Stopped at pin $physicalPin"; return }
        Write-SnapshotSeries 'Before initialization, pull-up' $voltage $byteIndex $mask

        $voltage = Read-BenchVoltage "Move the resistor from pin 17 to verified header ground, leaving its other end on pin $physicalPin. Measure pin $physicalPin."
        if ($null -eq $voltage) { Write-TestResult "Stopped at pin $physicalPin"; return }
        Write-SnapshotSeries 'Before initialization, pull-down' $voltage $byteIndex $mask

        $response = Invoke-CimMethod -InputObject $devices[0] -MethodName "ConfigurePin${physicalPin}Input"
        if ($null -eq $response.Result) { throw 'The input-mode command returned no result.' }
        Write-TestResult ('Input-mode command | response=0x{0:X2}' -f $response.Result)
        if ($response.Result -ne 0x55) { throw "The EC did not acknowledge input mode for pin $physicalPin." }

        $voltage = Read-BenchVoltage "Keep the pull-down connected to pin $physicalPin. Measure pin $physicalPin again."
        if ($null -eq $voltage) { Write-TestResult "Stopped at pin $physicalPin"; return }
        Write-SnapshotSeries 'After initialization, pull-down' $voltage $byteIndex $mask

        $voltage = Read-BenchVoltage "Move the resistor from ground to physical pin 17 (3.3 V), leaving its other end on pin $physicalPin. Measure pin $physicalPin again."
        if ($null -eq $voltage) { Write-TestResult "Stopped at pin $physicalPin"; return }
        Write-SnapshotSeries 'After initialization, pull-up' $voltage $byteIndex $mask
    }
    Write-TestResult 'Run complete'
} catch {
    Write-TestResult "Run interrupted: $($_.Exception.Message)"
    throw
} finally {
    Write-Host 'Disconnect the resistor when finished.'
}
