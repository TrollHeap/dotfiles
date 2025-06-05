#!/usr/bin/env bash
set -euo pipefail

# Source dépendances
source "$C_CORE/installer.sh"

fzf::installed() {
    command -v fzf &> /dev/null
}

fzf::install() {
    if fzf::installed; then
        echo "[✓] fzf already installed"
        return
    fi

    echo "[+] Installing fzf…"
    installer::pkg_from "$PKG_MANAGER" "fzf"
}
