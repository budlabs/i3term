#!/bin/bash

set_options() {
  
  [[ ${_o[geometry]} ]] && {
    case "$_base_command" in
      xterm|urxvtc   ) terminal_command+=("-geometry" "${_o[geometry]}") ;;
      st             ) terminal_command+=("-g" "${_o[geometry]}") ;;
      xfce4-terminal ) terminal_command+=("--geometry" "${_o[geometry]}") ;;
    esac
  }

  extra_options=${_o[${_base_command}-options]}
  : "${extra_options:=${conf[${_base_command}_options]}}"

  [[ $extra_options ]] && {
    mapfile -t tmp_o <<< "${extra_options// /$'\n'}"
    terminal_command+=("${tmp_o[@]}")
    unset 'tmp_o[@]'
  }
}
