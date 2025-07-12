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
source "$C_CORE/main.sh"

echo "[✓] Testing init state"
source "$C_CORE/init/state.sh"
echo "[✓] Testing init state - skipped"
INIT_FLAG="bootstrap"
if state::is_done "$INIT_FLAG"; then
    echo "[✓] Bootstrap already completed — skipping"
    exit 0
fi

echo "[+] Starting full environment bootstrap..."

# --- 2. OS-specific setup
case "$OS" in
    arch)   source "$C_BOOTSTRAP/os/arch.sh" ;;
    fedora)  source "$C_BOOTSTRAP/os/fedora.sh" ;;
    ubuntu) source "$C_BOOTSTRAP/os/ubuntu.sh" ;;
    macos)  source "$C_BOOTSTRAP/os/macos.sh" ;;
    *)      echo "❌ Unsupported OS: $OS" ;;
esac

# --- 3. Post-OS initialization ( workspace, etc.)
source "$C_MODULES/workspace/setup.sh"
source "$C_MODULES/app/remnote.sh"

eval "$(zoxide init bash)"
# --- 4. Mark bootstrap as complete
state::mark_done "$INIT_FLAG"

echo "[✓] Bootstrap completed."
