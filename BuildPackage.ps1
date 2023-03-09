Param (
    [Parameter()] $DosBoxExe = "..\..\..\ThirdParty\DOSBox\DOSBox.exe",
    [Parameter()] $TurboPascalCompilerExe = "..\..\..\ThirdParty\TurboPascal\TPC.EXE"
)

$ErrorActionPreference = "Stop"

If (Test-Path "bin") {
    Write-Host "Removing existing bin folder..." -ForegroundColor Cyan
    Remove-Item "bin" -Recurse -ErrorAction Inquire
}

Write-Host "Creating new bin folder..." -ForegroundColor Cyan
New-Item bin -ItemType Directory  -ErrorAction SilentlyContinue | Out-Null

Write-Host "Compiling via TPC.EXE in DOSBox..." -ForegroundColor Cyan
$tpcLocation = (Get-Item (Resolve-Path $TurboPascalCompilerExe)).Directory.FullName
Start-Process $DosBoxExe -ArgumentList @(
    "-c `"MOUNT C: $tpcLocation`"",
    "-c `"MOUNT D: src`"",
    "-c `"MOUNT E: bin`"",
    "-c D:",
    "-c `"C:\TPC STARDOD.PAS`"",
    "-c EXIT",
    "-noconsole"
) -Wait

Write-Host "Copying files to bin folder..." -ForegroundColor Cyan
Move-Item "src/STARDOD.EXE" bin
Move-Item 'src/*.$$$' bin -ErrorAction SilentlyContinue
Copy-Item "src/*.BGI" bin
Copy-Item "src/*.CHR" bin
Copy-Item "src/*.DAT" bin

Write-Host "Integrating JSDOS..." -ForegroundColor Cyan
New-Item bin/.jsdos -ItemType Directory | Out-Null
Copy-Item jsdos/dosbox.conf bin/.jsdos
Copy-Item jsdos/jsdos.json bin/.jsdos

Write-Host "Creating archive..." -ForegroundColor Cyan
$zipFileName = "$PSScriptRoot\Stardodge.jsdos"
Push-Location bin
Try {
    Compress-Archive * -DestinationPath $zipFileName
}
Finally {
    Pop-Location
}
Move-Item "Stardodge.jsdos" bin

Write-Host "All done." -ForegroundColor Green