#!/usr/bin/env bash
set -euo pipefail

echo "[+] Starting macOS setup..."

# 1. Sourcing core system
source "$C_CORE/installer.sh"

# 2. Install Homebrew if missing
if ! command -v brew &>/dev/null; then
    echo "[+] Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
    echo "[✓] Homebrew already installed"
fi

# 3. Install brew packages from list
installer::from_file "$C_PKGS/macos_brew.txt" brew

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

zsh::install
zsh::set_default_shell

ohmyzsh::install
ohmyzsh::install_plugins

starship::install
tmux_tpm::install
nvm::install
fzf::install 
wezterm::install
pyenv::install 
nerdfonts::install

# 5. Ya packing (macOS-specific aesthetic packages)
if command -v ya &>/dev/null; then
    echo "[+] Applying ya packs…"
    ya pack -a yazi-rs/flavors:catppuccin-mocha
    ya pack -a bennyyip/gruvbox-dark
else
    echo "[!] 'ya' not available — skipping aesthetic packs"
fi
