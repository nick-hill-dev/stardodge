Param (
    [Parameter()] $DosBoxExe = "..\..\..\ThirdParty\DOSBox\DOSBox.exe",
    [Parameter()] $TurboPascalIdeExe = "..\..\..\ThirdParty\TurboPascal\TURBO.EXE",
    [Parameter()] $SourceCodeFileName = "STARDOD.PAS"
)

$ErrorActionPreference = "Stop"

$tpLocation = (Get-Item (Resolve-Path $TurboPascalIdeExe)).Directory.FullName
Start-Process $DosBoxExe -ArgumentList @(
    "-c `"MOUNT C: $tpLocation`"",
    "-c `"MOUNT D: src`"",
    "-c `"MOUNT E: bin`"",
    "-c D:",
    "-c `"C:\TURBO $SourceCodeFileName`"",
    "-conf IDE.conf",
    "-noconsole"
)
