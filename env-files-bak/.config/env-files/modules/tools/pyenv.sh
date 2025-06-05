#!/usr/bin/env bash
set -euo pipefail

source "$C_CORE/installer.sh"

pyenv::installed() {
    command -v pyenv &>/dev/null
}

pyenv::install() {
    if pyenv::installed; then
        echo "[✓] pyenv already installed"
        return
    fi

    echo "[+] Installing pyenv..."
    installer::script_from_url "pyenv" "https://pyenv.run" bash
}
