#!/usr/bin/env bash

# ╭────────────────────────────────────────────────────────────╮
# │ OS SETUP: Fedora-based distributions (Fedora, Nebora, etc.)│
# ╰────────────────────────────────────────────────────────────╯

# 1. Ensure installer core is available
echo "[+] Starting Fedora-based setup..."
if ! command -v stow &>/dev/null; then
    echo "stow non trouvé, installation..."
    sudo dnf install -y stow
else
    echo "stow déjà présent."
fi

if ! command -v make &>/dev/null; then
    echo "make non trouvé, installation..."
    sudo dnf install -y make
else
    echo "make déjà présent."
fi

source "$ROOT_ENV/core/lib/installer.sh"
source "$ROOT_ENV/core/modules/loader_modules.sh"
# 2. System upgrade
echo "[+] Updating system via dnf..."
sudo dnf upgrade --refresh -y

# 3. Install packages from lists
installer::from_file "$ROOT_ENV/core/pkgs/fedora_dnf.txt" dnf

# 4. Source all tool modules
load_modules

# 5. Run installations
tmux_tpm::install
nvm::install
pyenv::install
nerdfonts::install
starship::install
#glow::install

echo "[+] Checking Rust/Cargo..."

if command -v cargo &>/dev/null; then
    echo "[✓] Rust déjà installé — skipping"
else
    echo "[+] Installing Rust and Cargo..."
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
    echo "[✓] Rust installation completed"
fi

#!/usr/bin/env bash

LOG="/tmp/install.log"
mkdir -p "$(dirname "$LOG")"

log() { echo -e "[+] $1" | tee -a "$LOG"; }

# ─── Install lazydocker via COPR ─────────────────────────────────────────
if ! command -v lazydocker &>/dev/null; then
    log "Installing lazydocker..."
    sudo dnf -y copr enable atim/lazydocker | tee -a "$LOG"
    sudo dnf -y install lazydocker | tee -a "$LOG"
else
    log "lazydocker already installed — skipping"
fi

# ─── Install spotify_player via cargo ────────────────────────────────────
if ! command -v spotify_player &>/dev/null; then
    log "Installing spotify_player (cargo)..."
    cargo install spotify_player --locked | tee -a "$LOG"
else
    log "spotify_player already installed — skipping"
fi

# ─── Enable RPM Fusion Repos (free & nonfree) ────────────────────────────
if ! sudo dnf repolist | grep -q rpmfusion-free; then
    log "Enabling RPM Fusion repositories..."
    sudo dnf install -y \
        "https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm" \
        "https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm" \
        | tee -a "$LOG"
else
    log "RPM Fusion already enabled — skipping"
fi

# ─── Install Steam ───────────────────────────────────────────────────────
if ! command -v steam &>/dev/null; then
    log "Installing Steam..."
    sudo dnf upgrade --refresh -y | tee -a "$LOG"
    sudo dnf install -y steam | tee -a "$LOG"
else
    log "Steam already installed — skipping"
fi

# ─── Source ble.sh interactively only ────────────────────────────────────
if [[ $- == *i* ]]; then
    log "Sourcing ble.sh (interactive shell)..."
    source "$ROOT_ENV/core/modules/shell/ble-sh.sh"
else
    log "Not sourcing ble.sh (non-interactive shell)"
fi

# ─── Clone wallpapers if missing ─────────────────────────────────────────
WALLPAPER_DIR="$HOME/Pictures/wallpaper"
if [[ -d "$WALLPAPER_DIR/.git" ]]; then
    log "Wallpapers already cloned — skipping"
else
    log "Cloning wallpapers into ~/Pictures..."
    git clone --depth=1 https://github.com/mylinuxforwork/wallpaper.git "$WALLPAPER_DIR" | tee -a "$LOG"
fi

echo "[+] Updating tldr..."

tldr --update

