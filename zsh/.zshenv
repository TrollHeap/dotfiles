# ─── Encoding global ───────────────────────────────────────────────────────────
export LANG="en_US.UTF-8"
# export LC_ALL="en_US.UTF-8"  # désactivé pour laisser les sous-locales décider

# ─── PATH ──────────────────────────────────────────────────────────────────────
path_add() {
  case ":$PATH:" in
    *":$1:"*) ;; 
    *) PATH="$1:$PATH" ;;
  esac
}

# Ajoute envctl uniquement si dossier existant
ENVCTL_BIN="$HOME/dotfiles/env-files/.config/env-files/bin"
[[ -d "$ENVCTL_BIN" ]] && path_add "$ENVCTL_BIN"

# Ajouts classiques
path_add "$HOME/.local/bin"
path_add "/usr/local/bin"

export PATH

# ─── Variables globales ────────────────────────────────────────────────────────
export NVM_DIR="$HOME/.nvm"
export FZF_DIR="$HOME/.fzf"
export EDITOR="nvim"
