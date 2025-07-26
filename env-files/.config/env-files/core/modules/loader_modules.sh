#!/usr/bin/env bash

# ─── ENV: Logger & Constants ──────────────────────────────────────────────
ROOT_ENV="$HOME/dotfiles/env-files/.config/env-files"
source "$ROOT_ENV/config/env/globals_locals.env"
source "$ROOT_ENV/config/env/logs.env"
source "$ROOT_ENV/core/lib/logger.sh"

log::use ENV_MODULES
log::section "Loading environment modules"

# ─── load_modules : source all defined modules with logging ───────────────
load_modules() {
    local modules_path="$ROOT_ENV/core/modules"

    local modules=(
        "$modules_path/tools/starship.sh"
        "$modules_path/tools/tmux_tpm.sh"
        "$modules_path/tools/nvm.sh"
        "$modules_path/tools/fzf.sh"
        "$modules_path/tools/wezterm.sh"
        "$modules_path/tools/pyenv.sh"
        "$modules_path/tools/nerdfonts.sh"
        "$modules_path/shell/ble-sh.sh"
        "$modules_path/packages/cargo_install.sh"
        "$modules_path/packages/pip_install.sh"
        "$modules_path/app/remnote.sh"
    )

    for mod in "${modules[@]}"; do
        local label="${mod##*/}"
        if [[ -f "$mod" ]]; then
            source "$mod"
            log::info "Loaded module: $label"
        else
            log::warn "Missing module: $label → $mod"
        fi

        if [[ -f "$mod" ]]; then
            if source "$mod"; then
                log::info "Loaded module: $label"
            else
                log::error "Failed to load module: $label → $mod"
            fi
        else
            log::warn "Missing module: $label → $mod"
        fi
    done
}

load_modules
log::success "All modules loaded"
