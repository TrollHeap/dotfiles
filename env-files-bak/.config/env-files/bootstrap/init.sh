#!/usr/bin/env bash
set -euo pipefail

# 0. Charger variables fondamentales
source "$HOME/dotfiles/env-files/.config/env-files/config/variables.env"

# 0. Charger l’environnement (chemins, OS, flags)
source "$C_CORE/env.sh"
source "$C_CORE/state.sh"

INIT_FLAG="bootstrap"
if state::is_done "$INIT_FLAG"; then
    echo "[✓] Bootstrap already completed — skipping"
    exit 0
fi

echo "[+] Starting full environment bootstrap..."

# 2. Appel du setup OS
case "$OS" in
    arch)   source "$C_MODULES/os/arch.sh" ;;
    ubuntu) source "$C_MODULES/os/ubuntu.sh" ;;
    macos)  source "$C_MODULES/os/macos.sh" ;;
    *)      echo "❌ Unsupported OS: $OS" && exit 1 ;;
esac

# 3. Initialisation post-OS : dotfiles, workspace, etc.
#source "$C_MODULES/dotfiles/setup.sh"     # si tu en crées un
source "$C_MODULES/workspace/setup.sh"    # idem

# 4. Marquage comme terminé
state::mark_done "$INIT_FLAG"

echo "[✓] Bootstrap completed."
