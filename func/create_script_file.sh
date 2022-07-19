#!/bin/bash

create_script_file() {
  _temp_file="/tmp/i3term$EPOCHREALTIME"
  echo "#!/bin/sh" > "$_temp_file"

  palette_dir="$_data_dir/palettes"
  palette=${_o[palette]}
  : "${palette:=${conf[default_palette]}}"

  if [[ $palette && -f "$palette_dir/$palette" ]]; then
    echo "cat '$palette_dir/$palette'" >> "$_temp_file"
  elif [[ $palette && -f "$palette" ]]; then
    echo "cat '$palette'" >> "$_temp_file"
  fi

  # shellcheck disable=SC1003
  # SC1003: Want to escape a single quote?
  fmt_spe='\033]%d;%s\033\'
  is_hex='^#[0-9a-fA-F]{6}$'
  [[ ${_o[bg]} && ${_o[bg]} =~ $is_hex ]] && {
    # 708 - border background
    # 11  - default background
    # 10  - default foreground
    echo "printf '$fmt_spe' 708 '${_o[bg]}'"
    echo "printf '$fmt_spe' 11  '${_o[bg]}'"
  } >> "$_temp_file"

  [[ ${_o[fg]} && ${_o[fg]} =~ $is_hex ]] && {
    echo "printf '$fmt_spe' 10  '${_o[fg]}'"
  } >> "$_temp_file"

  # shellcheck disable=SC2016
  # SC2016: Expressions don't expand in single quotes.
  # set the title to the path (/dev/pts/X)
  echo 'printf "\033]0;%s\007" "$(tty)"' >> "$_temp_file"

  # shellcheck disable=SC2028
  # SC2028: echo may not expand escape sequences. Use printf.
  # [5: blinking beam cursor
  [[ ${_o[dont-beam-me-up-scotty]} ]] \
    || echo 'printf "\033[5 q\r"' >> "$_temp_file"

  # st doesn't support a commandline option to change
  # working directory, so just adding cd to the _temp_file
  # is more streamlined than adding checking for different
  # cli-options
  [[ -d ${_o[cd]} ]] && echo "cd '${_o[cd]}'" >> "$_temp_file"

  echo "{ sleep .2 ; rm -f '$_temp_file' ;} &" >> "$_temp_file"

  if [[ $1 ]] && command -v "$1" > /dev/null; then
    printf "exec"
    
    for arg; do
      if [[ $arg =~ ^([^[:space:]\'\"]+)$ ]]
        then echo -n " $arg"
        else echo -n " ${arg@Q}"
      fi
    done
  else
    [[ $1 ]] && echo "echo command not found: '$*'"
    echo "exec ${_o[shell]:-$SHELL}${_o[login]:+ -l}"
  fi >> "$_temp_file"

  
  chmod +x "$_temp_file"
  terminal_command+=("-e" "$_temp_file")
}
