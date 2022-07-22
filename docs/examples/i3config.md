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
