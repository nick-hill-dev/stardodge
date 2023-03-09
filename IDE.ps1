Param (
    [Parameter()] $DosBoxExe = "..\..\..\ThirdParty\DOSBox\DOSBox.exe",
    [Parameter()] $TurboPascalIdeExe = "..\..\..\ThirdParty\TurboPascal\TURBO.EXE"
)

$ErrorActionPreference = "Stop"

$tpLocation = (Get-Item (Resolve-Path $TurboPascalIdeExe)).Directory.FullName
Start-Process $DosBoxExe -ArgumentList @(
    "-c `"MOUNT C: $tpLocation`"",
    "-c `"MOUNT D: src`"",
    "-c `"MOUNT E: bin`"",
    "-c D:",
    "-c `"C:\TURBO STARDOD.PAS`"",
    "-conf IDE.conf",
    "-noconsole"
)
