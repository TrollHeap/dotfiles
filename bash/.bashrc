# ╭──────────────────────────────────────────────────────────────╮
# │ BASH CONFIGURATION - Binary-grunt                            │
# ╰──────────────────────────────────────────────────────────────╯
set -o vi
export LANG="en_US.UTF-8"
export EDITOR="nvim"
#export TERM="xterm-256color"
export DOTFILES="$HOME/dotfiles"
export ROOT_ENV="$DOTFILES/env-files/.config/env-files"
export ROOT_LOGS="$DOTFILES/.cache/logs"

[ -f "$HOME/.cargo/env" ] && . "$HOME/.cargo/env"

# --- 0. Starship ---
eval "$(starship init bash)"

[[ $- == *i* ]] && source ~/.local/share/blesh/ble.sh --noattach
[[ ! ${BLE_VERSION-} ]] || ble-attach

# --- 1. Core Environment
[[ -f "$ROOT_ENV/core/env.sh" ]] && source "$ROOT_ENV/core/env.sh"

ssh-add -l > /dev/null 2>&1 || ssh-add ~/.ssh/id_ed25519

# --- 2. Load environment variables & aliases
[[ -f "$HOME/dotfiles/env-files/.config/env-files/config/env/aliases.env" ]]   && source "$ROOT_ENV/config/env/aliases.env"


# --- 3. Shell Tools Initialization
command -v pyenv &>/dev/null && eval "$(pyenv init --path)"

# --- 4. Dynamic Displays (neofetch, taskwarrior, system status)
if command -v neofetch >/dev/null; then
  neofetch
elif command -v fastfetch >/dev/null; then
  fastfetch
fi

#source $ROOT_SCRIPTS/tools/taskwarrior/task_summary.sh

# Remove any duplicate PATH entries after all sources
PATH="$(echo "$PATH" | tr ':' '\n' | awk '!seen[$0]++' | paste -sd: -)"
# Finalization
echo "All configurations have been loaded."

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
. "$HOME/.cargo/env"
