#!/bin/bash

declare -g _msgstring

messy() {
  # arguments are valid i3-msg arguments
  (( _o[verbose] )) && ERM "m $*"
  (( _o[dryrun]  )) || _msgstring+="$*;"
}
