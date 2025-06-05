#!/bin/bash

wezterm::installed() {
    command -v wezterm &> /dev/null
}

wezterm::install() {
    if wezterm::installed; then
        return
    fi

    echo "[+] Installing WezTerm..."
    case "$OS" in
        ubuntu|debian)
            curl -fsSL https://apt.fury.io/wez/gpg.key \
                | sudo gpg --yes --dearmor -o /etc/apt/keyrings/wezterm-fury.gpg
            echo 'deb [signed-by=/etc/apt/keyrings/wezterm-fury.gpg] https://apt.fury.io/wez/ * *' \
                | sudo tee /etc/apt/sources.list.d/wezterm.list
            sudo apt update && sudo apt install -y wezterm
            ;;
        arch)
            if command -v yay &>/dev/null; then
                yay -S --noconfirm wezterm
            else
                sudo pacman -S --noconfirm wezterm
            fi
            ;;
        *)
            echo "Unsupported OS for WezTerm installation: $OS"
            return 1
            ;;
    esac
