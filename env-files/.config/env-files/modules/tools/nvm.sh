#!/usr/bin/env bash
set -euo pipefail

source "$C_CORE/installer.sh"

nvm::installed() {
    [[ -s "$NVM_DIR/nvm.sh" ]]
}

nvm::install() {
    if nvm::installed; then
        echo "[✓] NVM already installed"
        return
    fi

    echo "[+] Installing NVM..."
    installer::script_from_url "NVM" "https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh" bash
}
