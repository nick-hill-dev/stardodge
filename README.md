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

## Manual Building

`Compile.ps1` can be used to build the .jsdoc as well as the original `STARDOD.EXE` file.

It will need adjusting, as you will have to point to an instance of DOSBox and a folder where TURBO PASCAL (6+) resides.

As well as adjusting `Compile.ps1` you will also need to update the startup script `build.conf` (at the bottom) to correctly find `TPC.EXE`.

## License

Stardodge was written by Nick Hill and is released under the MIT license. See LICENSE for more information.