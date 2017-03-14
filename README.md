# spinner
POSIX shell compatible spinner function with colors and Unicode (more like Fun-icode, am I right?) graphics.

It currently supports and is regularly tested on reasonably modern bash, dash, and the FreeBSD Bourne sh, as well as Linux and (some) Windows terminals.

A simple to use spinner with asynchronous behavior (start a process, run your spinner, touch a file when finished, spinner stops). It has a variety of spinner design options, and cycles through colors by default.

There are ASCII spinner designs that are pretty much expected to work on any terminal and POSIX-y shell, and then there are Unicode spinner designs that likely need a modern-ish terminal and shell. I've used a few tricks to make it workaround older shells (by using the system printf command instead of the printf shell built-in), in some cases, so it sometimes works even when it's not expected to based on the features of the shell (but there's no way to workaround a terminal that doesn't support Unicode).

# What it Looks Like

![spinner in action](http://i.imgur.com/gquCDSi.gif)

The above is all of the symbol designs that work with the shell, terminal, and font I'm using. There are a few others borrowed from some other spinner libs out there in other languages, but I doubt they'll be useful until the codepoints are more widely available. It takes a couple of minutes to loop through them all.

Or, combined with another function I wrote for running commands in an install script with nice output:

![spinner and run_ok](http://i.imgur.com/7gcOilK.gif)

# Using spinner

Source it, using '. ./spinner.sh', and then optionally configure it with the available config variables (SPINNER_COLORNUM, SPINNER_COLORCYCLE, SPINNER_DONEFILE, SPINNER_SYMBOLS). See the source for all of the SPINNER_SYMBOLS options; there are a bunch of ASCII and Unicode options.

```bash
#!/bin/sh

. ./spinner.sh

SPINNER_SYMBOLS="ASCII_PLUS" # This will be derefed to $ASCII_PLUS, which is a predefined list of symbols

# Create a new job for spinner, so you can keep doing work.
spinner &
# Do your work here...redirect output to a log or /dev/null, so user only sees spinner.
long_running_task > /dev/null 2>&1 # Output thrown away; a log is probably a better destination.

touch stopspinning # Tell spinner we're done. This file will be removed by spinner().
```

# Tricky Bits

Older shells and terminals may choke on any Unicode spinners...so, use ASCII symbol sets if you need to run on old systems. I'm targeting CentOS 6 and up, Ubuntu 12.04 and up, and Debian 7 and up, and test periodically on them all. I need it to run across a pretty wide spectrum of terminals, as well, so I'm checking it on Windows (PuTTY, git bash, WSL bash, Cygwin bash) and a few Linux terminals. I'm also testing on FreeBSD CURRENT when I can make it run long enough (it crashes every minute or two on my VirtualBox install...no idea why, but freebsd-update fails, so I just assume it is broken forever).

The native Windows terminals (CMD.exe and Powershell) don't seem to correctly work correctly for cursor placement, colors, or Unicode, and I don't have any clue how to fix them...suggestions welcome. I believe the behavior I'm seeing means they are not providing correct termcap info for tput to work with, but I am not at all an expert. But, PuTTY and every bash version for Windows I tested works fine, including Unicode and colors. 

I don't have a Mac, but, as I understand it, it does provide correct termcap info for tput, so colors should work. I'm guessing that Unicode will work, as well, but someone will need to test it, and let me know, to be sure.

# Contributing

I welcome patches as long as they don't break compatibility, and encourage bug reports of compatibility issues (though there's probably nothing more I can do, that I'm not already doing, about poor Unicode support in some shells and some terminals).
