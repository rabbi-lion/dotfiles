#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

# Add all directories in ~/.local/bin to $PATH
export PATH="$PATH:$(find "$HOME/.local/bin" -type d | paste -sd ':' -)"

# Default programs:
export EDITOR="mousepad"
export TERMINAL="st"
export BROWSER="firefox"

# XDG directories:
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"

# Other program settings:
export MOZ_USE_XINPUT2=1
export QT_QPA_PLATFORMTHEME="gtk3"
export _JAVA_AWT_WM_NONREPARENTING=1

# Start X on tty1 if not already running.
[[ -z $DISPLAY && $(tty) == /dev/tty1 ]] && exec startx