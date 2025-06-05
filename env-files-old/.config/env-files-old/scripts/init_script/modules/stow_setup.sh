# Description: Setup stow for dotfiles management

# ----- Functions -----
install_stow() {
    if ! command -v stow &> /dev/null; then
        echo "Installing Stow...\n"
        sudo apt install -y stow
    else
        echo "Stow is already installed.\n"
    fi
}

# ----- Setup stow -----
install_stow

# ----- Setup dotfiles -----
cd dotfiles && stow wezterm && stow tmux && stow nvim && cd

