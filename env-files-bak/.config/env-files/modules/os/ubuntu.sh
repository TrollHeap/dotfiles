#!/usr/bin/env bash
set -euo pipefail

echo "[+] Starting Ubuntu-based setup..."

# 1. Core logic
source "$C_CORE/installer.sh"

# 2. Update system + dev essentials
sudo apt update && sudo apt upgrade -y
sudo apt install -y build-essential git curl wget unzip

# 3. Install packages from list
installer::from_file "$C_PKGS/ubuntu_apt.txt" apt

# 4. Setup tools via modules
source "$C_MODULES/shell/zsh.sh"
source "$C_MODULES/shell/ohmyzsh.sh"
source "$C_TOOLS/starship.sh"
source "$C_TOOLS/tmux_tpm.sh"
source "$C_TOOLS/nvm.sh"
source "$C_TOOLS/fzf.sh"
source "$C_TOOLS/wezterm.sh"
source "$C_TOOLS/pyenv.sh"
source "$C_TOOLS/nerdfonts.sh"



starship::install
tmux_tpm::install
nvm::install
fzf::install
wezterm::install
pyenv::install
nerdfonts::install


zsh::install
ohmyzsh::install
ohmyzsh::install_plugins
zsh::set_default_shell
