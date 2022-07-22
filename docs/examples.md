### i3 keybinding configuration

The `$exec` and `$super` variables are compatible 
with the configuration example from the [i3ass wiki].

```
set $exec exec --no-startup-id exec
set $super bindsym Mod4

$super+Return         $exec i3term --instance mainterm --large-font --palette base16-grayscale-light
$super+Control+Return $exec i3term --autotile
$super+Shift+Return   $exec i3term --instance floatterm --summon --geometry 50x8
$super+t              $exec i3term --palette-menu
$super+v              $exec typisktstart
```

### i3king config examples

```text
# TC is a variable for i3fyra --move A|B|C|D
set $TC exec --no-startup-id i3fyra --conid $CONID --move
set $X  exec --no-startup-id

# ignore terminals with instance name "auto" (--autotile)
# from the DEFAULT rule.
DEFAULT \
  class=(URxvt|XTerm|st-256color) instance=auto, \
  class=Xfce4-terminal role=auto,
    floating enable, border normal 2, title_window_icon padding 3px

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

instance=sidplayfp class=(URxvt|XTerm|st-256color), \
role=sidplayfp class=Xfce4-terminal
  $TC A
```


### typisktstart

This is just a wrapper script around [typiskt]. It is
convenient to change properties in its own script.
![typiskt](https://user-images.githubusercontent.com/2143465/180494963-6053eddb-6bc8-4493-a75f-e64179344df0.png)

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
![sidplay](https://user-images.githubusercontent.com/2143465/180494442-8d05be72-7ece-4b72-ba9d-02096316c622.png)

```bash
#!/bin/bash

# aur/ttf-c64
# extra/libsidplayfp
i3term --instance sidplayfp          \
       --bg '#2E2C9B' --fg '#706DEB' \
       --font ' C64 Pro Mono'        \
       --geometry 56x16              \
  -- sidplayfp -q "$1"
```


