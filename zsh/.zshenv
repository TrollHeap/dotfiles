# ─── Global Encoding ────────────────────────────────────────────────────────────
export LANG="en_US.UTF-8"
# export LC_ALL="en_US.UTF-8"  # Disabled to allow sub-locales to override

# ─── PATH Configuration ─────────────────────────────────────────────────────────
path_add() {
  case ":$PATH:" in
    *":$1:"*) ;;                    # Already in PATH → skip
    *) PATH="$1:$PATH" ;;           # Prepend if missing
  esac
}

# Custom binaries
ENVCTL_BIN="$HOME/dotfiles/env-files/.config/env-files/bin"
[[ -d "$ENVCTL_BIN" ]] && path_add "$ENVCTL_BIN"

# Common additions
path_add "$HOME/.local/bin"
path_add "/usr/local/bin"

export PATH

# ─── Global Variables ──────────────────────────────────────────────────────────
export NVM_DIR="$HOME/.nvm"
export FZF_DIR="$HOME/.fzf"
export EDITOR="nvim"
