#!/bin/bash

echo "[+] Starting Ubuntu-based setup..."

# Source installer and tools
source "$C_FUNCTIONS/install_pkgs.sh"
source "$C_TOOLS/zsh.sh"
source "$C_TOOLS/wezterm.sh"
source "$C_TOOLS/starship.sh"
source "$C_TOOLS/tmux_tpm.sh"
source "$C_TOOLS/nvm.sh"

# 1. Update and install build tools
sudo apt update && sudo apt upgrade -y
sudo apt install -y build-essential git curl wget unzip

# 2. Install apt packages
install_pkgs "$C_ENV/pkgs/ubuntu_apt.txt" apt

# 3. Install missing tools
zsh::installed      || sudo apt install -y zsh
wezterm::installed  || sudo apt install -y wezterm  # ou méthode custom
starship::installed || curl -sS https://starship.rs/install.sh | sh
tmux_tpm::installed || tmux_tpm::install
nvm::installed      || nvm::install
