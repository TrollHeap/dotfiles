# ╭──────────────────────────────────────────────────────────────╮
# │ BASH CONFIGURATION - Binary-grunt                             │
# ╰──────────────────────────────────────────────────────────────╯
set -o vi
[ -f "$HOME/.profile" ] && . "$HOME/.profile"

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
