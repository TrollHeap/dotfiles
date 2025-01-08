#!/bin/bash

# Load general configurations if available
source ./loads.sh

# Clone the tmux plugin manager
if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
  echo "Cloning Tmux Plugin Manager..."
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

# clone tmuxifier
if [ ! -d "$HOME/.tmuxifier/" ]; then
  git clone https://github.com/jimeh/tmuxifier.git ~/.tmuxifier
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
