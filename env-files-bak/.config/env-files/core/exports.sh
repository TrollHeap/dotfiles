#!/usr/bin/env bash

export LANG="en_US.UTF-8"
export EDITOR="nvim"

# Add to PATH only if missing
path_add() {
  case ":$PATH:" in
    *:"$1":*) ;;  # Already present
    *) PATH="$1:$PATH" ;;
  esac
}

# PATH augmentations
path_add "$HOME/.local/bin"
path_add "/usr/local/bin"

# Optional tool directories (safe if used before tool install)
