#!/bin/bash
# Description: Initialise l’environnement en fonction de l’OS

INIT_FLAG="$C_BOOTSTRAP/.init_done"

# ------------------------------
# 0. Charger l’environnement (paths, OS, buildflags…)
source "$C_BOOTSTRAP/core/load_env.sh"

# ------------------------------
# 1. First-time initialization
if [ ! -f "$INIT_FLAG" ]; then
    echo "[+] Initializing system for the first time..."

    # a. Installation des paquets
    case "$OS" in
        arch)   source "$C_BOOTSTRAP/os/arch.sh"   ;;
        ubuntu) source "$C_BOOTSTRAP/os/ubuntu.sh" ;;
        macos)  source "$C_BOOTSTRAP/os/macos.sh"  ;;
        *)      echo "❌ Unsupported OS: $OS" && exit 1 ;;
    esac

    # b. Setup post-installation générique (fonts, shell, nvm, plugins…)
    source "$C_BOOTSTRAP/core/tools_setup.sh"

    # c. Stow des dotfiles et création de dossiers
    source "$C_MODULES/folders_setup.sh"

    touch "$INIT_FLAG"
    echo "[✓] First-time initialization complete."
fi

# ------------------------------
source "$C_TOOLS/init.sh"
