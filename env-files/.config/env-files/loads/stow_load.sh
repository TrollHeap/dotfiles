cd dotfiles && stow env-files && stow zsh
cd "$HOME" && source ~/.zshrc
cd dotfiles && stow binaryvim && stow tmux && stow wezterm && stow starship
cd "$HOME"
