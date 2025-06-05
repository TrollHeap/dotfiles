#!/bin/bash

echo "[+] Starting Arch-based setup..."

# Source package installer + tools
source "$C_FUNCTIONS/install_pkgs.sh"
source "$C_TOOLS/zsh.sh"
source "$C_TOOLS/wezterm.sh"
source "$C_TOOLS/starship.sh"
source "$C_TOOLS/tmux_tpm.sh"
source "$C_TOOLS/nvm.sh"

# 1. Ensure yay is installed
if ! command -v yay &>/dev/null; then
    echo "[+] Installing yay from AUR..."
    sudo pacman -S --needed --noconfirm base-devel git
    git clone https://aur.archlinux.org/yay.git /tmp/yay
    cd /tmp/yay && makepkg -si --noconfirm && cd -
fi

# 2. Update the system
echo "[+] Updating system with yay..."
yay -Syu --noconfirm

# 3. Install native pacman packages
install_pkgs "$C_ENV/pkgs/arch_pacman.txt" pacman

# 4. Install AUR packages
install_pkgs "$C_ENV/pkgs/arch_aur.txt" yay

# 5. Tool setup (if not in packages)
zsh::installed      || yay -S --noconfirm zsh
starship::installed || pacman -S starship
tmux_tpm::installed || tmux_tpm::install
nvm::installed      || nvm::install
wezterm::installed || wezterm::install
