#!/usr/bin/env bash
set -euo pipefail

tmux_tpm::installed() {
    [[ -d "$HOME/.tmux/plugins/tpm" ]]
}

tmux_tpm::install() {
    if ! tmux_tpm::installed; then
        echo "[+] Installing TPM (Tmux Plugin Manager)..."
        git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
    fi
}
