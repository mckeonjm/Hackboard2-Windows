[CmdletBinding()]
param(
    [ValidateRange(1, 600)]
    [int] $Samples = 1,

    [ValidateRange(250, 10000)]
    [int] $IntervalMs = 500,

    [switch] $SnapshotTrace
)

$ErrorActionPreference = 'Stop'

try {
    $devices = @(Get-CimInstance -Namespace root/wmi -ClassName Hackboard2_Pin31Test)
} catch {
    throw "Could not discover the test WMI class. Check the SSDT, WmiAcpi binding and MOF registration. $($_.Exception.Message)"
}

if ($devices.Count -ne 1) {
    throw "Expected one pin 31 diagnostic instance. Found $($devices.Count)."
}

for ($index = 1; $index -le $Samples; $index++) {
    $trace = Invoke-CimMethod -InputObject $devices[0] -MethodName ReadSnapshotTrace
    if ($null -eq $trace.Status -or $null -eq $trace.Data3) {
        throw 'The snapshot method returned an incomplete result.'
    }
    $status = [uint32] $trace.Status
    if ($SnapshotTrace) {
        $bytes = foreach ($name in 'Data0', 'Data1', 'Data2', 'Data3') {
            if ($null -eq $trace.$name) { throw "The trace returned no $name." }
            [BitConverter]::GetBytes([uint32] $trace.$name)
        }
        $before = 'unavailable'
        $during = 'unavailable'
        $after = 'unavailable'
        if ($status -eq 0) {
            $before = [BitConverter]::ToString($bytes, 0, 5)
            $during = [BitConverter]::ToString($bytes, 5, 5)
            $after = [BitConverter]::ToString($bytes, 10, 5)
        }
        '{0:HH:mm:ss.fff}  {1}/{2}  status={3} mailbox=0x{4:X2} before={5} during={6} after={7}' -f (Get-Date), $index, $Samples, $status, $bytes[15], $before, $during, $after
    } else {
        $state = switch ($status) {
            0 {
                # Data3 byte 1 is EC offset 0x47 in the post-request snapshot.
                # The live trace correlated physical pin 31 with mask 0x40.
                if ([uint32] $trace.Data3 -band 0x4000) { 'HIGH' } else { 'LOW' }
            }
            2 { 'EC unavailable' }
            3 { 'Mailbox occupied or request interrupted' }
            4 { 'EC mutex timeout' }
            default { throw "Unexpected diagnostic status $status." }
        }
        '{0:HH:mm:ss.fff}  {1}/{2}  pin 31  {3}' -f (Get-Date), $index, $Samples, $state
    }

    if ($index -lt $Samples) {
        Start-Sleep -Milliseconds $IntervalMs
    }
}
