#!/usr/bin/env bash
set -euo pipefail

# Determine script directory (bash/zsh-compatible)

# Determine script directory (zsh + bash compatible)
if [ -n "${BASH_SOURCE:-}" ]; then
  SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
elif [ -n "${ZSH_VERSION:-}" ]; then
  SCRIPT_DIR="$(cd "$(dirname "${(%):-%x}")" && pwd)"
else
  echo "⚠️ Unsupported shell: fallback to current directory" >&2
  SCRIPT_DIR="$(pwd)"
fi

echo "[debug] SCRIPT_DIR = $SCRIPT_DIR"

source "$SCRIPT_DIR/exports.sh"

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
