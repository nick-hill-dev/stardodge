$ErrorActionPreference = "Stop"

If (Test-Path "bin") {
    Remove-Item "bin" -Recurse
}

New-Item bin -ItemType Directory | Out-Null

Start-Process "..\..\..\ThirdParty\DOSBox\DOSBox" -ArgumentList @("-noconsole", "-conf", "build.conf") -Wait
Move-Item "src/STARDOD.EXE" bin
Move-Item 'src/*.$$$' bin -ErrorAction SilentlyContinue
Copy-Item "src/*.BGI" bin
Copy-Item "src/*.CHR" bin
Copy-Item "src/*.DAT" bin

$zipFileName = "bin/Stardodge.zip"

Compress-Archive -Path bin/*.EXE -DestinationPath $zipFileName
Compress-Archive -Path bin/*.BGI -Update -DestinationPath $zipFileName
Compress-Archive -Path bin/*.CHR -Update -DestinationPath $zipFileName
Compress-Archive -Path bin/*.DAT -Update -DestinationPath $zipFileName