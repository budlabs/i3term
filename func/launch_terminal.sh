#!/bin/bash

launch_terminal() {
  case "$_base_command" in
    # st and xterm is always started in the foreground by default
    st|xterm )
      nohup env BASHBUD_VERBOSE='' BASHBUD_LOG='' "${terminal_command[@]}" > /dev/null 2>&1 &
    ;;

    # make sure urxvtd is running before executing urxvtc
    urxvtc         )
      pidof urxvtd >/dev/null || {
        urxvtd -f > /dev/null 2>&1
        [[ ${_o[verbose]} || $BASHBUD_VERBOSE ]] \
          && ERM "started urxvtd..."
      }
      BASHBUD_VERBOSE='' BASHBUD_LOG='' "${terminal_command[@]}" > /dev/null 2>&1
    ;;

    # the first xfce4-terminal acts as the server and stays
    # in the foreground.
    xfce4-terminal )
      if pidof xfce4-terminal >/dev/null; then
        BASHBUD_VERBOSE='' BASHBUD_LOG='' "${terminal_command[@]}" > /dev/null 2>&1
      else
        nohup env BASHBUD_VERBOSE='' BASHBUD_LOG='' "${terminal_command[@]}" > /dev/null 2>&1 &
        [[ ${_o[verbose]} || $BASHBUD_VERBOSE ]] \
          && ERM "started xfce4-terminal server"
      fi
    ;;
  esac
}
