#!/usr/bin/env bash
set -euo pipefail

# ╭──────────────────────────────────────────────────────────────╮
# │ VERIFY_PKGS - Check existence of packages in repo / AUR      │
# ╰──────────────────────────────────────────────────────────────╯

export DOTFILES="${DOTFILES:-$HOME/dotfiles}"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# --- Load environment variables
source "$SCRIPT_DIR/../config/variables.env"
source "$SCRIPT_DIR/env.sh"

# --- Prepare logs ---
PKG_DIR="${C_PKGS:-$SCRIPT_DIR/../pkgs}"
LOG_FILE="$C_LOGS/pkg_verification.log"
mkdir -p "$C_LOGS"
> "$LOG_FILE"

echo "🔍 Verifying package files in: $PKG_DIR"
echo "📝 Results logged to: $LOG_FILE"
echo

# --- Check functions ---
check_pkg_pacman() { pacman -Si "$1" &>/dev/null; }
check_pkg_yay()    { yay -Si "$1" &>/dev/null; }

# --- Iterate over all package lists ---
for file in "$PKG_DIR"/*.txt; do
  echo "📦 Checking: $(basename "$file")"

  case "$file" in
    *arch_pacman.txt) checker="check_pkg_pacman" ;;
    *arch_aur.txt)    checker="check_pkg_yay"    ;;
    *) echo "⚠️  Skipping unsupported file: $file"; continue ;;
  esac

  while IFS= read -r line || [[ -n "$line" ]]; do
    pkg="$(echo "$line" | sed 's/#.*//' | xargs)"
    [[ -z "$pkg" ]] && continue

    if ! $checker "$pkg"; then
      echo "❌ Not found: $pkg" | tee -a "$LOG_FILE"
    else
      echo "✅ $pkg"
    fi
  done < "$file"

  echo
done

echo "🧾 Package check complete. Errors saved in: $LOG_FILE"
