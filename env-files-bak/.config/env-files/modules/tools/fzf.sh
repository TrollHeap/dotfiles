#!/usr/bin/env bash
set -euo pipefail

# Source dépendances
source "$C_CORE/installer.sh"

fzf::installed() {
    command -v fzf &> /dev/null
}

fzf::install() {
    if fzf::installed; then
        echo "[✓] fzf already installed"
        return
    fi

    echo "[+] Installing fzf…"
    installer::pkg_from "$PKG_MANAGER" "fzf"
}

fzf::setup_bindings() {
    local FZF_SHELL_DIR="$FZF_DIR/shell"

    [[ -f "$FZF_SHELL_DIR/completion.zsh" ]] && source "$FZF_SHELL_DIR/completion.zsh" 2>>"$LOG_FILE/init_errors.log"
    [[ -f "$FZF_SHELL_DIR/key-bindings.zsh" ]] && source "$FZF_SHELL_DIR/key-bindings.zsh" 2>>"$LOG_FILE/init_errors.log"
}
