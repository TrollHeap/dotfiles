# ╭──────────────────────────────────────────────────────────────╮
# │ BASH CONFIGURATION - Binary-grunt                            │
# ╰──────────────────────────────────────────────────────────────╯
set -o vi

source "$HOME/api-key.env"
export N8N_RUNNERS_ENABLED=true
export PATH=/home/binary/.opencode/bin:$PATH

# --- 0. Starship ---
eval "$(starship init bash)"

[[ $- == *i* ]] && source ~/.local/share/blesh/ble.sh --noattach
[[ ! ${BLE_VERSION-} ]] || ble-attach

# --- 1. Core Environment
[[ -f "$ROOT_ENV/main.sh" ]] && source "$ROOT_ENV/main.sh"

ssh-add -l > /dev/null 2>&1 || ssh-add ~/.ssh/id_ed25519_github

# --- 2. Load environment variables & aliases
[[ -f "$HOME/dotfiles/env-files/.config/env-files/config/env/aliases.env" ]]   && source "$ROOT_ENV/config/env/aliases.env"


# --- 3. Shell Tools Initialization
command -v pyenv &>/dev/null && eval "$(pyenv init --path)"

# --- 4. Dynamic Displays (neofetch, taskwarrior, system status)
if command -v neofetch >/dev/null; then
    echo ""
    neofetch
elif command -v fastfetch >/dev/null; then
    echo ""
    fastfetch
fi

eval "$(zoxide init bash)"
#source $ROOT_SCRIPTS/tools/taskwarrior/task_summary.sh

# Remove any duplicate PATH entries after all sources
PATH="$(echo "$PATH" | tr ':' '\n' | awk '!seen[$0]++' | paste -sd: -)"
# Finalization
echo "All configurations have been loaded."

