#!/bin/sh
#
# Shadowrun Returns Launcher
#

#XPATH=/opt/shadowrun/returns
XPATH="/home/hildigerr/Games/GOG/Shadowrun Returns/game"
LAUNCH=./Shadowrun

argv=()
while [ "$#" -gt 0 ]; do
  case $1 in
    --editor|-e)
      if [ -e "$XPATH/ShadowrunEditor" ]; then
        LAUNCH="env LD_LIBRARY_PATH=. ./ShadowrunEditor"
      else
        echo "Error: The Shadowrun Returns Editor is not installed."
        exit 1
      fi ;;
    *) argv+=("$1") ;; #eg: -logFile
  esac
  shift
done

cd "$XPATH"
$LAUNCH "${argv[@]}"

