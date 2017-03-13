# spinner
POSIX shell compatible spinner function with colors and Unicode (more like Fun-icode, am I right?) graphics.

It currently supports and is regularly tested on reasonably modern bash, dash, and the FreeBSD Bourne sh, as well as Linux and (some) Windows terminals.

A simple to use spinner with asynchronous behavior (start a process, run your spinner, touch a file when finished, spinner stops). It has a variety of spinner design options, and cycles through colors by default.

There are ASCII spinner designs that are pretty much expected to work on any terminal and POSIX-y shell, and then there are Unicode spinner designs that likely need a modern-ish terminal and shell. I've used a few tricks to make it workaround older shells (by using the system printf command instead of the printf shell built-in), in some cases, so it sometimes works even when it's not expected to based on the features of the shell (but there's no way to workaround a terminal that doesn't support Unicode).

# What it looks

![spinner in action](http://i.imgur.com/QFlrbWo.gif)

# Using spinner

Source it, using '. ./spinner.sh', and then optionally configure it with the available config variables (SPINNER_COLORNUM, SPINNER_COLORCYCLE, SPINNER_DONEFILE, SPINNER_SYMBOLS).

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

Older shells and terminals may choke on any Unicode spinners...so, use ASCII symbol sets if you need to run on old systems. I'm targeting CentOS 6 and up, Ubuntu 12.04 and up, and Debian 7 and up, and test periodically on them all. I need it to run across a pretty wide spectrum of terminals, as well, so I'm checking it on Windows (Putty, git bash, WSL bash, Cygwin bash) and a few Linux terminals.

The native Windows terminals (CMD.exe and Powershell) don't seem to correctly work correctly for cursor placement, colors, or Unicode, and I don't have any clue how to fix them...suggestions welcome. I believe the behavior I'm seeing means they are not providing correct termcap info for tput to work with, but I am not at all an expert.

I don't have a Mac, but, as I understand it, it does provide correct termcap info for tput, so colors should work. I'm guessing that Unicode will work, as well, but someone will need to test it, and let me know, to be sure.

# Contributing

I welcome patches as long as they don't break compatibility, and encourage bug reports of compatibility issues (though there's probably nothing more I can do, that I'm not already doing, about poor Unicode support in some shells and some terminals).
