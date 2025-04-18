#!/bin/sh
#
# Shadowrun Returns Launcher
#

XPATH=/opt/shadowrun/returns
LAUNCH=./Shadowrun

argv=()
while [ "$#" -gt 0 ]; do
  case $1 in
    --editor|-e)
      if [ -e "$XPATH/ShadowrunEditor" ]; then
        LAUNCH=./ShadowrunEditor
      else
        echo "Error: The Shadowrun Returns Editor is not installed."
        exit 1
      fi ;;
    *) argv+=("$1") ;; #eg: -logFile "$XDG_DATA_HOME/Shadowrun/returns-output.log"
  esac
  shift
done

export XDG_DATA_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/Shadowrun"
xdg-launch --cd "$XPATH" $LAUNCH -- "${argv[@]}"

