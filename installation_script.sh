#!/bin/bash

[[ ! -d ~/.config ]] && mkdir ~/.config

cp -r nvim ~/.config/
cp -r kitty ~/.config/
cp .zsh_profile ~/
cp .zshrc ~/
cp .gitconfig ~/
