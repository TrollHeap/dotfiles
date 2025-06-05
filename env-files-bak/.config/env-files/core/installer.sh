#!/usr/bin/env bash
set -euo pipefail

# ⇨ Détecte automatiquement le gestionnaire de paquets par défaut
: "${PKG_MANAGER:=""}"
[[ -z "$PKG_MANAGER" ]] && {
    case "$OSTYPE" in
        linux*) 
            if [[ -f /etc/os-release ]]; then
                . /etc/os-release
                case "$ID" in
                    arch|manjaro|endeavouros|cachyos) PKG_MANAGER="pacman" ;;
                    ubuntu|debian) PKG_MANAGER="apt" ;;
                    *) echo "❌ Unsupported distro: $ID"; exit 1 ;;
                esac
            fi
            ;;
        darwin*) PKG_MANAGER="brew" ;;
        *) echo "❌ Unsupported OS: $OSTYPE"; exit 1 ;;
    esac
}

installer::pkg() {
    local name="$1"
    case "$PKG_MANAGER" in
        apt)    sudo apt install -y "$name" ;;
        pacman) sudo pacman -S --noconfirm "$name" ;;
        yay)    yay -S --noconfirm "$name" ;;
        brew)   brew install "$name" ;;
        *)      echo "❌ Unknown PKG_MANAGER: $PKG_MANAGER" && return 1 ;;
    esac
}

installer::pkg_from() {
    local manager="$1"
    local name="$2"

    case "$manager" in
        apt|pacman|brew) 
            PKG_MANAGER="$manager"
            installer::pkg "$name"
            ;;
        yay)
            installer::aur_helper
            PKG_MANAGER="yay"
            installer::pkg "$name"
            ;;
        *)
            echo "❌ Unsupported manager: $manager"
            return 1
            ;;
    esac
}

installer::from_file() {
    local file="$1"
    local manager="$2"

    [[ ! -f "$file" ]] && {
        echo "❌ Package list not found: $file"
        return 1
    }

    while IFS= read -r line || [[ -n "$line" ]]; do
        [[ -z "$line" || "$line" =~ ^# ]] && continue

        # Spécial Mac : ligne spéciale -- cask
        if [[ "$line" =~ ^--[[:space:]]*cask[[:space:]]+(.+)$ ]]; then
            brew install --cask "${BASH_REMATCH[1]}"
            continue
        fi

        installer::pkg_from "$manager" "$line"
    done < "$file"
}

installer::aur_helper() {
    if ! command -v yay &>/dev/null; then
        echo "⚠️  yay not found — installing from AUR..."
        sudo pacman -S --needed --noconfirm base-devel git
        git clone https://aur.archlinux.org/yay.git /tmp/yay
        (cd /tmp/yay && makepkg -si --noconfirm)
    fi
}

installer::script_from_url() {
    local name="$1"
    local url="$2"
    echo "[+] Installing $name from script..."
    curl -fsSL "$url" | bash || {
        echo "❌ Failed installing $name"
        return 1
    }
}
