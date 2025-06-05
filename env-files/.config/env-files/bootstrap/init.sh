#!/usr/bin/env bash
set -euo pipefail

# ╭──────────────────────────────────────────────────────────────╮
# │ ENVIRONMENT BOOTSTRAP - Full Init Sequence                   │
# ╰──────────────────────────────────────────────────────────────╯

# --- 0. Load core variables
source "$HOME/dotfiles/env-files/.config/env-files/config/variables.env"

# --- 1. Load environment (paths, OS detection, flags)
source "$C_CORE/env.sh"
source "$C_CORE/state.sh"

INIT_FLAG="bootstrap"
if state::is_done "$INIT_FLAG"; then
    echo "[✓] Bootstrap already completed — skipping"
    exit 0
fi

echo "[+] Starting full environment bootstrap..."

# --- 2. OS-specific setup
case "$OS" in
    arch)   source "$C_MODULES/os/arch.sh" ;;
    ubuntu) source "$C_MODULES/os/ubuntu.sh" ;;
    macos)  source "$C_MODULES/os/macos.sh" ;;
    *)      echo "❌ Unsupported OS: $OS" && exit 1 ;;
esac

# --- 3. Post-OS initialization ( workspace, etc.)
source "$C_MODULES/workspace/setup.sh"

# --- 4. Mark bootstrap as complete
state::mark_done "$INIT_FLAG"

echo "[✓] Bootstrap completed."
