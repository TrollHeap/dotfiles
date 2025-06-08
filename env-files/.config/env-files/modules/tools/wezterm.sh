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
            | sudo gpg --dearmor -o /etc/apt/keyrings/wezterm-fury.gpg
          echo "deb [signed-by=/etc/apt/keyrings/wezterm-fury.gpg] https://apt.fury.io/wez/ * *" \
            | sudo tee /etc/apt/sources.list.d/wezterm.list
          sudo apt update
          installer::pkg_from apt "wezterm"
          ;;
        fedora|nobara)
          local rpm_url="https://github.com/wez/wezterm/releases/download/20240203-110809-5046fc22/wezterm-20240203_110809_5046fc22-1.fedora39.x86_64.rpm"
          echo "[+] Downloading and installing RPM from upstream..."
          sudo dnf install -y "$rpm_url" || {
            log::error "❌ Failed to install wezterm via RPM"
            return 1
          }
          ;;
        macos)
          installer::pkg_from brew "wezterm"
          ;;
        *)
          log::error "❌ Unsupported OS for wezterm"
          return 1
          ;;
      esac
}
