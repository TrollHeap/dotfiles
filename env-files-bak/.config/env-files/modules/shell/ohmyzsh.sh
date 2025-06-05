#!/usr/bin/env bash
set -euo pipefail

source "$C_CORE/installer.sh"

ohmyzsh::installed() {
    [[ -d "$HOME/.oh-my-zsh" ]]
}

ohmyzsh::install() {
    if ohmyzsh::installed; then
        echo "[✓] Oh My Zsh already installed"
        return
    fi

    echo "[+] Installing Oh My Zsh…"
    installer::script_from_url "Oh My Zsh" "https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh" sh
}

ohmyzsh::install_plugins() {
    local zsh_custom="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"

    echo "[+] Installing Zsh plugins…"

    [[ ! -d "$zsh_custom/plugins/zsh-autosuggestions" ]] && \
        git clone https://github.com/zsh-users/zsh-autosuggestions "$zsh_custom/plugins/zsh-autosuggestions"

    [[ ! -d "$zsh_custom/plugins/zsh-syntax-highlighting" ]] && \
        git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$zsh_custom/plugins/zsh-syntax-highlighting"

    [[ ! -d "$zsh_custom/plugins/fzf-zsh-plugin" ]] && \
        git clone --depth 1 https://github.com/unixorn/fzf-zsh-plugin.git "$zsh_custom/plugins/fzf-zsh-plugin"
}

ohmyzsh::reset_zshrc() {
    echo "[+] Resetting .zshrc from stow"
    rm -f "$HOME/.zshrc"
    cd "$DOTFILES" && stow zsh && cd - > /dev/null
}
