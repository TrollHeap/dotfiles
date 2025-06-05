#!/usr/bin/env bash
set -euo pipefail

echo "[+] Starting Arch-based setup..."

# 1. Ensure yay is available
source "$C_CORE/installer.sh"
installer::aur_helper

# 2. Update system
echo "[+] Updating system via yay..."
yay -Syu --noconfirm

# 3. Install OS-wide packages
installer::from_file "$C_PKGS/arch_pacman.txt" pacman
installer::from_file "$C_PKGS/arch_aur.txt" yay

# 4. Setup shell & tools via modules
source "$C_MODULES/shell/zsh.sh"
source "$C_MODULES/shell/ohmyzsh.sh"
source "$C_TOOLS/starship.sh"
source "$C_TOOLS/tmux_tpm.sh"
source "$C_TOOLS/nvm.sh"
source "$C_TOOLS/fzf.sh"
source "$C_TOOLS/wezterm.sh"
source "$C_TOOLS/pyenv.sh"
source "$C_TOOLS/nerdfonts.sh"


tmux_tpm::install
nvm::install
fzf::install 
wezterm::install
pyenv::install
nerdfonts::install
starship::install

zsh::install
ohmyzsh::install
ohmyzsh::install_plugins
zsh::set_default_shell
