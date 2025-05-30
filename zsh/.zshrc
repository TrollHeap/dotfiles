# ZSH - Environment Configuration
# Author: Binary-grunt

# Execute neofetch on new terminal launch
if command -v neofetch > /dev/null; then
  neofetch
fi

# ENV Variables
source ~/.config/env-files/main.sh

task_summary() {
    echo -e "\033[0;34m  ******************************************************"
    echo -e "  *                                                    *"
    echo -e "  *   🖥️  Task Summary - $(date '+%A, %d %B %Y')   *"
    echo -e "  *                                                    *"
    echo -e "  ******************************************************\033[0m"
    echo ""
    echo -e "\033[0;35m📋 Useful TaskWarrior Aliases:\033[0m"
    echo -e "\033[0;36m+-------------------+----------------------------------------------------+\033[0m"
    echo -e "\033[0;36m| Alias             | Description                                        |\033[0m"
    echo -e "\033[0;36m+-------------------+----------------------------------------------------+\033[0m"
    echo -e "\033[0;36m| today             | Tasks due today                                    |\033[0m"
    echo -e "\033[0;36m| urgent            | Tasks with urgency > 9                             |\033[0m"
    echo -e "\033[0;36m| soon              | Tasks due in the next 3 days                       |\033[0m"
    echo -e "\033[0;36m| progress          | Display a weekly burndown graph                    |\033[0m"
    echo -e "\033[0;36m+-------------------+----------------------------------------------------+\033[0m"
    echo ""
    echo -e "\033[0;33m🗓️  Tasks for Today:\033[0m"
    task today
    echo ""
    echo -e "\033[0;32m✅ Keep pushing forward! 🚀\033[0m"
}

task_summary

# Plugins
plugins=(git fzf zsh-syntax-highlighting zsh-autosuggestions)

# Starship Prompt
eval "$(starship init zsh)"

# fzf() {
#     command fzf --preview 'bat --style=numbers --color=always --line-range :500 {}' \
#                 --multi \
#                 --reverse \
#                 --prompt="special-snowflake> " \
#                 -- "$@"
# }

# Initialize Oh My Zsh
source $HOME/.oh-my-zsh/oh-my-zsh.sh

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
