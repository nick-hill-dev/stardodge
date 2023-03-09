# Stardodge

Back in 1999 I studied A-Levels at College and as part of my newfound enthusiasm for Turbo Pascal I went about implementing a game based on an [Amstrad CPC classic of the same name](https://scruss.com/blog/2012/09/08/2d-star-dodge-flies-again/).

It turned out to be quite popular amongst my classmates at the time. I remember it being copied to different floppy disks so everyone could play it at home and amongst the different PCs at the college.

This repository is a preservation of the original source code with tooling integrated that can be used to build .jsdoc packages to enable playing in a browser window.

## Play Now!

No need to compile anything, just get stuck in here:

- https://home.nick-hill.com/games/classic/stardodge

## Manual

Progress through 20 levels, aiming for the highest score!

Use the space bar to toggle between up and down. Get to the end without hitting stars or the edges of the screen.

- Yellow = Minor damage
- Purple = Major damage
- White = Start the level again

You get bonus points for making fewer turns.

## IDE Coding and Debugging

`IDE.ps1` can be used to edit the source code and debug it via the Turbo Pascal IDE.

When executing the script, specify where DOSBox is and also where Turbo Pascal (6+) is:

```powershell
.\IDE.ps1 -DosBoxExe C:\DOSBox\DOSBox.exe -TurboPascalIdeExe C:\TP\TURBO.exe
```

## Creating a JSDOS Deployment Package

`BuildPackage.ps1` can be used to build the `.jsdoc` as well as the original `STARDOD.EXE` file.

When executing the script, specify where DOSBox is and also where Turbo Pascal (6+) is:

```powershell
.\BuildPackage.ps1 -DosBoxExe C:\DOSBox\DOSBox.exe -TurboPascalCompilerExe C:\TP\TPC.exe
```

## License

Stardodge was written by Nick Hill and is released under the MIT license. See LICENSE for more information.