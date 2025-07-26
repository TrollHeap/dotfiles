#!/usr/bin/env bash
set -euo pipefail
# ╭──────────────────────────────────────────────────────────────╮
# │ ENVIRONMENT BOOTSTRAP - Full Init Sequence                   │
# ╰──────────────────────────────────────────────────────────────╯

# --- 0. Load core variables

ROOT_ENV="${ROOT_ENV:-${DOTFILES:-$HOME/dotfiles}/env-files/.config/env-files}"

source "$ROOT_ENV/config/env/globals_locals.env"

# --- 1. Load environment (paths, OS detection, flags)
echo "Loading env"
source "$ROOT_ENV/main.sh"

echo "[✓] Testing init state"
source "$ROOT_ENV/core/lib/state.sh"
echo "[✓] Testing init state - skipped"

INIT_FLAG="bootstrap"

if state::is_done "$INIT_FLAG"; then
    echo "[✓] Bootstrap already completed — skipping"
    exit 0
fi

echo "[+] Starting full environment bootstrap..."

# --- 2. OS-specific setup
case "$OS" in
    fedora)  source "$ROOT_ENV/core/bootstrap/os/fedora.sh" ;;
    ubuntu) source "$ROOT_ENV/core/bootstrap/os/ubuntu.sh" ;;
    *)      echo "❌ Unsupported OS: $OS" ;;
esac

# --- 3. Post-OS initialization ( workspace, etc.)

eval "$(zoxide init bash)"

# Setup script to deploy dotfiles using GNU Stow
echo "[+] Removing existing ~/.bashrc"
rm -f "$HOME/.bashrc"
rm -f "$HOME/.bash_profile"

if ! command -v stow >/dev/null; then
    echo "❌ stow is not installed. Please install GNU stow first." >&2
    exit 1
fi

echo "[+] Stowing modules..."
cd "$HOME/dotfiles"
stow bash starship alacritty tmux nvim yazi scripts task

cd - >/dev/null

[[ -f "$HOME/.bashrc" ]] && source "$HOME/.bashrc" || echo "⚠️ Cannot source outside login shell"

# --- 4. Mark bootstrap as complete
state::mark_done "$INIT_FLAG"

echo "[✓] Bootstrap completed."
