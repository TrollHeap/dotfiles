#!/bin/zsh

set -euo pipefail

BREW_LIST="$C_PKGS/macos_brew.txt"

source "$C_FUNCTIONS/install_pkgs.sh"

# Install Homebrew
echo "Installing Homebrew..."
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install packages from the list
install_packages "$BREW_LIST" brew

ya pack -a yazi-rs/flavors:catppuccin-mocha
ya pack -a bennyyip/gruvbox-dark
