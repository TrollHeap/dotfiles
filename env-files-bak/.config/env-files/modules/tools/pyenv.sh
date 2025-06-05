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

pyenv::init() {
    if pyenv::installed; then
        eval "$(pyenv init --path)" 2>>"$LOG_FILE/init_errors.log"
        eval "$(pyenv virtualenv-init -)" 2>>"$LOG_FILE/init_errors.log"
    else
        echo "⚠️ pyenv not installed." >> "$LOG_FILE/init_errors.log"
    fi
}
