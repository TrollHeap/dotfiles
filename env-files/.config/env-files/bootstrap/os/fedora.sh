#!/usr/bin/env bash

# ╭────────────────────────────────────────────────────────────╮
# │ OS SETUP: Fedora-based distributions (Fedora, Nebora, etc.)│
# ╰────────────────────────────────────────────────────────────╯

source "$C_MODULES/loader_modules.sh"
echo "[+] Starting Fedora-based setup..."

# 1. Ensure installer core is available
source "$C_CORE/init/installer.sh"

# 2. System upgrade
echo "[+] Updating system via dnf..."
sudo dnf upgrade --refresh -y

# 3. Install packages from lists
installer::from_file "$C_PKGS/fedora_dnf.txt" dnf

# 4. Source all tool modules
load_modules

# 5. Run installations
tmux_tpm::install
nvm::install
pyenv::install
nerdfonts::install
starship::install
#glow::install

echo "[+] Installing Rust and Cargo..."
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh


echo "[+] Installing lazydocker..."
sudo dnf copr enable atim/lazydocker | tee -a /tmp/install.log
sudo dnf install lazydocker | tee -a /tmp/install.log

echo "[+] Installing spotify_layer term..."
cargo install spotify_player --locked

echo "[+] Updating tldr..."

tldr --update
