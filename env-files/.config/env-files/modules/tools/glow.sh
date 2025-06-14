#!/usr/bin/env bash

# ╭──────────────────────────────────────────────────────────────╮
# │ GLOW INSTALLER – Debian/Ubuntu & Fedora/RHEL                │
# ╰──────────────────────────────────────────────────────────────╯

source "$C_CORE/init/installer.sh"

glow::installed() {
    command -v glow &>/dev/null
}

glow::install() {
    if glow::installed; then
        echo "Glow already installed"
        return 0
    fi

    echo "[+] Installing Glow…"

    case "$OS" in
        ubuntu|debian)
            sudo mkdir -p /etc/apt/keyrings
            curl -fsSL https://repo.charm.sh/apt/gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/charm.gpg
            echo "deb [signed-by=/etc/apt/keyrings/charm.gpg] https://repo.charm.sh/apt/ * *" | sudo tee /etc/apt/sources.list.d/charm.list
            sudo apt update
            installer::pkg_from apt "glow"
            ;;
        fedora|rhel|rocky|alma|nobara)
            echo '[charm]
                    name=Charm
                    baseurl=https://repo.charm.sh/yum/
                    enabled=1
                    gpgcheck=1
                    gpgkey=https://repo.charm.sh/yum/gpg.key' | sudo tee /etc/yum.repos.d/charm.repo
            sudo dnf install -y glow
            ;;
        *)
            log::error "❌ Unsupported OS for glow"
            return 1
            ;;
    esac
}
