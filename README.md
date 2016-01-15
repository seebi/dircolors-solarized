<h1>Solarized Color Theme for GNU ls (as setup by GNU dircolors)</h1>

This is a repository of themes for GNU ls (configured via GNU
dircolors) that support Ethan Schoonover’s [Solarized color
scheme](http://ethanschoonover.com/solarized).

See the [Solarized homepage](http://ethanschoonover.com/solarized)
for screenshots, details and color theme implementations for terminal
emulators and other applications, such as Vim, Emacs, and Mutt.

Quick note for MacOS users: Your OS does not use GNU ls, so you can not use
this themes. However, [@logic](https://github.com/logic) provided something
your can use in [this issue](https://github.com/seebi/dircolors-solarized/issues/10).
Another option (as [proposed](https://github.com/seebi/dircolors-solarized/issues/10#issuecomment-2641754)
by [@metamorfos](https://github.com/metamorfos)) is to install GNU ls with
homebrew (coreutils).

<h2>(Selected) Table of Contents</h2>

* [Repositories](#repositories)
* [Themes](#themes)
  * [Theme #1: "256dark"](#256dark)
  * [Theme #2: "ansi-\*"](#ansi)
* [Installation](#installation)
* [Understanding Solarized Colors in Terminals](#understanding-solarized-colors-in-terminals)

<h2 id="repositories">Repositories</h2>

  * The main Solarized repository: [/altercation/solarized](https://github.com/altercation/solarized)
  * These themes as a separate repository: [/seebi/dircolors-solarized](https://github.com/seebi/dircolors-solarized)

<h2 id="themes">Themes</h2>

First, note that "256 colors" does not necessarily mean better than "ANSI".
Read on for more details.

1.  "256dark" - Degraded Solarized Dark theme for terminal emulators and
    newer dircolors that both support 256 colors. This theme allows for the display
    of the *approximate* Solarized palette, but it's very easy to set up and allows
    for the use of many more colors beyond the 16 in Solarized.
    (By [seebi](https://github.com/seebi))

    Note: In the future, it may be possible to change the approximate
    Solarized colors to the exact Solarized palette; and this theme would
    automatically improve.  Work on an appropriate .Xresources has not yet
    started. (See [256-color remapping discussion](https://github.com/altercation/solarized/issues/8).)

2.  "ansi-universal" - Universal theme for 16-color or 256-color
    terminal emulators and any version of dircolors.  It is optimized for
    Solarized Dark and Light and acceptable with default ANSI colors. This theme allows
    for the display of the *exact* Solarized palette, but it requires the reconfiguration
    of the terminal emulator's ANSI color settings and limits you to the 16
    Solarized colors. (By [huyz](https://github.com/huyz))

    "ansi-dark" - Tweaked version of "ansi-universal", slightly more
    optimized for the Solarized Dark palette to the slight detriment of the
    Solarized Light palette.

    "ansi-light" - Tweaked version of "ansi-universal", slightly more
    optimized for the Solarized Light palette to the slight detriment of the
    Solarized Dark palette.

<h3 id="256dark">Theme #1: "256dark" (by <a href="https://github.com/seebi">seebi</a>)</h3>

<h4 id="256dark-features">Features / Properties</h4>

  * Solarized :-)
  * Comment style for backup and log and cache files
  * Highlighted style for files of special interest (.tex, Makefiles, .ini ...)
  * Bold hierarchies:
    * archive = violet, compressed archive = violet + bold
    * audio = orange, video = orange + bold
  * Tested use-cases:
    * latex directories
    * source code directories
  * Special files (block devices, pipes, ...) are inverted using the
    solarized light palette  for the background
  * Symbolic links bold and distinguishable from directories

<h4 id="256dark-screenshots">Screenshots</h4>

Here is a [screenshot](https://github.com/seebi/dircolors-solarized/raw/master/img/dircolors.256dark.png) of a prepared session which shows the content of the test-directory.tar.bz2.
It is captured from an [iterm2](http://iterm2.com/) using the [dz-version of the awesome Inconsolata font](http://nodnod.net/2009/feb/12/adding-straight-single-and-double-quotes-inconsola/) (but you can use any terminal emulator supporting 256colors).

![session](https://github.com/seebi/dircolors-solarized/raw/master/img/dircolors.256dark.png)

Some more screenshots are provided by [andrew from webupd8.org](http://www.webupd8.org/2011/04/solarized-must-have-color-paletter-for.html).

<h3 id="ansi">Theme #2: "ansi-\*" (by <a href="https://github.com/huyz">huyz</a>)</h3>

This theme and its variants require that the terminal emulator be properly
configured to display the Solarized palette instead of the 16 default ANSI
colors.

<h4 id="ansi-features">Features / Properties</h4>

This theme called "ansi-universal" and its variants "ansi-dark" and
"ansi-light", were designed to work best with both Solarized Dark and Light
palettes, but also to work under terminals' default ANSI colors. In other
words, these themes were designed with a "fallback" scenario: if you happen to
find yourself on a terminal where the Solarized palette has not been set up,
you won't have elements become invisible, incrediby hard to read, or a boring
gray.

Thus, the universal theme was designed with these 4 palettes in mind:

-   Solarized Dark: "ansi-universal" works best when the terminal emulator is
    set to this scheme
-   Solarized Light: "ansi-universal" works best when the terminal emulator is
    set to this scheme
-   Default terminal ANSI Colors with a dark background
-   Default terminal ANSI Colors with a light background

The "ansi-dark" and "ansi-light" are slightly optimized versions of "ansi-universal"
for Solarized Dark and Solarized Light, respectively, if you're willing
to sacrifice a bit of universality.

Colors were selected based on the characteristics of the items to be displayed:

-   Visibility generally follows importance, with an attempt to let unimportant
    items fade into the background (which is not always possible when
    simultaneously supporting dark and light backgrounds)
-   Loud colors are chosen to call attention to noteworthy items

<h4 id="ansi-screenshots">Screenshots</h4>

Solarized Dark (this example uses iTerm2 on OS X):

![Solarized Dark](https://github.com/huyz/dircolors-solarized/raw/master/img/screen-dircolors-in-iTerm2-solarized_dark.png)]

To see what this theme looks like when the terminal emulator is set with different color palettes:

*   [Solarized Light (with iTerm2 on OS X)](https://github.com/huyz/dircolors-solarized/raw/master/img/screen-dircolors-in-iTerm2-solarized_light.png)
*   [Default dark background of iTerm on OS X](https://github.com/huyz/dircolors-solarized/raw/master/img/screen-dircolors-in-iTerm-dark.png)
*   [Default light background of iTerm on OS X](https://github.com/huyz/dircolors-solarized/raw/master/img/screen-dircolors-in-iTerm-light.png)
*   [Default dark colors of PuTTY on Windows](https://github.com/huyz/dircolors-solarized/raw/master/img/screen-dircolors-in-PuTTY-dark_default.png)
*   [Default light colors of PuTTY on Windows](https://github.com/huyz/dircolors-solarized/raw/master/img/screen-dircolors-in-PuTTY-light_system.png) (Select "Use system colors")


<h2 id="installation">Installation</h2>

### Downloads

If you have come across these themes via the [dircolors-only repository] on
github, you may want to check the main [Solarized repository] to see if there
are official themes.

In the future, the [dircolors-only repository] may be kept in sync with the main
[Solarized repository], but the [dircolors-only repository] may be left separate
for installation convenience and to include the latest improvements.

At this time, issues, bug reports, changelogs are to be reported at the
[dircolors-only repository].

If you want to access the latest improvements to a specific theme, then go to
that theme's unique github directory:

*   "256dark":                  https://github.com/seebi/dircolors-solarized
*   "ansi-\*":                  https://github.com/huyz/dircolors-solarized

[Solarized repository]:         https://github.com/altercation/solarized
[dircolors-only repository]:    https://github.com/seebi/dircolors-solarized

### General Instructions

The Solarized color themes are distributed as database files for GNU
dircolors, which is the application that sets up colors for GNU ls.
To use any of the database files, run this:

    eval `dircolors /path/to/dircolorsdb`

To activate the theme for all future shell sessions, copy or link that file to
`~/.dir_colors`, and include the above command in your `~/.profile` (for bash)
or `~/.zshrc` (for zsh).

For Ubuntu 14.04 it is sufficient to copy or link database file to `~/.dircolors`.
Statement in `~/.bashrc` will take care about triggering eval command.

### Additional Instructions for 256-color Solarized Themes, e.g. "256dark"

For the 256-color Solarized dircolors themes, such as "256dark", you need a 256-color
terminal (e.g. `gnome-terminal` or `urxvt`) and a correct `TERM` variable,
e.g.:

    export TERM=xterm-256color        # for common 256 color terminals (e.g. gnome-terminal)
    export TERM=screen-256color       # for a tmux -2 session (also for screen)
    export TERM=rxvt-unicode-256color # for a colorful rxvt unicode session

### Additional Instructions for ANSI Solarized Themes, e.g. "ansi-universal"

For the ANSI Solarized dircolors themes (which work with both 16-color and
256-color terminals) you must configure your terminal emulator (See the
section "Understanding Solarized Colors in Terminals" for a detailed
explanation behind these settings):

1.  Make sure that you have changed your terminal emulator's color settings to
    the Solarized palette.

2.  Make sure that bold text is displayed using bright colors. For example,
    -   For iTerm2 on OS X, this means that Text Preferences must have the `Draw
        bold text in bright colors` checkbox *selected*.
    -   For Apple's Terminal.app on OS X, this means that Text Settings must
        have the `Use bright colors for bold text` checkbox *selected*.

3.  It's recommended to turn off the display of bold typeface for bold
    text.  For example,
    -   For iTerm2 on OS X, this means that Text Preferences should have the
        `Draw bold text in bold font` checkbox *unselected*.
    -   For Apple's Terminal.app on OS X, this means that Text Settings
        should have the `Use bold fonts` checkbox *unselected*.
    -   For XTerm, this may mean setting the `font` and `boldFont` to be the
        same in your .Xresources or .Xdefaults, e.g.:

            xterm*font: fixed
            xterm*boldFont: fixed

Example: for iTerm2, these are the correct settings:

![iTerm bold settings](https://github.com/huyz/dircolors-solarized/raw/master/img/screen-iTerm2-bold-options.png)


<h2 id="understanding">Understanding Solarized Colors in Terminals</h2>

### How Solarized works with ANSI-redefinition themes

8- or 256-color terminal programs such as dircolors use color codes that
correspond to the expected 8 normal ANSI colors.  dircolors additionally
supports bold, which terminal emulators will usually display by using the
*bright* versions of the 8 ANSI colors and/or by using a bold typeface with a
heavier weight. (Note that different terminal emulators may have slightly
different ideas of what color values to use when displaying the 16 [ANSI color
escape codes](http://en.wikipedia.org/wiki/ANSI_escape_code#Colors).)

In order to be displayed by 8- or 256-color terminal programs, which cannot
specify RGB values, Solarized must replace the default ANSI colors.  Since the
Solarized palette uses 16 colors, not only must this color scheme replace the
8 normal colors but must also take over the 8 *bright* colors, for a total of
16 colors. This means that a Solarized terminal application loses the ability
to bold text but gains 8 more Solarized colors.

About half of the Solarized palette is reminiscent of the original ANSI
colors, e.g. Solarized red is close to ANSI red (or more precisely, the
general consensus of what ANSI red should look like).  But the rest of the
Solarized colors do not correspond to any ANSI colors, e.g. there is no ANSI
color that corresponds to Solarized orange or purple.

This means that, for example, if the dircolors theme wants to display "green", a
Solarized terminal will display something close to green, but if the theme
wants to display "bold yellow" or "bright yellow", a Solarized terminal will
not be able to display it.  However, a Solarized theme will be able to display
the new colors orange and purple and also several shades of gray.  This is
again thanks to the replacement of the ANSI *bright* colors; e.g. ANSI "bold
red", which is usually displayed as "bright red", will now show as Solarized
orange, while ANSI "bold blue", which is usually displayed as "bright blue",
will now be a shade of gray.

#### Terminal Emulator

Because dircolors is entirely dependent on the terminal emulator for the
display of its colors, you cannot directly tell a dircolors theme to display
Solarized orange, e.g. by specifying an RGB value. Instead, the theme's colors
must be chosen using the available color codes (either ANSI or one of the 256
XTerm colors) with the expectation that the terminal emulator will display
them as appropriate Solarized colors. For example, the dircolors color
format `01;31` which normally would be "bold red" is expected to be displayed
by the terminal emulator as Solarized orange.

So in order for dircolors to display the *exact* Solarized palette, you have
to set your Terminal emulator's color settings to the Solarized palette. The
[Solarized repository] includes theme settings for some popular terminal
emulators as well as Xresources; or you can download them from the official
[Solarized] homepage. If you use the 16-color themes *without* having
changed your emulator's palette, you will get a strange selection of colors
that may be hard to read or gray.

Yes, this means that, to use the *exact* Solarized theme for dircolors, you
need to change color settings for not one but two different programs: your
terminal emulator and dircolors.  The two sets of settings will work in
concert to display Solarized colors appropriately.

#### Bold Settings

Historically, there has been a one-to-one correspondence between the bolded
versions of the 8 default ANSI colors and the bright versions of the 8 default
colors.  Back in the day, when a color program demanded the display of bold
text, it was probably just easier for terminal emulators to display a brighter
version of whatever color the text was (and expect the user to interpret that
as bold) than to display a typeface with a bold weight.

Nowadays, it is easy for terminal emulators to display bold typefaces, so it
doesn't make sense for bolded text to change color, but the confusing
association remains. In fact, new terminal emulators allow users to break the
correspondence between bold and bright and can simply change the font.

However, ANSI terminal applications such as older dircolors only
have a conception of bold and don't know about the possibility of using up to
16 colors.  So to use all 16 Solarized colors, we change the semantics of
"bold" in the theme to mean that we want to access the 8 new Solarized colors,
including the grays. Recall the example above, where we described that the
dirco color format `01;31`, which would have normally displayed bold red, is
expected to show up as Solarized orange.

This is why it is important to *not* break the association between bold and
bright colors. Many terminal emulators offer an option to disable the use of
bright colors for bold, and you must not do so.  Often, new users of Solarized
will be confused when they change their terminal emulator's color palette to
Solarized but haven't yet installed Solarized-specific color themes for all
their terminal applications (e.g. mutt, ls's dircolors, irssi, and their
colorized shell prompts).  They will see texts that are hard to read or
disappear entirely.  The solution isn't to disable bright colors; the solution
is to install Solarized color themes for all terminal applications and then you
will have all 16 colors.

Also, because the semantics of "bold" are lost in favor of more colors, it
also makes sense to disable the display of bold text as a bold typeface.  It
won't hurt to see bold typefaces wherever the new 8 Solarized colors are
displayed but it doesn't make much sense anymore.

### How Solarized works with 256-color themes

Newer versions of dircolors, as well as modern terminal emulators, support 256
colors.  Since 256 > 16, does this mean that 256-color dircolors themes are
better than ANSI dircolors themes for displaying the Solarized palette?  Not
necessarily.  Solarized is a 16-color palette with unique RGB values.
256-color terminal emulators have more colors than the ANSI palette but
completely different RGB values. (See [8-bit color
graphics](http://en.wikipedia.org/wiki/256_colors).) The "256dark"
theme was designed to use these standard fixed colors.

#### How Solarized could work with 256 colors without touching ANSI

There is ongoing
[discussion](https://github.com/altercation/solarized/issues/8) on how to
reconfigure the approximate Solarized colors (the default 256 XTerm colors) to
display the exact Solarized colors.  The benefit of this approach is that the
ANSI colors would not be messed with, and all the existing terminal
applications (with non-Solarized-aware color themes) that expect ANSI colors
would get ANSI colors; i.e. you would not see text accidentally disappear or
turn gray on you as soon as you change your terminal emulator's ANSI color
settings to Solarized.

The disadvantage of such a solution means that 8-color terminal applications
such as irssi or older dircolors would not be able to display Solarized
colors, no matter what theme they used.

Work on an official solution has not yet started but the
[discussion](https://github.com/altercation/solarized/issues/8) has presented
some working solutions, at least for XTerm and possibly other Linux terminal
emulators.


The Solarized Color Values
--------------------------

L\*a\*b values are canonical (White D65, Reference D50), other values are
matched in sRGB space.


    SOLARIZED HEX     16/8 TERMCOL  XTERM/HEX   L*A*B      sRGB        HSB
    --------- ------- ---- -------  ----------- ---------- ----------- -----------
    base03    #002b36  8/4 brblack  234 #1c1c1c 15 -12 -12   0  43  54 193 100  21
    base02    #073642  0/4 black    235 #262626 20 -12 -12   7  54  66 192  90  26
    base01    #586e75 10/7 brgreen  240 #4e4e4e 45 -07 -07  88 110 117 194  25  46
    base00    #657b83 11/7 bryellow 241 #585858 50 -07 -07 101 123 131 195  23  51
    base0     #839496 12/6 brblue   244 #808080 60 -06 -03 131 148 150 186  13  59
    base1     #93a1a1 14/4 brcyan   245 #8a8a8a 65 -05 -02 147 161 161 180   9  63
    base2     #eee8d5  7/7 white    254 #d7d7af 92 -00  10 238 232 213  44  11  93
    base3     #fdf6e3 15/7 brwhite  230 #ffffd7 97  00  10 253 246 227  44  10  99
    yellow    #b58900  3/3 yellow   136 #af8700 60  10  65 181 137   0  45 100  71
    orange    #cb4b16  9/3 brred    166 #d75f00 50  50  55 203  75  22  18  89  80
    red       #dc322f  1/1 red      160 #d70000 50  65  45 220  50  47   1  79  86
    magenta   #d33682  5/5 magenta  125 #af005f 50  65 -05 211  54 130 331  74  83
    violet    #6c71c4 13/5 brmagenta 61 #5f5faf 50  15 -45 108 113 196 237  45  77
    blue      #268bd2  4/4 blue      33 #0087ff 55 -10 -45  38 139 210 205  82  82
    cyan      #2aa198  6/6 cyan      37 #00afaf 60 -35 -05  42 161 152 175  74  63
    green     #859900  2/2 green     64 #5f8700 60 -20  65 133 153   0  68 100  60

NOTE:

*   For "256-color" themes, the XTERM/HEX column lists the approximate Solarized
    colors that are used (note the RGB values in the XTERM/HEX column only
    approximates the RGB values in the HEX column).
*   For "ANSI" themes, the TERMCOL column lists the ANSI colors that are replaced 
    with the Solarized colors listed under the HEX column.
