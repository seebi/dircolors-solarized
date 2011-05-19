# Solarized dircolors / ls colors

A color theme for dircolors (ls colors) using Ethan Schoonover’s [Solarized color scheme](http://ethanschoonover.com/solarized).

## Repositories
  * This theme as a single repository: [/seebi/dircolors-solarized](https://github.com/seebi/dircolors-solarized)
  * The main solarized repository: [/altercation/solarized](https://github.com/altercation/solarized)

## Files
  * `dircolors.256dark` - dark solarized theme for 256 color terminals (by [seebi](https://github.com/seebi))

## Usage
These dircolors database files uses solarized colors instead of the given
terminal emulator palette. To use it, run this 

    eval `dircolors /path/to/dircolorsdb`

Typically, this file is copied or linked to `~/.dir_colors`.

### 256 color schemes
To be able to use it, you need a 256 color terminal (e.g. gnome-terminal or
urxvt) and a correct `TERM` variable, e.g.:

    export TERM=xterm-256color        # for common 256 color terminals (e.g. gnome-terminal)
    export TERM=screen-256color       # for a tmux -2 session (also for screen)
    export TERM=rxvt-unicode-256color # for a colorful rxvt unicode session

## Features / Properties
  * solarized :-)
  * comment style for backup and log and cache files
  * highlighted style for files of special interest (.tex, Makefiles, .ini ...)
  * bold hierarchies:
    * archive = violet, compressed archive = violet + bold
    * audio = orange, video = orange + bold
  * tested use-cases:
    * latex directories
    * source code directories
  * special files (block devices, pipes, ...) are inverted using the
    solarized light pallette for the background
  * symbolic links bold and distinguishable from directories

## Screenshots

### 256dark theme (currently the only one)
Here are screenshots of common and not so common use-cases.
They are captured from a gnome-terminal using the [dz-version of the awesome Inconsolata font](http://nodnod.net/2009/feb/12/adding-straight-single-and-double-quotes-inconsola/).

#### Common colors in action
Executables, archives, audio/video stuff, dead links

![common use-cases](https://github.com/seebi/dircolors-solarized/raw/master/screenshots/256dark-common.png)

#### Use-Case: LaTeX
tex-trash is in comment style and tex are main files of interest and highlighted.

![common use-cases](https://github.com/seebi/dircolors-solarized/raw/master/screenshots/256dark-latex.png)

#### Use-Case: source code
all source files are standard highlighted, makefiles, configuration files and READMEs
are of special interest, and object and class files are commented out.

![c sources example](https://github.com/seebi/dircolors-solarized/raw/master/screenshots/256dark-sources-c.png)
![php sources example](https://github.com/seebi/dircolors-solarized/raw/master/screenshots/256dark-sources-php.png)



#### All colors in action
uncommon stuff like pipes and block devices ...

![not so common use-cases](https://github.com/seebi/dircolors-solarized/raw/master/screenshots/256dark-all.png)


