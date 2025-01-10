#!/bin/bash

# ----- Make zsh default shell -----
sudo apt install -y zsh
echo "Configuring Zsh..."
if ! command -v zsh &> /dev/null; then
  sudo apt install -y zsh
fi

if [ "$SHELL" != "$(which zsh)" ]; then
  chsh -s "$(which zsh)"
fi

if [ ! -d "$HOME/.oh-my-zsh" ]; then
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

if ! grep -q "source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ${ZDOTDIR:-$HOME}/.zshrc; then
  echo "source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> ${ZDOTDIR:-$HOME}/.zshrc
fi

if [ ! -d "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/fzf-zsh-plugin" ]; then
  git clone --depth 1 https://github.com/unixorn/fzf-zsh-plugin.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/fzf-zsh-plugin
fi


# Clone the tmux plugin manager
if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
  echo "Cloning Tmux Plugin Manager..."
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

# ----- Install wezterm -----
echo "Installing WezTerm..."
if ! command -v wezterm &> /dev/null; then
  curl -fsSL https://apt.fury.io/wez/gpg.key | sudo gpg --yes --dearmor -o /etc/apt/keyrings/wezterm-fury.gpg
  echo 'deb [signed-by=/etc/apt/keyrings/wezterm-fury.gpg] https://apt.fury.io/wez/ * *' | sudo tee /etc/apt/sources.list.d/wezterm.list
else
  echo "WezTerm is already installed."
fi

# Update the system
echo "Updating the system..."
sudo apt update && sudo apt upgrade -y

sudo apt install -y wezterm
# Install essential packages
echo "Installing essential packages..."
sudo apt install -y tmux neofetch neovim fzf ripgrep tree 
