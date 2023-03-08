$ErrorActionPreference = "Stop"

If (Test-Path "bin") {
    Remove-Item "bin" -Recurse -ErrorAction Inquire
}

New-Item bin -ItemType Directory  -ErrorAction SilentlyContinue | Out-Null

Start-Process "..\..\..\ThirdParty\DOSBox\DOSBox" -ArgumentList @("-noconsole", "-conf", "build.conf") -Wait
Move-Item "src/STARDOD.EXE" bin
Move-Item 'src/*.$$$' bin -ErrorAction SilentlyContinue
Copy-Item "src/*.BGI" bin
Copy-Item "src/*.CHR" bin
Copy-Item "src/*.DAT" bin

New-Item bin/.jsdos -ItemType Directory | Out-Null
Copy-Item jsdos/dosbox.conf bin/.jsdos
Copy-Item jsdos/jsdos.json bin/.jsdos

$zipFileName = "$PSScriptRoot\Stardodge.jsdos"
Push-Location bin
Try {
    Compress-Archive * -DestinationPath $zipFileName
}
Finally {
    Pop-Location
}
Move-Item "Stardodge.jsdos" bin