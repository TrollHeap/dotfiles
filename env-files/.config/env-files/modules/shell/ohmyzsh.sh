#!/usr/bin/env bash
set -euo pipefail

# ╭────────────────────────────────────────────────────────────╮
# │ SHELL MODULE: Oh My Zsh installation & plugin setup        │
# ╰────────────────────────────────────────────────────────────╯

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
    local zsh_custom="$HOME/.oh-my-zsh/custom"
    echo "[+] Installing Oh My Zsh plugins…"

    local plugins=(
        "zsh-autosuggestions::https://github.com/zsh-users/zsh-autosuggestions"
        "zsh-syntax-highlighting::https://github.com/zsh-users/zsh-syntax-highlighting"
        "fzf-zsh-plugin::https://github.com/unixorn/fzf-zsh-plugin.git"
    )

    for entry in "${plugins[@]}"; do
        local name="${entry%%::*}"
        local url="${entry##*::}"
        local path="$zsh_custom/plugins/$name"

        if [[ -d "$path" ]]; then
            echo "[✓] $name already installed"
            continue
        fi

        echo "[+] Cloning $name..."
        if ! git clone --depth 1 "$url" "$path"; then
            echo "❌ Failed to install $name"
            continue  # Don't abort on failure — skip to next
        fi
    done
}

ohmyzsh::reset_zshrc() {
    echo "[+] Resetting .zshrc via stow"
    rm -f "$HOME/.zshrc"
    cd "$DOTFILES" && stow zsh && cd - > /dev/null
}
