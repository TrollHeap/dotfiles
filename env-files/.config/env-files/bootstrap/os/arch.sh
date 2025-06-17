#!/usr/bin/env bash

# ╭────────────────────────────────────────────────────────────╮
# │ OS SETUP: Arch-based distributions (Arch, Manjaro, etc.)   │
# ╰────────────────────────────────────────────────────────────╯
source "$C_MODULES/loader_modules.sh"
echo "[+] Starting Arch-based setup..."

# 1. Ensure AUR helper is available
source "$C_CORE/init/installer.sh"
installer::aur_helper

# 2. System upgrade
echo "[+] Updating system via yay..."
yay -Syu --noconfirm

# 3. Install packages from lists
installer::from_file "$C_PKGS/arch_pacman.txt" pacman
installer::from_file "$C_PKGS/arch_aur.txt" yay

# 4. Source all tool modules
load_modules

# 5. Run installations
tmux_tpm::install
nvm::install
fzf::install 
wezterm::install
pyenv::install
nerdfonts::install
starship::install
glow::install

# 6. Finalize shell setup
zsh::install
ohmyzsh::install
ohmyzsh::install_plugins
zsh::set_default_shell

tldr --update
