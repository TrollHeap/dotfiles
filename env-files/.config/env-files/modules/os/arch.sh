#!/usr/bin/env bash
set -euo pipefail

# ╭────────────────────────────────────────────────────────────╮
# │ OS SETUP: Arch-based distributions (Arch, Manjaro, etc.)   │
# ╰────────────────────────────────────────────────────────────╯

echo "[+] Starting Arch-based setup..."

# 1. Ensure AUR helper is available
source "$C_CORE/installer.sh"
installer::aur_helper

# 2. System upgrade
echo "[+] Updating system via yay..."
yay -Syu --noconfirm

# 3. Install packages from lists
installer::from_file "$C_PKGS/arch_pacman.txt" pacman
installer::from_file "$C_PKGS/arch_aur.txt" yay

# 4. Source all tool modules
source "$C_MODULES/shell/zsh.sh"
source "$C_MODULES/shell/ohmyzsh.sh"
source "$C_TOOLS/starship.sh"
source "$C_TOOLS/tmux_tpm.sh"
source "$C_TOOLS/nvm.sh"
source "$C_TOOLS/fzf.sh"
source "$C_TOOLS/wezterm.sh"
source "$C_TOOLS/pyenv.sh"
source "$C_TOOLS/nerdfonts.sh"

# 5. Run installations
tmux_tpm::install
nvm::install
fzf::install 
wezterm::install
pyenv::install
nerdfonts::install
starship::install

# 6. Finalize shell setup
zsh::install
ohmyzsh::install
ohmyzsh::install_plugins
zsh::set_default_shell
