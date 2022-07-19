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
instance=termsmall, role=termsmall
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
