#!/bin/bash

theme_menu() {

  local class stdin_term

  [[ -d "$_data_dir"/palettes ]] \
    || ERX "could not locate palettes dir, consider reinstall"

  read -rs class stdin_term < <(i3get -r ct --print-format '%v ')

  [[ $class =~ (URxvt|XTerm|st-256color|Xfce4-terminal) && $stdin_term =~ ^/dev/pts/[0-9]+$ ]] || {
    notify-send -u critical \
      '"i3term --palette-menu" only work on terminals'
    exit
  }

  palettes_dir="$_data_dir"/palettes
  palettes=("$palettes_dir/"*)

  choice=$(i3term --list palettes | 
    i3menu --layout window \
           --yoffset 25    \
           --xoffset 7     \
           --width 200     \
           --height 150
           )
  [[ $choice ]] && target="$palettes_dir/$choice"
  [[ -f $target ]] && cat "$target" >> "$stdin_term"
}
