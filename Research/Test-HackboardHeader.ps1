[CmdletBinding()]
param(
    [int[]] $Pin,

    [int] $StartAt,

    [string] $LogPath
)

$ErrorActionPreference = 'Stop'
if (-not $PSBoundParameters.ContainsKey('LogPath')) {
    $LogPath = Join-Path $PSScriptRoot 'header-test-results.txt'
}

$pinDetails = @{
    3 = @{ Label = 'GPIO 2 (SDA)'; Selector = 3 }
    5 = @{ Label = 'GPIO 3 (SCL)'; Selector = 5 }
    7 = @{ Label = 'GPIO 4 (GPCLK0)'; Selector = 7 }
    8 = @{ Label = 'GPIO 14 (TXD)'; Selector = 8 }
    10 = @{ Label = 'GPIO 15 (RXD)'; Selector = 10 }
    11 = @{ Label = 'GPIO 17'; Selector = 11 }
    12 = @{ Label = 'GPIO 18 (PCM_CLK)'; Selector = 12 }
    13 = @{ Label = 'GPIO 27'; Selector = 13 }
    15 = @{ Label = 'GPIO 22'; Selector = 15 }
    16 = @{ Label = 'GPIO 23'; Selector = 16 }
    18 = @{ Label = 'GPIO 24'; Selector = 18 }
    19 = @{ Label = 'GPIO 10 (MOSI)'; Selector = 19 }
    21 = @{ Label = 'GPIO 9 (MISO)'; Selector = 21 }
    22 = @{ Label = 'GPIO 25'; Selector = 22 }
    23 = @{ Label = 'GPIO 11 (SCK)'; Selector = 23 }
    24 = @{ Label = 'GPIO 8 (CE0)'; Selector = 24 }
    26 = @{ Label = 'GPIO 7 (CE1)'; Selector = 26 }
    27 = @{ Label = 'GPIO 0 (ID_SD)' }
    28 = @{ Label = 'GPIO 1 (ID_SC)' }
    29 = @{ Label = 'GPIO 5'; Selector = 29 }
    31 = @{ Label = 'GPIO 6'; Selector = 31 }
    32 = @{ Label = 'GPIO 12 (PWM0)'; Selector = 32 }
    33 = @{ Label = 'GPIO 13 (PWM1)'; Selector = 33 }
    35 = @{ Label = 'GPIO 19 (PCM_FS)'; Selector = 35 }
    36 = @{ Label = 'GPIO 16'; Selector = 36 }
    37 = @{ Label = 'GPIO 26'; Selector = 37 }
    38 = @{ Label = 'GPIO 20 (PCM_DIN)'; Selector = 38 }
    40 = @{ Label = 'GPIO 21 (PCM_DOUT)'; Selector = 40 }
}

if (!$PSBoundParameters.ContainsKey('Pin')) {
    $Pin = @($pinDetails.Keys | Sort-Object)
}
foreach ($requestedPin in $Pin) {
    if (!$pinDetails.ContainsKey($requestedPin)) {
        throw "Physical pin $requestedPin is not a header signal in this test."
    }
}
if ($PSBoundParameters.ContainsKey('StartAt')) {
    $startIndex = [Array]::IndexOf($Pin, $StartAt)
    if ($startIndex -lt 0) { throw "Physical pin $StartAt is not in the selected test sequence." }
    $Pin = $Pin[$startIndex..($Pin.Count - 1)]
}

$devices = @(Get-CimInstance -Namespace root/wmi -ClassName Hackboard2_Pin31Test)
if ($devices.Count -ne 1) { throw "Expected one Hackboard WMI device. Found $($devices.Count)." }

