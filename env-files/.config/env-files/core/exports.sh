#!/usr/bin/env bash

# ╭──────────────────────────────────────────────────────────────╮
# │ ENV EXPORTS - Global environment variables & PATH setup      │
# ╰──────────────────────────────────────────────────────────────╯

# --- Locale and editor
export LANG="en_US.UTF-8"
export EDITOR="nvim"

# --- Utility: append to PATH only if not already present
path_add() {
  case ":$PATH:" in
    *:"$1":*) ;;       # Already in PATH → skip
    *) PATH="$1:$PATH" ;;
  esac
}

# --- Common path additions
path_add "$HOME/.local/bin"
path_add "/usr/local/bin"
