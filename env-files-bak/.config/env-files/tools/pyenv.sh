#!/usr/bin/env bash
set -euo pipefail

pyenv::init() {
    if command -v pyenv >/dev/null; then
        eval "$(pyenv init --path)" 2>>"$LOG_FILE/init_errors.log"
        eval "$(pyenv virtualenv-init -)" 2>>"$LOG_FILE/init_errors.log"
    else
        echo "⚠️ Pyenv not installed." >> "$LOG_FILE/init_errors.log"
    fi
}
