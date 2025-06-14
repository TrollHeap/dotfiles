#!/usr/bin/env bash

# ╭────────────────────────────────────────────────────────────╮
# │ OS SETUP: macOS system configuration                       │
# ╰────────────────────────────────────────────────────────────╯

source "$C_MODULES/loader_modules.sh"
echo "[+] Starting macOS setup..."

# 1. Load core logic
source "$C_CORE/init/installer.sh"

# 2. Install Homebrew if missing
if ! command -v brew &>/dev/null; then
    echo "[+] Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
    echo "[✓] Homebrew already installed"
fi

# 3. Install Homebrew packages
installer::from_file "$C_PKGS/macos_brew.txt" brew

# 4. Source tool modules
load_modules

# 5. Tools setup
starship::install
tmux_tpm::install
nvm::install
fzf::install 
wezterm::install
pyenv::install 
nerdfonts::install
glow::install

# 6. Shell setup
zsh::install
zsh::set_default_shell
ohmyzsh::install
ohmyzsh::install_plugins

# 7. Optional aesthetic packs (ya)
if command -v ya &>/dev/null; then
    echo "[+] Applying ya aesthetic packs..."
    ya pack -a yazi-rs/flavors:catppuccin-mocha
    ya pack -a bennyyip/gruvbox-dark
else
    echo "[!] 'ya' not available — skipping visual packs"
fi