function Invoke-HeaderPinTests {
    param([int] $PhysicalPin)

    $details = $pinDetails[$PhysicalPin]
    $steps = @(
        @{ Name = 'Baseline'; Instruction = 'Disconnect accessories and the pull-up. Measure physical pin 19 relative to verified header ground.' }
        @{ Name = 'Pull-up'; Instruction = 'Connect a 10 kOhm resistor between physical pin 17 (3.3 V) and physical pin 19. Measure pin 19 and leave the resistor connected until the next prompt.' }
        @{ Name = 'Release'; Instruction = 'Remove the resistor. Measure pin 19 relative to the same ground.' }
        @{ Name = 'Drive high and release'; Method = 'TestPin19OutputHigh'; Expected = 'Rises, then returns to the starting voltage'; Instruction = 'Connect a 10 kOhm resistor from physical pin 19 to verified header ground. Note the starting voltage and arm the scope for a rising edge. Skip if the pin already starts near 3.3 V.' }
        @{ Name = 'Drive low and release'; Method = 'TestPin19OutputLow'; Expected = 'Falls, then returns to the starting voltage'; Instruction = 'Move the 10 kOhm resistor from ground to physical pin 17 (3.3 V), leaving the other end on pin 19. Note the starting voltage and arm the scope for a falling edge. Skip if pin 19 stays near 0 V.' }
        @{ Name = 'Input with pull-up after output'; Instruction = 'Confirm the 10 kOhm resistor connects physical pins 17 and 19. Measure pin 19.' }
        @{ Name = 'Input with pull-down after output'; Instruction = 'Move the resistor from pin 17 to verified header ground, leaving the other end on pin 19. Measure pin 19.' }
    )
    $hasSelector = $details.ContainsKey('Selector')
    if ($hasSelector) {
        $bit = $details.Selector - 1
        $byteIndex = $bit -shr 3
        $mask = 1 -shl ($bit % 8)
        $register = 0x44 + $byteIndex
    } else {
        $steps = @($steps[0])
    }

    $run = [DateTimeOffset]::Now.ToString('o')
    $mapping = if ($hasSelector) { 'selector {0} | EC 0x{1:X2} mask 0x{2:X2}' -f $details.Selector, $register, $mask } else { 'passive voltage only; EC selector unknown' }
    Add-Content -LiteralPath $LogPath -Encoding UTF8 -Value @('', "Run $run | physical pin $PhysicalPin | $($details.Label) | $mapping")
    Write-Host "Physical pin $PhysicalPin ($($details.Label)). Disconnect any attached peripherals before testing."
    if (!$hasSelector) { Write-Host 'Measure without a resistor. No EC operation targets this pin.' }
    if ($PhysicalPin -eq 40) { Write-Host 'Use the scope to judge output and release. EC 0x48 mask 0x80 is a read candidate.' }
    Write-Host "Results are appended to $LogPath"
    try {
        for ($index = 0; $index -lt $steps.Count; $index++) {
            $step = $steps[$index]
            Write-Host ""
            Write-Host "Step $($index + 1) of $($steps.Count) | $($step.Name)"
            Write-Host ($step.Instruction.Replace('19', [string] $PhysicalPin))

            $pulseFailed = $false
            $choices = @{
                'L' = 'Near 0 V'
                'H' = 'Near 3 V'
                'O' = 'Other voltage or unstable'
                'S' = 'Skipped'
            }
            $prompt = 'L Near 0 V | H Near 3 V | O Other | S Skip | Q Quit'
            if ($step.Method) {
                do {
                    $ready = (Read-Host 'With scope armed, enter starting voltage in V to pulse once (e.g. 1.7) | S Skip | Q Quit').Trim().ToUpperInvariant()
                    $startingVoltage = 0.0
                    $validVoltage = [double]::TryParse($ready, [Globalization.NumberStyles]::Float,
                        [Globalization.CultureInfo]::InvariantCulture, [ref] $startingVoltage) -and
                        ![double]::IsNaN($startingVoltage) -and ![double]::IsInfinity($startingVoltage)
                } until ($validVoltage -or $ready -in 'S', 'Q')
                if ($ready -eq 'Q') {
                    Add-Content -LiteralPath $LogPath -Encoding UTF8 -Value "Stopped at $($step.Name)"
                    return $false
                }
                if ($ready -eq 'S') {
                    Add-Content -LiteralPath $LogPath -Encoding UTF8 -Value "$($step.Name) | skipped"
                    continue
                }

                Add-Content -LiteralPath $LogPath -Encoding UTF8 -Value "$($step.Name) | biased starting voltage=$ready V"
                $method = $step.Method.Replace('19', [string] $PhysicalPin)
                if ($method -eq 'TestPin31OutputLow') { $method = 'TestPin31Output' }
                $pulse = Invoke-CimMethod -InputObject $devices[0] -MethodName $method
                if ($null -eq $pulse.Result) { throw 'The output method returned no result.' }
                $result = [uint32] $pulse.Result
                if ($result -le 6) {
                    Add-Content -LiteralPath $LogPath -Encoding UTF8 -Value "$($step.Name) | EC refused pulse | status=$result"
                    throw "Pulse refused (status $result). Check the updated table and WMI registration."
                }
                $pulseReport = 'drive=0x{0:X2} release=0x{1:X2}' -f ($result -band 0xFF), (($result -shr 8) -band 0xFF)
                if ($result -band 0x01000000) {
                    $pulseReport += ' | EC 0x{0:X2} during drive=0x{1:X2}' -f $register, (($result -shr 16) -band 0xFF)
                }
                Write-Host $pulseReport
                Add-Content -LiteralPath $LogPath -Encoding UTF8 -Value "$($step.Name) | $pulseReport"
                $pulseFailed = ($result -band 0xFFFF) -ne 0x5555
                $choices = @{
                    'P' = "Saw expected $($step.Expected)"
                    'N' = 'No pulse observed'
                    'F' = 'Pulse observed but pin did not release'
                    'O' = 'Other waveform with return to starting voltage'
                    'U' = 'Release uncertain'
                    'R' = 'Returned to starting voltage; repeat requested'
                }
                $prompt = "P $($step.Expected) | R Returned, repeat | N No pulse or lasting change | F Did not release | O Other and returned | U Release uncertain | Q Quit"
            }
            do {
                $choice = (Read-Host $prompt).Trim().ToUpperInvariant()
            } until ($choices.ContainsKey($choice) -or $choice -eq 'Q')
            if ($choice -eq 'Q') {
                Add-Content -LiteralPath $LogPath -Encoding UTF8 -Value "Stopped at $($step.Name)"
                return $false
            }

            if ($choice -eq 'S') {
                Add-Content -LiteralPath $LogPath -Encoding UTF8 -Value "$($step.Name) | skipped"
                continue
            }

            $reading = 'No EC selector'
            if ($hasSelector) {
                $snapshot = Invoke-CimMethod -InputObject $devices[0] -MethodName ReadSnapshotTrace
                if ($null -eq $snapshot.Status) { throw 'The WMI snapshot returned no status.' }
                $status = [uint32] $snapshot.Status
                $reading = "EC status=$status"
                if ($status -eq 0) {
                    if ($null -eq $snapshot.Data2 -or $null -eq $snapshot.Data3) {
                        throw 'The WMI snapshot returned no bitmap.'
                    }
                    # Post-request bitmap occupies bytes 2-3 of Data2 and bytes 0-2 of Data3.
                    $bytes = [byte[]] ([BitConverter]::GetBytes([uint32] $snapshot.Data2)[2..3] +
                        [BitConverter]::GetBytes([uint32] $snapshot.Data3)[0..2])
                    $state = if ($bytes[$byteIndex] -band $mask) { 'HIGH' } else { 'LOW' }
                    $reading = "candidate=$state | snapshot=$([BitConverter]::ToString($bytes))"
                }
            }
            $instrument = if ($step.Method) { 'scope' } else { 'meter' }
            $entry = "$($step.Name) | $instrument=$($choices[$choice]) | $reading"
            Add-Content -LiteralPath $LogPath -Encoding UTF8 -Value $entry
            Write-Host $entry
            if ($choice -eq 'O') {
                $note = Read-Host 'Enter the measured voltage, waveform, or a short note'
                Add-Content -LiteralPath $LogPath -Encoding UTF8 -Value "  Note: $note"
            }
            if ($step.Method -and ($pulseFailed -or $choice -in 'F', 'U')) {
                Add-Content -LiteralPath $LogPath -Encoding UTF8 -Value 'Run stopped after an EC error or uncertain release.'
                Write-Host 'Stop here. Check the EC response and electrical release before another pulse.'
                return $false
            }
            if ($step.Method -and $choice -eq 'R') {
                $index--
                continue
            }
        }
        Add-Content -LiteralPath $LogPath -Encoding UTF8 -Value 'Run complete'
        return $true
    } catch {
        Add-Content -LiteralPath $LogPath -Encoding UTF8 -Value "Run interrupted: $($_.Exception.Message)"
        throw
    } finally {
        Write-Host 'Leave the resistor disconnected when finished.'
    }
}

foreach ($physicalPin in $Pin) {
    if (!(Invoke-HeaderPinTests -PhysicalPin $physicalPin)) { break }
}
