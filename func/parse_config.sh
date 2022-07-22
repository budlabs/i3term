#!/bin/bash

parse_config() {

  local config_file line key var re

  config_file="$XDG_CONFIG_HOME/i3term/config"
  
  [[ -f $config_file ]] || install -Dm644 "$_data_dir/config" "$config_file"

  re='^\s*([^#][^[:space:]=]+)\s*=\s*(.+)\s*$'

  while read -rs line ; do
    [[ $line =~ $re ]] && {
      key=${BASH_REMATCH[1]} var=${BASH_REMATCH[2]}

      case "$key" in

        font_large|font_default|default_instance ) conf[$key]=$var ;;
        xfce4-terminal_options                   ) conf[$key]=$var ;;
        xterm_options                            ) conf[$key]=$var ;;
        st_options                               ) conf[$key]=$var ;;
        urxvt_options                            ) conf[$key]=$var ;;
        default_palette                          ) conf[$key]=$var ;;

        font_size_default|font_size_large )
          if [[ $var =~ [^0-9] ]]; then
            ERM "config error, $key must be an integer." \
                "'$var' is invalid. setting ignored"
          else
            conf[$key]=$var
          fi
          ;;

        autolarge_containers )
          if [[ ${var^^} =~ [^ABCD] ]]; then
            ERM "config error, $key only accepts ABCD characters." \
                "'$var' is invalid. setting ignored"
          else
            conf[$key]=$var
          fi
          ;;

        terminal )
          var=${_o[terminal]:-"$var"}
          case "${var,,}" in
            xterm ) 
              _base_command=xterm 
              _terminal_class=XTerm
              ;;
            urxvt ) 
              _base_command=urxvtc 
              _terminal_class=URxvt
              ;;
            xfce4-terminal ) 
              _base_command=xfce4-terminal 
              _terminal_class=Xfce4-terminal
              ;;
            st ) 
              _base_command=st 
              _terminal_class=st-256color
              ;;
            *  ) ERX "config error, '$var' is not a supported terminal." ;;
          esac
          ;;
      esac
    }
  done < "$config_file"
}
