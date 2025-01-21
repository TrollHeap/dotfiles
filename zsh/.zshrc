# ZSH - Environment Configuration
# Author: Binary-grunt

# Execute neofetch on new terminal launch
if command -v neofetch > /dev/null; then
  neofetch
fi

# ENV Variables
source ~/.config/env-files/main.sh

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
