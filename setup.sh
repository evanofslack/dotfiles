#!/bin/sh


function check() {
    if ! hash "$1" > /dev/null 2>&1; then
        echo "Command not found: $1. Aborting..."
        exit 1
    fi
}


function setup() {
check stow
check curl

mkdir -p "$HOME/.config"
echo "created $HOME/.config"
}


function macos() {
    stow --verbose --target=$$HOME --restow alacritty
    stow --verbose --target=$$HOME --restow atuin
    stow --verbose --target=$$HOME --restow btop
    stow --verbose --target=$$HOME --restow gh
    stow --verbose --target=$$HOME --restow git
    stow --verbose --target=$$HOME --restow karabiner
    stow --verbose --target=$$HOME --restow lf
    stow --verbose --target=$$HOME --restow neofetch
    stow --verbose --target=$$HOME --restow nvim
    stow --verbose --target=$$HOME --restow skhd
    stow --verbose --target=$$HOME --restow starship
    stow --verbose --target=$$HOME --restow tmux
    stow --verbose --target=$$HOME --restow vim
    stow --verbose --target=$$HOME --restow yabai
    stow --verbose --target=$$HOME --restow zsh
}

function arch() {
    stow --verbose --target=$$HOME --restow alacritty
    stow --verbose --target=$$HOME --restow atuin
    stow --verbose --target=$$HOME --restow btop
    stow --verbose --target=$$HOME --restow gh
    stow --verbose --target=$$HOME --restow git
    stow --verbose --target=$$HOME --restow lf
    stow --verbose --target=$$HOME --restow neofetch
    stow --verbose --target=$$HOME --restow nvim
    stow --verbose --target=$$HOME --restow starship
    stow --verbose --target=$$HOME --restow tmux
    stow --verbose --target=$$HOME --restow vim
    stow --verbose --target=$$HOME --restow zsh
}

function remove() {
    stow --verbose --target=$$HOME --delete */
}

$*
