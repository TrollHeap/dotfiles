# ╭──────────────────────────────────────────────────────────────╮
# │ BASH CONFIGURATION - Binary-grunt                            │
# ╰──────────────────────────────────────────────────────────────╯
set -o vi

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
eval "$(zoxide init bash)"
#source $ROOT_SCRIPTS/tools/taskwarrior/task_summary.sh

# Remove any duplicate PATH entries after all sources
PATH="$(echo "$PATH" | tr ':' '\n' | awk '!seen[$0]++' | paste -sd: -)"
# Finalization
echo "All configurations have been loaded."
