#!/usr/bin/env bash

source "$ROOT_ENV/core/lib/installer.sh"

starship::installed() {
    command -v starship &> /dev/null
}

starship::install() {
    if starship::installed; then
        echo "[✓] Starship already installed"
        return
    fi

    echo "[+] Installing Starship..."
    installer::script_from_url "starship" "https://starship.rs/install.sh" sh
}
