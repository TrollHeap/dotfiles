#!/bin/bash

install_packages() {
    # Load OS-specific configurations
    if [[ "$OSTYPE" == "darwin"* ]]; then
        echo "Loading macOS-specific configurations..."
        source "$CONFIG_PATH/scripts/os_specific/macos_setup.sh"
    else
        echo "Loading Ubuntu-specific configurations..."
        source "$CONFIG_PATH/scripts/os_specific/ubuntu_setup.sh"
    fi
}

# ---- Install NVM -----
install_nvm() {
    echo "Installing NVM..."
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
}
# ---- Install starship  -----
install_starship() {
    if ! command -v starship &> /dev/null; then
        echo "Installing Starship..."
        curl -sS https://starship.rs/install.sh | sh
    else
        echo "Starship is already installed."
    fi
}

# ---- Install Oh My Zsh -----
install_oh_my_zsh() {
    if [ ! -d "$HOME/.oh-my-zsh" ]; then
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
        git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
        git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
    fi
}


# ---- Install Zsh Autosuggestions -----
install_fzf_zsh() {
  if [ ! -d "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/fzf-zsh-plugin" ]; then
    git clone --depth 1 https://github.com/unixorn/fzf-zsh-plugin.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/fzf-zsh-plugin
  fi
}

# ---- Install Tmux Plugin Manager -----
install_tmux_plugin_manager() {
  if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
    echo "Cloning Tmux Plugin Manager..."
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
  fi
}

install_packages
install_nvm
install_starship
install_oh_my_zsh
#install_fzf_zsh
install_tmux_plugin_manager
