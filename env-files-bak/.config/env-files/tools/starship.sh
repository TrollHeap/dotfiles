#!/bin/bash

starship::installed() {
    command -v starship &> /dev/null
}

starship::install() {
    if ! starship::installed; then
        echo "[+] Installing Starship..."
        curl -sS https://starship.rs/install.sh | sh
    fi
}
