# FNORD
Some fun ways to mess with Apple ]['s output routine

## About

This project contains a number of programs for Apple ][ computers that will mess with screen output - both as you are typing it, and from program and command output.

Note that regardless of what the screen shows, the real input that your Apple sees will be exactly what you typed!

To try one of the output filters, use:
```
  ] brun filter
```

To return output to normal, enter:
```
  ] pr#0
```
or restart basic with Control-RESET

These programs have been tested on a real-life Apple //c, and via emulation on enhanced Apple //e and an Apple ][+ configurations.

## How to try it out!

The easiest way to try these programs is to grab the `fnord.dsk` image from github's "releases" tab for this project. Then either run in an Apple ][ emulator, or transfer to your real Apple II-series computer via something like [Floppy Emu](https://www.bigmessowires.com/floppy-emu/) or [ADTPro](https://adtpro.com/), boot the disk, and follow the instructions!

## Building notes

If you want to modify or build from these sources, you will need tools from the following projects:

  * The ca65 and ld65 tools from [the cc65 project](https://github.com/cc65/cc65)
  * These [tools for manipulating Apple DOS 3.3 filesystems](https://github.com/deater/dos33fsprogs)

NOTE: The **dos33fsprogs** project contains *many* different subprojects, most of which are *not needed* to build `fnord.dsk`. The only subdirectories you must build, are `dos33fs-utils` and `asoft_basic-utils`.

Fnord's Makefile assumes all of these tools are accessible from the current `PATH` environment variable.

## A note on how to hook output filters into your Apple

If you were to boot directly into BASIC (no dos), and poke these filter routines directly into memory at `$030b`, the way you would hook them into filtering screen output would be to set `$36-$37` to the address (`$030B`, low byte first).

However, both Apple DOS and ProDOS have already hooked this for their own purposes, and take measures to keep it that way, so both DOS's need other means of hooking in.

ProDOS has explicit support for doing this on the command line:
```
  ] PR#A$30B
```

I'd have preferred to use this method, but do not have convenient tools for building ProDOS images outside of a running Apple ][. So I'm using what works for at least my version (3.3) of Apple DOS (unsure if a better means exists): to set `$AA53-54` to the desired address. So we do that.
