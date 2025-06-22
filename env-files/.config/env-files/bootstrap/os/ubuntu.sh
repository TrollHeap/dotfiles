#!/usr/bin/env bash

# ╭────────────────────────────────────────────────────────────╮
# │ OS SETUP: Ubuntu and Debian-based systems                  │
# ╰────────────────────────────────────────────────────────────╯

source "$C_MODULES/loader_modules.sh"
echo "[+] Starting Ubuntu-based setup..."

# 1. Core installer
source "$C_CORE/init/installer.sh"

# 2. System update and base dev tools
sudo apt update && sudo apt upgrade -y
sudo apt install -y build-essential git curl wget unzip

# 3. Install packages from list
installer::from_file "$C_PKGS/ubuntu_apt.txt" apt

# 4. Source tool modules
load_modules

# 5. Install tools
tmux_tpm::install
nvm::install
fzf::install
#wezterm::install
pyenv::install
nerdfonts::install
starship::install
glow::install

# 6. Finalize shell
zsh::install
ohmyzsh::install
ohmyzsh::install_plugins
zsh::set_default_shell
