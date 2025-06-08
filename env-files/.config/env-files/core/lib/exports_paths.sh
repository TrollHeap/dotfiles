#!/usr/bin/env bash

# ╭──────────────────────────────────────────────────────────────╮
# │ ENV EXPORTS - Global environment variables & PATH setup      │
# ╰──────────────────────────────────────────────────────────────╯

# --- Logger setup ---
ROOT_ENVFILES="$HOME/dotfiles/env-files/.config/env-files"
source "$ROOT_ENVFILES/config/env/logs.env"
source "$ROOT_ENVFILES/config/env/globals_locals.env"
source "$C_CORE/lib/logger.sh"
log::use ENV_PATHS
log::section "Setting up PATH exports"

# --- Utility: add to PATH if not already present
path_add() {
  case ":$PATH:" in
    *:"$1":*) return;;
    *) 
      PATH="$1:$PATH"
      log::info "Added to PATH: $1"
      ;;
  esac
}

# --- Common path additions (HIGH → LOW priority)
path_add "/usr/local/sbin"
path_add "/usr/local/bin"
path_add "$HOME/.dotnet/tools"
path_add "$HOME/.tmuxifier/bin"
path_add "$HOME/.fzf/bin"
path_add "$HOME/.local/bin"
path_add "$HOME/.pyenv/bin"

# --- Remove duplicates (quietly)
old_path="$PATH"
export PATH="$(echo "$PATH" | tr ':' '\n' | awk '!seen[$0]++' | paste -sd: -)"

if [[ "$PATH" != "$old_path" ]]; then
  log::info "Deduplicated PATH entries"
fi

log::success "PATH setup complete"
