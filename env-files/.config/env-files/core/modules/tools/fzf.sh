#!/usr/bin/env bash

source "$ROOT_ENV/core/lib/installer.sh"

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
