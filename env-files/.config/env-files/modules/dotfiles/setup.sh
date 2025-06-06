#!/usr/bin/env zsh
cd ..

echo "[+] Removing .zshrc"
rm -f ~/.zshrc

echo "[+] Stowing modules..."
cd ~/dotfiles
stow zsh starship tmux wezterm nvim yazi
cd ..

echo "[+] Sourcing .zshrc"
source ~/.zshrc || echo "⚠️ Cannot source outside login shell"
