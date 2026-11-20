# Read-only inventory of the Windows platform and likely GPIO-related devices.
[CmdletBinding()]
param()

$ErrorActionPreference = 'Stop'

$devicePattern = 'GPIO|Serial\s*I/?O|(?:I2C|SPI|UART).*Controller|INT345[2-4]|INT34C[2-4]|MSFT8000'

$devices = Get-CimInstance -ClassName Win32_PnPEntity | Where-Object {
    $identifiers = @($_.Name, $_.PNPClass, $_.Service) + @($_.HardwareID)
    ($identifiers -join ' ') -match $devicePattern
}
$driverNames = @('rhproxy', 'msgpioclx') + @($devices | ForEach-Object { $_.Service })
$drivers = Get-CimInstance -ClassName Win32_SystemDriver | Where-Object {
    $_.Name -in $driverNames -or $_.Name -match $devicePattern
}

[ordered]@{
    CollectedAt = (Get-Date).ToString('o')
    Windows = Get-CimInstance Win32_OperatingSystem |
        Select-Object Caption, Version, BuildNumber, OSArchitecture
    Board = @(Get-CimInstance Win32_BaseBoard | Select-Object Manufacturer, Product, Version)
    Bios = Get-CimInstance Win32_BIOS | Select-Object Manufacturer, SMBIOSBIOSVersion
    Processor = @(Get-CimInstance Win32_Processor | Select-Object Name)
    Devices = @($devices | Select-Object Name, PNPClass, HardwareID, Service, Present, ConfigManagerErrorCode)
    Drivers = @($drivers | Select-Object Name, DisplayName, State, StartMode)
    RhProxyServicePresent = Test-Path 'HKLM:\SYSTEM\CurrentControlSet\Services\rhproxy'
} | ConvertTo-Json -Depth 5
