#!/bin/bash

PACKAGE_LIST="$HOME/.config/env-files/env/linux/package_list.txt"
source "$HOME/.config/env-files/functions/install_packages.sh"

# ----- Install zsh -----
install_zsh() {
  echo "Installing Zsh..."
  if ! command -v zsh &> /dev/null; then
    sudo apt install -y zsh
  fi
}

# ----- Make zsh default shell -----
make_zsh_default() {
  echo "Configuring Zsh..."
  if [ "$SHELL" != "$(which zsh)" ]; then
    chsh -s "$(which zsh)"
  fi
}
# ----- Install wezterm -----
git_clone_wezterm(){
  echo "Installing WezTerm..."
  if ! command -v wezterm &> /dev/null; then
    curl -fsSL https://apt.fury.io/wez/gpg.key 
    echo 'deb [signed-by=/etc/apt/keyrings/wezterm-fury.gpg] https://apt.fury.io/wez/ * *'
  else
    echo "WezTerm is already installed."
  fi
}

install_zsh
make_zsh_default
git_clone_wezterm

# ----- Update the system -----
echo "Updating the system..."
sudo apt update && sudo apt upgrade -y

sudo apt install -y wezterm

# Install essential packages
install_packages "$PACKAGE_LIST" apt
