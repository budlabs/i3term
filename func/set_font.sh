#!/bin/bash

auto_large_font() {
  declare -a virtual_positions
  declare -A i3list
  declare active_parent active_virtual actual_container re

  [[ ${_o[font]} ]] && return

  [[ ${conf[autolarge_containers]} && ${conf[font_large]} ]] && {
    virtual_positions=(A B C D)
    eval "$(i3list)"
    active_parent=${i3list[AWP]}
    active_virtual=${i3list[VP${active_parent}]}
    actual_container=${virtual_positions[$active_virtual]}
    re="[${conf[autolarge_containers]^^}]"
    [[ ${actual_container:-E} =~ $re ]] && _o[large-font]=1
  }
}

set_font() {
  if [[ ${_o[font]} ]]; then
    font_face="${_o[font]}"
  elif [[ ${_o[large-font]} && ${conf[font_large]} ]]; then
    font_face=${conf[font_large]}
    font_size=${conf[font_size_large]}
  elif [[ ${conf[font_default]} ]]; then
    font_face=${conf[font_default]}
    font_size=${conf[font_size_default]}
  fi

  [[ $font_face ]] && {
    
    : "${_o[font-size]:=${font_size}}"
    : "${_o[font-size]:=${conf[font_size_default]:-12}}"

    case "$_base_command" in
      st             ) terminal_command+=("-f" "$font_face:size=${_o[font-size]}")      ;;
      xterm          ) terminal_command+=("-fa" "xft:$font_face:size=${_o[font-size]}") ;;
      urxvtc         ) terminal_command+=("-fn" "xft:$font_face:size=${_o[font-size]}") ;;
      xfce4-terminal ) terminal_command+=("--font" "$font_face ${_o[font-size]}")       ;;
    esac
  }
}
