#!/usr/bin/env bash
set -euo pipefail

# ╭──────────────────────────────────────────────────────────────╮
# │ INSTALLER - Universal package & script installer             │
# ╰──────────────────────────────────────────────────────────────╯

# --- 0. Detect package manager if unset
: "${PKG_MANAGER:=""}"
[[ -z "$PKG_MANAGER" ]] && {
  case "$OSTYPE" in
    linux*)
      if [[ -f /etc/os-release ]]; then
        . /etc/os-release
        case "$ID" in
          arch|manjaro|endeavouros|cachyos) PKG_MANAGER="pacman" ;;
          ubuntu|debian)                   PKG_MANAGER="apt" ;;
          *) echo "❌ Unsupported distro: $ID" && exit 1 ;;
        esac
      fi
      ;;
    darwin*) PKG_MANAGER="brew" ;;
    *) echo "❌ Unsupported OS: $OSTYPE" && exit 1 ;;
  esac
}

# --- 1. Install a single package using the current PKG_MANAGER
installer::pkg() {
  local name="$1"

  case "$PKG_MANAGER" in
    apt)    sudo apt install -y "$name" ;;
    pacman) sudo pacman -S --noconfirm "$name" ;;
    yay)
      if ! yay -Si "$name" &>/dev/null; then
        echo "❌ AUR package not found: $name" >&2
        return 1
      fi
      yay -S --noconfirm "$name"
      ;;
    brew)   brew install "$name" ;;
    *)      echo "❌ Unknown PKG_MANAGER: $PKG_MANAGER" && return 1 ;;
  esac
}

# --- 2. Install a package with explicit manager override
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

# --- 3. Install packages from a file (1 per line)
installer::from_file() {
  local file="$1"
  local manager="$2"

  [[ ! -f "$file" ]] && {
    echo "❌ Package list not found: $file"
    return 1
  }

  while IFS= read -r line || [[ -n "$line" ]]; do
    [[ -z "$line" || "$line" =~ ^# ]] && continue

    # Special case for macOS Homebrew casks
    if [[ "$line" =~ ^--[[:space:]]*cask[[:space:]]+(.+)$ ]]; then
      brew install --cask "${BASH_REMATCH[1]}"
      continue
    fi

    installer::pkg_from "$manager" "$line"
  done < "$file"
}

# --- 4. Install yay AUR helper (if missing)
installer::aur_helper() {
  if ! command -v yay &>/dev/null; then
    echo "⚠️  yay not found — installing from AUR..."
    sudo pacman -S --needed --noconfirm base-devel git
    git clone https://aur.archlinux.org/yay.git /tmp/yay
    (cd /tmp/yay && makepkg -si --noconfirm)
  fi
}

# --- 5. Install from remote script (e.g. pyenv.run)
installer::script_from_url() {
  local name="$1"
  local url="$2"
  local shell="${3:-sh}"  # Default: POSIX-compatible shell

  echo "[+] Installing $name from script ($shell)..."
  if ! curl -fsSL "$url" | "$shell"; then
    echo "❌ Failed installing $name"
    return 1
  fi
}
