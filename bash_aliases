#!/bin/bash

alias ll='ls -lh'
alias la='ls -Alh'
alias l='ls -CF'
alias df='df -h'
alias rm='rm -I'
alias du='du -sh'

alias ..='cd ..'

alias set-headset-rgb='headsetcontrol -l 0'

alias nordup='nordvpn c de && nordvpn set killswitch 1'
alias norddown='nordvpn d && nordvpn set killswitch 0'

alias update='sudo pacman -Syu && yay -Syu --noconfirm'
