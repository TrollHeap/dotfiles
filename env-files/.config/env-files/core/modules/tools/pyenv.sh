#!/usr/bin/env bash

source "$ROOT_ENV/core/lib/installer.sh"

pyenv::installed() {
    [[ -x "$HOME/.pyenv/bin/pyenv" ]]
}

pyenv::install() {
    if pyenv::installed; then
        echo "[✓] pyenv already installed"
        return
    fi

    if [[ -d "$HOME/.pyenv" ]]; then
        echo "⚠️  Removing stale ~/.pyenv directory"
        rm -rf "$HOME/.pyenv"
    fi

    echo "[+] Installing pyenv..."
    installer::script_from_url "pyenv" "https://pyenv.run" bash
}
