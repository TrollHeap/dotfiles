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

# --- 3. Load static config ---
# source "$ROOT_ENVFILES/config/env/globals_public.env"
# [[ -f "$VAR_FILE" ]] && source "$VAR_FILE" && log::info "Loaded $VAR_FILE" || {
#   log::error "Missing: $VAR_FILE"
#   return 1 2>/dev/null || exit 1
# }

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

# --- 6. Detect OS ---
detect_os() {
  [[ "$OSTYPE" == "darwin"* ]] && echo "macos" && return
  [[ -f /etc/os-release ]] && {
    . /etc/os-release
    case "$ID" in
      arch | manjaro | cachyos | endeavouros) echo "arch" ;;
      ubuntu | debian) echo "ubuntu" ;;
      fedora) echo "fedora" ;;
      *) echo "$ID" ;;
    esac
    return
  }
  echo "unknown"
}
export OS="$(detect_os)"
log::info "Detected OS: $OS"

# --- 7. Load OS-specific paths ---
case "$OS" in
  macos)  log::try_source "$C_PATHS/macos-paths.env" ;;
  arch)   log::try_source "$C_PATHS/arch-paths.env" ;;
  ubuntu) log::try_source "$C_PATHS/ubuntu-paths.env" ;;
  *)      log::warn "No OS-specific path override for $OS" ;;
esac

# --- 8. Optional build flags ---
BUILD_FLAG_FILE="$C_CONFIG/buildflag/${OS}_buildflags.env"
[[ -f "$BUILD_FLAG_FILE" ]] && source "$BUILD_FLAG_FILE" && log::info "Loaded build flags" || log::info "No build flags for $OS"

# --- 9. Summary ---
log::summary() {
  local duration=$(( $(date +%s) - __env_start_time ))
  log::section "Environment init complete"
  log::success "Duration: ${duration}s | OS=$OS | ScriptDir=$SCRIPT_DIR"
}
log::summary

log::success "Environment successfully initialized"

exit 0
