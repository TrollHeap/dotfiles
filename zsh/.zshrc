# ╭──────────────────────────────────────────────────────────────╮
# │ ZSH CONFIGURATION - Binary-grunt                             │
# ╰──────────────────────────────────────────────────────────────╯
export DOTFILES="${DOTFILES:-$HOME/dotfiles}"
export ROOT_ENV="$DOTFILES/env-files/.config/env-files"
export ROOT_LOGS="$DOTFILES/.cache/logs"
export MANPAGER="nvim +Man!"
# --- 0. Core Environment
[[ -f "$ROOT_ENV/core/env.sh" ]] && source "$ROOT_ENV/core/env.sh"

# --- 1. Load environment variables & aliases
[[ -f "$HOME/dotfiles/env-files/.config/env-files/config/env/aliases.env" ]]   && source "$ROOT_ENV/config/env/aliases.env"

# --- 2. SSH Agent (Keychain)
# if command -v keychain >/dev/null; then
#   eval "$(keychain --eval --quiet ~/.ssh/id_ed25519)"
# fi

# --- 3. Shell Tools Initialization
[[ -f "$FZF_DIR/shell/key-bindings.zsh" ]] && source "$FZF_DIR/shell/key-bindings.zsh"
[[ -f "$FZF_DIR/shell/completion.zsh" ]]   && source "$FZF_DIR/shell/completion.zsh"

command -v pyenv &>/dev/null && eval "$(pyenv init --path)"


# --- Starship ---
eval "$(starship init zsh)"

# --- 4. Oh My Zsh
plugins=(git fzf zsh-syntax-highlighting zsh-autosuggestions)
[[ -f "$HOME/.oh-my-zsh/oh-my-zsh.sh" ]] && source "$HOME/.oh-my-zsh/oh-my-zsh.sh"

# --- 5. Dynamic Displays (neofetch, taskwarrior, system status)
if command -v neofetch >/dev/null; then
  neofetch
elif command -v fastfetch >/dev/null; then
  fastfetch
fi

# system_status_summary() {
#   echo -e "\033[0;34m🔋 GPU/Power Status\033[0m"
#   
#   # GPU state (perf or eco)
#   if [[ -f /etc/X11/xorg.conf.d/10-nvidia-drm-outputclass.conf ]]; then
#     echo -e "🎮 Mode: \033[0;32mPerformance (NVIDIA actif)\033[0m"
#   else
#     echo -e "🔋 Mode: \033[0;33mÉconomie (iGPU actif)\033[0m"
#   fi
#
#   # NVIDIA performance state (if available)
#   if command -v nvidia-smi &>/dev/null; then
#     state=$(nvidia-smi --query-gpu=pstate --format=csv,noheader,nounits 2>/dev/null)
#     util=$(nvidia-smi --query-gpu=utilization.gpu --format=csv,noheader,nounits 2>/dev/null)
#     echo -e "📶 P-State: $state | 🎯 Utilisation GPU: ${util}%"
#   fi
#
#   # Power source
#   if command -v upower &>/dev/null; then
#     battery=$(upower -i $(upower -e | grep BAT) | grep state | awk '{print $2}')
#     if [[ "$battery" == "charging" ]]; then
#       echo -e "🔌 Alimentation: \033[0;36mSecteur (chargement)\033[0m"
#     else
#       echo -e "🔋 Alimentation: \033[0;33mBatterie\033[0m"
#     fi
#   fi
#
#   echo ""
# }
#
# task_summary() {
#     echo -e "\033[0;34m  ******************************************************"
#     echo -e "  *                                                    *"
#     echo -e "  *   🖥️  Task Summary - $(date '+%A, %d %B %Y')   *"
#     echo -e "  *                                                    *"
#     echo -e "  ******************************************************\033[0m"
#     echo ""
#     echo -e "\033[0;35m📋 Useful TaskWarrior Aliases:\033[0m"
#     echo -e "\033[0;36m+-------------------+----------------------------------------------------+\033[0m"
#     echo -e "\033[0;36m| Alias             | Description                                        |\033[0m"
#     echo -e "\033[0;36m+-------------------+----------------------------------------------------+\033[0m"
#     echo -e "\033[0;36m| today             | Tasks due today                                    |\033[0m"
#     echo -e "\033[0;36m| urgent            | Tasks with urgency > 9                             |\033[0m"
#     echo -e "\033[0;36m| soon              | Tasks due in the next 3 days                       |\033[0m"
#     echo -e "\033[0;36m| progress          | Display a weekly burndown graph                    |\033[0m"
#     echo -e "\033[0;36m+-------------------+----------------------------------------------------+\033[0m"
#     echo ""
#     echo -e "\033[0;33m🗓️  Tasks for Today:\033[0m"
#     task today
#     echo ""
#     echo -e "\033[0;32m✅ Keep pushing forward! 🚀\033[0m"
# }
#
# task_summary
# system_status_summary

# Finalization
echo "All configurations have been loaded."

