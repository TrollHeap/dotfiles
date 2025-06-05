#!/usr/bin/env bash
set -euo pipefail


export DOTFILES="${DOTFILES:-$HOME/dotfiles}"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# 1. Charger les variables fondamentales
source "$SCRIPT_DIR/../config/variables.env"

# 2. Charger les chemins dynamiques + OS
source "$SCRIPT_DIR/env.sh"

echo "C_LOGS = $C_LOGS"
# --- Chemins et log ---
PKG_DIR="${C_PKGS:-$SCRIPT_DIR/../pkgs}"
LOG_FILE="$C_LOGS/pkg_verification.log"
mkdir -p "$C_LOGS"
> "$LOG_FILE"

echo "🔍 Verifying package names in: $PKG_DIR"
echo "Results will be logged to: $LOG_FILE"
echo

# --- Fonctions ---
check_pkg_pacman() { pacman -Si "$1" &>/dev/null; }
check_pkg_yay()    { yay -Si "$1" &>/dev/null; }

# --- Parcours des fichiers ---
for file in "$PKG_DIR"/*.txt; do
    echo "📦 Checking file: $(basename "$file")"

    case "$file" in
        *arch_pacman.txt) checker="check_pkg_pacman" ;;
        *arch_aur.txt)    checker="check_pkg_yay"    ;;
        *) echo "⚠️  Skipping unsupported file: $file"; continue ;;
    esac

    while IFS= read -r line || [[ -n "$line" ]]; do
        pkg="$(echo "$line" | sed 's/#.*//' | xargs)"
        [[ -z "$pkg" ]] && continue

        if ! $checker "$pkg"; then
            echo "❌ Package not found: $pkg" | tee -a "$LOG_FILE"
        else
            echo "✅ $pkg"
        fi
    done < "$file"

    echo
done

echo "🧾 Finished. Errors saved in: $LOG_FILE"
