#!/bin/bash

install_packages() {
    if [[ "$OSTYPE" == "darwin"* ]]; then
        printf "Loading macOS-specific configurations...\n"
        source "$CONFIG_PATH/scripts/os_specific/macos_setup.sh"
    else
        printf "Loading Ubuntu-specific configurations...\n"
        source "$CONFIG_PATH/scripts/os_specific/ubuntu_setup.sh"
    fi
}

install_nvm() {
    printf "Installing NVM...\n"
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
}

install_starship() {
    if ! command -v starship &> /dev/null; then
        printf "Installing Starship...\n"
        curl -sS https://starship.rs/install.sh | sh
    else
        printf "Starship is already installed.\n"
    fi
}

install_tmux_plugin_manager() {
    if [[ ! -d "$HOME/.tmux/plugins/tpm" ]]; then
        printf "Cloning Tmux Plugin Manager...\n"
        git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
    fi
}

setup_zsh() {
    source "$CONFIG_PATH/scripts/os_specific/zsh_setup.sh"
}

install_packages
install_nvm
install_starship
install_tmux_plugin_manager
setup_zsh
