This script makes managing terminals under [i3wm] easier.
It uses various scripts from [i3ass] and works with the
following terminals:  

- URxvt
- XTerm
- xfce4-terminal
- st

To use the **Theme-switcher-menu** you need **rofi**.

### installation

```
$ git clone https://github.com/budlabs/i3term.git
$ cd i3term
$ make
# make install
```

[i3wm]: https://i3wm.org
[i3ass]: https://github.com/budlabs/i3ass


## options

```
-a, --autotile                            | always creates a new window with instance "auto"
--bg                         COLOR        | set background color
-d, --cd                     DIR          | set initial working directory 
--dont-beam-me-up-scotty                  | no beam cursor
--dryrun                                  | dont execute commands  
--fg                         COLOR        | set foreground color
-f, --font                   FONT         | set font 
--font-size                  INT          | set font-size 
-G, --geometry               GEOMETRY     | set gemoetry (COLUMNSxLINES)
-h, --help                                | display help and exit 
--hide                                    | option will get redirected to i3run 
-i, --instance               INSTANCE     | instance name to target
--large-font                              | if setting "large_font" is set it will be used 
-l, --list-palettes                       | lists available palettes
--login                                   | passes '-l' to the shell 
-m, --mouse                               | option will get redirected to i3run 
-g, --nohide                              | option will get redirected to i3run 
-p, --palette                PALETTE|FILE | use the colors from palette
--palette-menu                            | short description  
--role                       ROLE         | this have the exact same function as --instance
--shell                      SHELL        | set shell, defaults to `$SHELL`
--st-options                 OPTIONS      | extra options passed to st
-s, --summon                              | option will get redirected to i3run 
--terminal                   TERMINAL     | terminal emulator (urxvt|xterm|st|xfce4-terminal)
--urxvt-options              OPTIONS      | extra options passed to urxvt
-V, --verbose                             | print command and script file to stderr  
-v, --version                             | print version and exit 
--xfce4-terminal-options     OPTIONS      | extra options passed to xfce4-terminal
--xterm-options              OPTIONS      | extra options passed to xterm
```


## EXAMPLES

### i3 keybinding configuration

```
set $X exec --no-startup-id exec

bindsym Mod4+Return         $X i3term --instance mainterm --large-font --palette base16-grayscale-light
bindsym Mod4+Control+Return $X i3term --autotile
bindsym Mod4+Shift+Return   $X i3term --instance floatterm --summon --geometry 50x8
bindsym Mod4+t              $X i3term --palette-menu
bindsym Mod4+v              $X typisktstart
```

### i3king config examples

```text
# ignore terminals with instance name "auto" (--autotile)
# from the DEFAULT rule.
DEFAULT \
  class=(URxvt|XTerm|st-256color) instance=auto, \
  class=Xfce4-terminal role=auto,
    floating enable, border normal 2, title_window_icon padding 3px

# TC is a variable for i3fyra --move A|B|C|D
set $TC exec --no-startup-id i3fyra --conid $CONID --move
set $X  exec --no-startup-id

# instace match XTerm|URxvt|st , role matches Xfce4-terminal
instance=mainterm, role=mainterm
  $TC A

# floatterm is put in a specific location with i3Kornhe
instance=floatterm, role=floatterm
  floating enable;                          \
  $X i3Kornhe --oneshot --margin 40 move 2  \

# typiskt is put on workspace 2
instance=typiskt, role=typiskt
  move to workspace 2, floating enable;        \
    $X i3Kornhe --oneshot --margin 300 move 4; \
    workspace 2
```


### typisktstart

This is just a wrapper script around [typiskt]. It is
convenient change properties in its own script.

```bash
#!/bin/bash

# aur/ttf-go-mono-git
# aur/typiskt
i3term --font "Go Mono" --font-size "16" \
       --palette clrs-light              \
       --geometry 50x12                  \
  -- typiskt --corpus english --lines 3
```

### sidopen

This script can be used to open *.sid* files (C64 music files).
With [sidplayfp] in a terminal using the C64 font and colors.

```bash
#!/bin/bash

# aur/ttf-c64
# extra/libsidplayfp
i3term --instance sidplayfp          \
       --bg '#2E2C9B' --fg '#706DEB' \
       --font ' C64 Pro Mono'        \
  -- sidplayfp -q "$1"
```
