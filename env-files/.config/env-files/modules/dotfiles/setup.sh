#!/usr/bin/env bash

# Setup script to deploy dotfiles using GNU Stow

# Change to the directory of this script to ensure relative paths work
cd "$(dirname "$0")/.."

echo "[+] Removing existing ~/.zshrc"
rm -f "$HOME/.zshrc"

if ! command -v stow >/dev/null; then
  echo "❌ stow is not installed. Please install GNU stow first." >&2
  exit 1
fi

echo "[+] Stowing modules..."
cd "$HOME/dotfiles"
stow bash starship tmux nvim yazi

cd - >/dev/null

[[ -f "$HOME/.zshrc" ]] && source "$HOME/.zshrc" || echo "⚠️ Cannot source outside login shell"
