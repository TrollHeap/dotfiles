#!/usr/bin/env bash

# ╭──────────────────────────────────────────────────────────────╮
# │ VERIFY_PKGS - Check existence of packages in repo / AUR      │
# ╰──────────────────────────────────────────────────────────────╯

# --- Constants & logger setup ---
export DOTFILES="${DOTFILES:-$HOME/dotfiles}"
ROOT_ENVFILES="$DOTFILES/env-files/.config/env-files"

source "$ROOT_ENVFILES/config/env/globals_locals.env"
source "$ROOT_ENVFILES/config/env/logs.env"
source "$C_CORE/lib/logger.sh"
log::use ENV_PKGS
log::section "Verifying package lists"

# --- Paths ---
PKG_DIR="${C_PKGS:-$DOTFILES/env-files/.config/env-files/pkgs}"
echo "🔍 Verifying package files in: $PKG_DIR"
echo

# --- Check commands ---
check_pkg_pacman() { pacman -Si "$1" &>/dev/null; }
check_pkg_yay()    { yay -Si "$1" &>/dev/null; }

# --- Process all files ---
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
            log::error "Not found: $pkg"
        else
            echo "✅ $pkg"
        fi
    done < "$file"

    echo
done

log::success "Package check complete"
echo "🧾 Errors saved to: $LOG_FILE"
