#!/usr/bin/env bash

source "$ROOT_ENV/core/lib/installer.sh"

tmux_tpm::installed() {
    [[ -d "$HOME/.tmux/plugins/tpm" ]]
}

tmux_tpm::install() {
    if tmux_tpm::installed; then
        echo "[✓] TPM already installed"
        return
    fi

    echo "[+] Installing TPM (Tmux Plugin Manager)…"
    git clone https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"
}
