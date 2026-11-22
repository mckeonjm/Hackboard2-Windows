[CmdletBinding()]
param(
    [switch] $DriveHigh
)

$ErrorActionPreference = 'Stop'
$devices = @(Get-CimInstance -Namespace root/wmi -ClassName Hackboard2_Pin31Test)
if ($devices.Count -ne 1) {
    throw "Expected one pin 31 diagnostic instance. Found $($devices.Count)."
}

if ($DriveHigh) {
    $method = 'TestPin31OutputHigh'
    $baseline = 'LOW'
} else {
    $method = 'TestPin31Output'
    $baseline = 'HIGH'
}

$response = Invoke-CimMethod -InputObject $devices[0] -MethodName $method
if ($null -eq $response.Result) { throw 'The pulse method returned no result.' }

$result = [uint32] $response.Result
switch ($result) {
    2 { throw 'The embedded controller was unavailable.' }
    3 { throw 'The embedded controller mailbox was occupied.' }
    4 { throw 'Timed out waiting for the embedded controller mutex.' }
    5 { throw 'The corrected output method is unavailable. Install the updated table and restart.' }
    6 { throw "The preflight GPIO read did not return $baseline. No pulse was sent." }
}

$drive = $result -band 0xFF
$release = ($result -shr 8) -band 0xFF
'GPIO6 pulse response: drive=0x{0:X2} release=0x{1:X2}' -f $drive, $release
if ($release -ne 0x55) {
    throw 'GPIO input restoration was not acknowledged. Stop testing and report the scope trace and both response bytes.'
}
if ($drive -ne 0x55) {
    throw 'The EC did not acknowledge the drive request. Report both response bytes.'
}
