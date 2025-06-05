#!/usr/bin/env bash
set -euo pipefail

nvm::installed() {
    [[ -s "$NVM_DIR/nvm.sh" ]]
}

nvm::install() {
    echo "[+] Installing NVM..."
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
}

nvm::init() {
    if nvm::installed; then
        source "$NVM_DIR/nvm.sh" 2>>"$LOG_FILE/init_errors.log"
        command -v nvm >/dev/null || echo "❌ NVM not available" >> "$LOG_FILE/init_errors.log"
    else
        echo "⚠️  NVM init skipped — not installed" >> "$LOG_FILE/init_errors.log"
    fi
}
