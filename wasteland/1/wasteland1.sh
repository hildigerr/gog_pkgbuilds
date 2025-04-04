#!/bin/sh
#
# Launcher for Wasteland 1 (Enforcing XDG Base Directory Compliance)
#
#  Wasteland 1 will create "$HOME/.wasteland" for Saves and Settings.
#  So, we redefine HOME to enforce compliance.
#  However, it needs to be able to find the Xauthority file.
#  So, we temporarily link it.
#  Also uses $HOME/.config/pulse/cookie
#  So, we temporarily link the config directory too, enforcing user's
#  XDG_CONFIG_HOME setting.
#

# Determine Where User Config Files Should Go
XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-${HOME}/.config}"
echo "XDG_CONFIG_HOME is \"${XDG_CONFIG_HOME}\""

# Create User Config Home (Should be Unnecessary)
if [ ! -d "${XDG_CONFIG_HOME}" ]; then
  echo "Creating \"${XDG_CONFIG_HOME}\""
  mkdir -p "${XDG_CONFIG_HOME}"
fi

# Determine Where User Data Files Should Go
XDG_DATA_HOME=${XDG_DATA_HOME:-${HOME}/.local/share}
echo "XDG_DATA_HOME is \"${XDG_DATA_HOME}\""

# Create User Data Home (Should be Unnecessary)
if [ ! -d "${XDG_DATA_HOME}" ]; then
  echo "Creating \"${XDG_DATA_HOME}\""
  mkdir -p "${XDG_DATA_HOME}"
fi

# Link Xauthority file (Only if it Known to be Necessary)
if [[ -n "$XAUTHORITY" && -f "$XAUTHORITY" ]]; then
  # User has XAUTHORITY setting, lets see if it works withough a cludge.
  echo "XXX: NOT temporarily linking your XAUTHORITY file."
  echo "     Please, let the PKGBUILD maintainer know if this works."
elif [[ -f "${HOME}/.Xauthority" && ! -f "${XDG_DATA_HOME}/.Xauthority" ]]; then
  echo "Linking ~/.Xauthority within \"${XDG_DATA_HOME}\""
  ln -T "${HOME}/.Xauthority" "${XDG_DATA_HOME}/.Xauthority"
else
  # Unknown handling of XAUTHORITY, lets see if it is needed.
  echo "XXX: NOT temporarily linking your XAUTHORITY file."
  echo "     Please, let the PKGBUILD maintainer know if you have any issues."
fi

# Link User's Config Home
if [ ! -e "${XDG_DATA_HOME}/.config" ]; then
  echo "Linking User's Config Home..."
  ln --symbolic -T "${XDG_CONFIG_HOME}" "${XDG_DATA_HOME}/.config"
fi

cd /opt/wasteland1
env HOME="${XDG_DATA_HOME}" ./wasteland

# Unlink the Xauthority file (Only if it has more than one link)
if [[ -f "${XDG_DATA_HOME}/.Xauthority" ]]; then
  links=$(stat -c "%h" "${XDG_DATA_HOME}/.Xauthority")
  if [[ "$links" -gt 1 ]]; then
  echo "Unlinking temporary Xauthority file"
    unlink "${XDG_DATA_HOME}/.Xauthority"
  fi
fi

# Unlink User's Config Home
if [ -L "${XDG_DATA_HOME}/.config" ]; then
  echo "Unlinking temporary config home"
  unlink "${XDG_DATA_HOME}/.config"
fi

