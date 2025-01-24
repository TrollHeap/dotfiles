#!/bin/bash

# ---- Install Zsh ----
install_zsh() {
    if ! command -v zsh &> /dev/null; then
        echo "Installing Zsh...\n"
        sudo apt install -y zsh
    fi
}

set_zsh_default_shell() {
    echo "Configuring Zsh as default shell...\n"
    if [ "$SHELL" != "$(which zsh)" ]; then
        chsh -s "$(which zsh)"
    fi
}

install_oh_my_zsh() {
    if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
        echo "Installing Oh My Zsh...\n"
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    fi
}

install_zsh_plugins() {
    local zsh_custom="${ZSH_CUSTOM:-$HOME/.oh-my-zsh}"
    
    echo "Installing Zsh plugins...\n"
    
    if [[ ! -d "$zsh_custom/plugins/zsh-autosuggestions" ]]; then
        git clone https://github.com/zsh-users/zsh-autosuggestions "$zsh_custom/plugins/zsh-autosuggestions"
    fi

    if [[ ! -d "$zsh_custom/plugins/zsh-syntax-highlighting" ]]; then
        git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$zsh_custom/plugins/zsh-syntax-highlighting"
    fi

    if [[ ! -d "$zsh_custom/plugins/fzf-zsh-plugin" ]]; then
        git clone --depth 1 https://github.com/unixorn/fzf-zsh-plugin.git "$zsh_custom/plugins/fzf-zsh-plugin"
    fi

    rm -f "$HOME/.zshrc" && cd dotfiles && stow zsh && cd ..
}

# ---- Install Nerd Fonts ----
install_nerd_fonts() {
    $FONTS="$HOME/.local/share/fonts"
    $GITHUB_URL="https://github.com/ryanoasis/nerd-fonts/releases/download"

    # Check if the fonts directory exists and create it if it doesn't
    if [[ ! -d "$FONTS" ]]; then
        mkdir -p "$FONTS"
    fi

    # Download the Nerd Fonts
    echo "Installing Nerd Fonts...\n"
    wget -P $FONTS $GITHUB_URL/v3.0.2/JetBrainsMono.zip \
    && wget -P $FONTS $GITHUB_URL/v3.3.0/NerdFontsSymbolsOnly.zip \
    && wget -P $FONTS $GITHUB_URL/v3.3.0/GeistMono.zip \
    && cd $FONTS

    # Unzip the fonts
    for font in JetBrainsMono.zip NerdFontsSymbolsOnly.zip GeistMono.zip; do
        unzip $font
        rm $font
    done

    # Update the font cache
    fc-cache -fv
}

install_wezterm() {
    if ! command -v wezterm &> /dev/null; then
        echo "Installing WezTerm...\n"
        curl -fsSL https://apt.fury.io/wez/gpg.key | sudo gpg --yes --dearmor -o /etc/apt/keyrings/wezterm-fury.gpg
        echo 'deb [signed-by=/etc/apt/keyrings/wezterm-fury.gpg] https://apt.fury.io/wez/ * *' | sudo tee /etc/apt/sources.list.d/wezterm.list
        sudo apt update
        sudo apt install -y wezterm


    else
        echo "WezTerm is already installed.\n"
    fi
}


install_zsh
install_nerd_fonts
set_zsh_default_shell
install_oh_my_zsh
install_zsh_plugins
install_wezterm
