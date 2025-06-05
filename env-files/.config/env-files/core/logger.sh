#!/usr/bin/env bash
set -euo pipefail

# Assure qu'un fichier de log est défini
: "${LOG_FILE:=/tmp/env-init.log}"

log::info() {
    echo -e "🟦 [INFO] $*" | tee -a "$LOG_FILE"
}

log::success() {
    echo -e "🟩 [OK]   $*" | tee -a "$LOG_FILE"
}

log::warn() {
    echo -e "🟨 [WARN] $*" | tee -a "$LOG_FILE"
}

log::error() {
    echo -e "🟥 [ERROR] $*" | tee -a "$LOG_FILE" >&2
}

log::debug() {
    if [[ "${DEBUG:-}" == 1 ]]; then
        echo -e "⬛ [DEBUG] $*" | tee -a "$LOG_FILE"
    fi
}

log::section() {
    echo -e "\n🔷 $*" | tee -a "$LOG_FILE"
}
