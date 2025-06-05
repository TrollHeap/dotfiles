#!/usr/bin/env bash
set -euo pipefail

# 0. Charger variables fondamentales
source "$HOME/dotfiles/env-files/config/variables.env"

# 1. Détection OS
detect_os() {
    if [[ "$OSTYPE" == "darwin"* ]]; then
        echo "macos"; return
    fi
    if [[ -f /etc/os-release ]]; then
        . /etc/os-release
        case "$ID" in
            arch | manjaro | cachyos | endeavouros) echo "arch" ;;
            ubuntu | debian) echo "ubuntu" ;;
            fedora) echo "fedora" ;;
            *) echo "$ID" ;;
        esac
        return
    fi
    echo "unknown"
}

export OS="$(detect_os)"

# 2. Vérification de double sourcing
[[ -n "${C_ENV_LOADED:-}" ]] && return
export C_ENV_LOADED=1

# 3. Export de la racine (si manquante)
export ENV_ROOT="$DOT_ENV"

# 4. Sanity check des variables critiques
: "${DOTFILES:?DOTFILES not set}"
: "${C_PATHS:?C_PATHS not set}"
: "${OS:?OS not detected}"

# 4. Paths globaux (logiciels, etc.)
if [[ -f "$C_PATHS/global.env" ]]; then
    source "$C_PATHS/global.env"
else
    echo "❌ Missing: $C_PATHS/global.env"
    exit 1
fi

# 5. Per-OS path vars
case "$OS" in
    macos)  [[ -f "$C_PATHS/macos-paths.env" ]] && source "$C_PATHS/macos-paths.env" ;;
    arch)   [[ -f "$C_PATHS/arch-paths.env" ]] && source "$C_PATHS/arch-paths.env" ;;
    ubuntu) [[ -f "$C_PATHS/ubuntu-paths.env" ]] && source "$C_PATHS/ubuntu-paths.env" ;;
    *)      echo "⚠️ No OS-specific paths for $OS" ;;
esac

# 6. Buildflags optionnels
[[ -f "$C_CONFIG/buildflag/${OS}_buildflags.env" ]] && source "$C_CONFIG/buildflag/${OS}_buildflags.env"
