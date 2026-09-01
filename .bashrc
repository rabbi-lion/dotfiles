#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

stty -ixon
shopt -s autocd

HISTSIZE=
HISTFILESIZE=

PS1="\[$(tput bold)\]\[$(tput setaf 1)\][\[$(tput setaf 3)\]\u\[$(tput setaf 2)\]@\[$(tput setaf 4)\]\h \[$(tput setaf 5)\]\W\[$(tput setaf 1)\]]\[$(tput setaf 7)\]\\$ \[$(tput sgr0)\]"

alias sdn="sudo shutdown now"
alias srb="sudo reboot"

alias p="sudo pacman"
alias syu="sudo pacman -Syu"
alias v="mousepad"
alias t="thunar"
alias vim="nvim"
alias ka="killall"
alias trans="transmission-cli"
alias mkd="mkdir -pv"
alias lsp="pacman -Qett --color=always | less"
alias ls="ls -hN --color=auto --group-directories-first"
alias grep="grep --color=auto"
alias diff="diff --color=auto"
alias yt="yt-dlp"
alias yta="yt-dlp -f bestaudio -x --audio-format mp3 --audio-quality 0"
alias neofetch="fastfetch"
alias cdwm="mousepad ~/src/dwm/config.h >/dev/null 2>&1 & disown; exit"
alias mdwm="cd ~/src/dwm && sudo make clean install && cd -"
				
