#!/usr/bin/env bash

# ─── ENV: Logger & Constants ──────────────────────────────────────────────
ROOT_ENVFILES="$HOME/dotfiles/env-files/.config/env-files"
source "$ROOT_ENVFILES/config/env/globals_locals.env"
source "$ROOT_ENVFILES/config/env/logs.env"
source "$C_CORE/lib/logger.sh"

log::use ENV_MODULES
log::section "Loading environment modules"

# ─── load_modules : source all defined modules with logging ───────────────
load_modules() {
  local modules=(
    "$C_MODULES/shell/zsh.sh"
    "$C_MODULES/shell/ohmyzsh.sh"
    "$C_TOOLS/starship.sh"
    "$C_TOOLS/tmux_tpm.sh"
    "$C_TOOLS/nvm.sh"
    "$C_TOOLS/fzf.sh"
    "$C_TOOLS/wezterm.sh"
    "$C_TOOLS/pyenv.sh"
    "$C_TOOLS/nerdfonts.sh"
  )

  for mod in "${modules[@]}"; do
    local label="${mod##*/}"  # ex: zsh.sh → zsh.sh
    if [[ -f "$mod" ]]; then
      if source "$mod"; then
        log::info "Loaded module: $label"
      else
        log::error "Failed to load module: $label → $mod"
      fi
    else
      log::warn "Missing module: $label → $mod"
    fi
}

load_modules
log::success "All modules loaded"
