#!/bin/bash

# Initialisation et configuration post-install commune
source "$C_TOOLS/fzf.sh"
source "$C_TOOLS/pyenv.sh"
source "$C_TOOLS/nvm.sh"
source "$C_TOOLS/zsh.sh"
source "$C_TOOLS/ohmyzsh.sh"
source "$C_TOOLS/starship.sh"
source "$C_TOOLS/tmux_tpm.sh"
source "$C_TOOLS/nerdfonts.sh"

# Init + config
fzf::setup_bindings
pyenv::init
nvm::init
zsh::set_default_shell
ohmyzsh::install
ohmyzsh::install_plugins
starship::install
nerdfonts::install
tmux_tpm::install
