#!/bin/bash

[[ ! -d ~/.config ]] && mkdir ~/.config

# Cargando configurables en sus carpetas
cp -r nvim ~/.config/
cp -r kitty ~/.config/
cp .zsh_profile ~/
cp .zshrc ~/
cp .gitconfig ~/

###############################################################################
#                   NODE INSTALLATION
###############################################################################
# Download nvm (Node version Manager) repo for Node.js and npm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash
# Loads in terminla the NVM_DIR and exec the command that loads the program
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Install LTS version of NodeJS
nvm install --lts

###############################################################################
#                   NODE INSTALLATION
###############################################################################

