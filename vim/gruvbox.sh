#!/bin/bash

function download_gruvbox() {

    mkdir -p ~/.vim/colors
    echo "created ~/.vim/colors"
    cd ~/.vim/colors

    git clone https://github.com/morhetz/gruvbox.git
    mv gruvbox/colors/gruvbox.vim ~/.vim/colors

    echo "downloaded gruvbox"
}

download_gruvbox
