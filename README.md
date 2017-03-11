# spinner
POSIX compatible spinner function with colors and Unicode graphics.

It currently supports and is regularly tested on reasonably modern bash, dash, and zsh, as well as Linux and Windows terminals. 

A simple to use spinner with asynchronous behavior (start a process, run your spinner, touch a file when finished, spinner stops). It has a variety of spinner options, and cycles through colors by default.

There are ASCII spinner designs that are pretty much expected to work on any terminal and POSIX-y shell, and then there are Unicode spinner designs that likely need a modern-ish terminal and shell. I've used a few tricks to make it workaround older shells, in some cases, so it sometimes works even when it's not expected to based on the features of the shell.

Docs coming soon. I just wanted to get it committed so I could try it across all of my test machines.

It is also not currently very configurable and isn't wrapped in a function, yet. Variables also need to be more tightly scoped. For now, you can change the SYMBOLS variable to choose which spinner design to use.

I welcome patches as long as they don't break compatibility, and encourage bug reports of compatibility issues (though there's probably nothing more I can do, that I'm not already doing, about poor Unicode support in some shells and some terminals).
