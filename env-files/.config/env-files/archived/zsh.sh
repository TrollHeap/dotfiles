#!/usr/bin/env bash

# ╭────────────────────────────────────────────────────────────╮
# │ SHELL MODULE: Zsh installation & default shell setup       │
# ╰────────────────────────────────────────────────────────────╯

source "$C_CORE/init/installer.sh"

zsh::installed() {
    command -v zsh &> /dev/null
}

zsh::install() {
    if zsh::installed; then
        echo "[✓] Zsh already installed"
        return
    fi

    echo "[+] Installing Zsh..."
    installer::pkg_from "$PKG_MANAGER" "zsh"
}

zsh::set_default_shell() {
    local current_shell
    current_shell="$(getent passwd "$USER" | cut -d: -f7)"
    local zsh_path
    zsh_path="$(command -v zsh)"

    if [[ "$current_shell" != "$zsh_path" ]]; then
        echo "[*] Changing default shell to: $zsh_path"
        chsh -s "$zsh_path"
    fi
}
