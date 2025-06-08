#!/usr/bin/env bash

# ╭──────────────────────────────────────────────────────────────╮
# │ INSTALLER - Universal package & script installer             │
# ╰──────────────────────────────────────────────────────────────╯

# --- Init logging ---
source "$HOME/dotfiles/env-files/.config/env-files/config/env/globals_locals.env"
source "$HOME/dotfiles/env-files/.config/env-files/config/env/logs.env"
source "$C_CORE/lib/logger.sh"
log::use ENV_INSTALLER

# --- Detect package manager if unset ---
: "${PKG_MANAGER:=""}"
if [[ -z "$PKG_MANAGER" ]]; then
  case "$OSTYPE" in
    linux*)
      [[ -f /etc/os-release ]] && . /etc/os-release
      case "$ID" in
        arch|manjaro|endeavouros|cachyos) PKG_MANAGER="pacman" ;;
        ubuntu|debian)                   PKG_MANAGER="apt" ;;
        fedora|rhel|rocky|alma)         PKG_MANAGER="dnf" ;;
        *) log::error "Unsupported distro: $ID";;
      esac
      ;;
    darwin*) PKG_MANAGER="brew" ;;
    *) log::error "Unsupported OS: $OSTYPE" ;;
  esac
fi

# --- 1. Install one package ---
installer::pkg() {
  local name="$1"

  case "$PKG_MANAGER" in
apt)
  if ! sudo apt install -y "$name"; then
    log::error "apt: failed to install package: $name"
    return 1
  fi
  ;;
dnf)
  if ! sudo dnf install -y "$name"; then
    log::error "apt: failed to install package: $name"
    return 1
  fi
  ;;
pacman)
  if ! sudo pacman -S --noconfirm "$name"; then
    log::error "pacman: failed to install package: $name"
    return 1
  fi
  ;;
    yay)
      if ! yay -Si "$name" &>/dev/null; then
        log::error "AUR package not found: $name"
        return 1
      fi
      yay -S --noconfirm "$name" ;;
    brew)   brew install "$name" ;;
    *)
      log::error "Unknown package manager: $PKG_MANAGER"
      return 1 ;;
  esac
}

# --- 2. With manager override ---
installer::pkg_from() {
  local manager="$1" name="$2"
  case "$manager" in
    apt|dnf|pacman|brew)
      PKG_MANAGER="$manager"
      installer::pkg "$name" ;;
    yay)
      installer::aur_helper
      PKG_MANAGER="yay"
      installer::pkg "$name" ;;
    *)
      log::error "Unsupported manager: $manager"
      return 1 ;;
  esac
}

# --- 3. Install from file ---
installer::from_file() {
  local file="$1" manager="$2"
  if [[ ! -f "$file" ]]; then
    log::error "Package list not found: $file"
    return 1
  fi

  while IFS= read -r line || [[ -n "$line" ]]; do
    [[ -z "$line" || "$line" =~ ^# ]] && continue
    if [[ "$line" =~ ^--[[:space:]]*cask[[:space:]]+(.+)$ ]]; then
      brew install --cask "${BASH_REMATCH[1]}"
      continue
    fi
    installer::pkg_from "$manager" "$line"
  done < "$file"
}

# --- 4. Install yay if missing ---
installer::aur_helper() {
  if ! command -v yay &>/dev/null; then
    echo "⚠️  yay not found — installing from AUR..."
    sudo pacman -S --needed --noconfirm base-devel git
    if ! git clone https://aur.archlinux.org/yay.git /tmp/yay; then
      log::error "Failed to clone yay repo"
      return 1
    fi
    if ! (cd /tmp/yay && makepkg -si --noconfirm); then
      log::error "Failed to build/install yay"
      return 1
    fi
  fi
}

# --- 5. From remote script ---
installer::script_from_url() {
  local name="$1" url="$2" shell="${3:-sh}"

  echo "[+] Installing $name from $url using $shell"
  if ! curl -fsSL "$url" | "$shell"; then
    log::error "Failed installing $name from $url"
    return 1
  fi
}
