#!/usr/bin/env bash
# ╭──────────────────────────────────────────────────────────────╮
# │ ENV LOADER - Environment Detection & Path Bootstrapping      │
# ╰──────────────────────────────────────────────────────────────╯

# --- 0. Load global constants and logger ---
ROOT_ENVFILES="${DOTFILES:-$HOME/dotfiles}/env-files/.config/env-files"
source "$ROOT_ENVFILES/config/env/globals_public.env"
source "$ROOT_ENVFILES/config/env/globals_locals.env"
source "$ROOT_ENVFILES/config/env/logs.env"
source "$C_CORE/lib/logger.sh"

log::use ENV_LOADING
__env_start_time=$(date +%s)

# --- 1. Prevent duplicate loading ---
if [[ -n "${C_ENV_LOADED:-}" ]]; then
    log::info "env.sh already loaded, skipping."
    log::info "env.sh loading in PID $$ (TTY: $(tty))"
    return 0 2>/dev/null || true
fi
export C_ENV_LOADED=1

log::section "Starting environment initialization"
# --- 2. Shell mode ---
if [[ $- != *i* ]]; then
    set -euo pipefail
else
    set -o pipefail
    set +u
fi

: "${ZSH_CUSTOM:=}"
: "${LOG_ENV_LOADING:=/dev/null}"

# --- 4. Script directory ---
if [ -n "${BASH_SOURCE:-}" ]; then
    SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
elif [ -n "${ZSH_VERSION:-}" ]; then
    SCRIPT_DIR="$(cd "$(dirname "${(%):-%x}")" && pwd)"
else
    SCRIPT_DIR="$(pwd)"
    log::warn "Unsupported shell; fallback to $SCRIPT_DIR"
fi
log::info "SCRIPT_DIR = $SCRIPT_DIR"

# --- 5. Exports paths ---
log::try_source "$C_CORE/lib/exports_paths.sh" "exports_paths.sh"

# --- 6. Loading Detect OS, Paths, BuildFlags ---
source "$C_CORE/lib/detect_os.sh"
source "$C_CORE/lib/env_paths.sh"
source "$C_CORE/lib/env_flags.sh"

# --- 9. Summary ---
log::summary() {
    local duration=$(( $(date +%s) - __env_start_time ))
    log::section "Environment init complete"
    log::success "Duration: ${duration}s | OS=$OS | ScriptDir=$SCRIPT_DIR"
}
log::summary

log::success "Environment successfully initialized"
