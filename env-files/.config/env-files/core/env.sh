#!/usr/bin/env bash

# ╭──────────────────────────────────────────────────────────────╮
# │ ENV LOADER - Environment Detection & Path Bootstrapping      │
# ╰──────────────────────────────────────────────────────────────╯

# --- 0. Shell mode: strict for scripts, tolerant for interactive
if [[ $- != *i* ]]; then
  set -euo pipefail
else
  set -o pipefail
fi

# --- 1. Validate critical variables
[[ -z "${DOTFILES:-}" ]] && DOTFILES="$HOME/dotfiles"

# --- 2. Load static configuration
source "$HOME/dotfiles/env-files/.config/env-files/config/variables.env"

# --- 3. Determine script directory (compatible with bash & zsh)
if [ -n "${BASH_SOURCE:-}" ]; then
  SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
elif [ -n "${ZSH_VERSION:-}" ]; then
  SCRIPT_DIR="$(cd "$(dirname "${(%):-%x}")" && pwd)"
else
  echo "⚠️ Unsupported shell: fallback to current directory" >&2
  SCRIPT_DIR="$(pwd)"
fi

# --- 4. Load export declarations (if present)
[[ -f "$SCRIPT_DIR/exports.sh" ]] && source "$SCRIPT_DIR/exports.sh"

# --- 5. Detect operating system
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

# --- 6. Prevent duplicate loading
[[ -n "${C_ENV_LOADED:-}" ]] && return
export C_ENV_LOADED=1

# --- 7. Load global path declarations
if [[ -f "$C_PATHS/global.env" ]]; then
  source "$C_PATHS/global.env"
else
  echo "❌ Missing: $C_PATHS/global.env"
  exit 1
fi

# --- 8. Load OS-specific path overrides
case "$OS" in
  macos)  [[ -f "$C_PATHS/macos-paths.env" ]]  && source "$C_PATHS/macos-paths.env" ;;
  arch)   [[ -f "$C_PATHS/arch-paths.env" ]]   && source "$C_PATHS/arch-paths.env" ;;
  ubuntu) [[ -f "$C_PATHS/ubuntu-paths.env" ]] && source "$C_PATHS/ubuntu-paths.env" ;;
  *)      echo "⚠️ No OS-specific paths for $OS" ;;
esac

# --- 9. Load optional build flags
[[ -f "$C_CONFIG/buildflag/${OS}_buildflags.env" ]] && source "$C_CONFIG/buildflag/${OS}_buildflags.env"
