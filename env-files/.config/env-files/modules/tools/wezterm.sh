#!/usr/bin/env bash

source "$C_CORE/init/installer.sh"

wezterm::installed() {
    command -v wezterm &>/dev/null
}

wezterm::install() {
    if wezterm::installed; then
        echo "WezTerm already installed"
        return
    fi

    echo "[+] Installing WezTerm…"

    case "$OS" in
        arch)
            installer::pkg_from yay "wezterm-bin"
            ;;
        ubuntu|debian)
            curl -fsSL https://apt.fury.io/wez/gpg.key \
              | sudo gpg --yes --dearmor -o /etc/apt/keyrings/wezterm-fury.gpg
            echo "deb [signed-by=/etc/apt/keyrings/wezterm-fury.gpg] https://apt.fury.io/wez/ * *" \
              | sudo tee /etc/apt/sources.list.d/wezterm.list
            sudo apt update
            installer::pkg_from apt "wezterm"
            ;;
        macos)
            installer::pkg_from brew "wezterm" 
            ;;
        *)
            echo "❌ Unsupported OS for wezterm"
            return 1
            ;;
    esac
}
