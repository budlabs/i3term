### i3king config examples

```text
# TC is a variable for i3fyra --move A|B|C|D
set $TC exec --no-startup-id i3fyra --conid $CONID --move
set $X  exec --no-startup-id

# ignore terminals with instance name "auto" (--autotile)
# from the DEFAULT rule.
DEFAULT \
  class=(URxvt|XTerm|st-256color) instance=auto, \
  class=Xfce4-terminal role=auto
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
