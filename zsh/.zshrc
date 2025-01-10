# ZSH - Environment Configuration
# Author: Binary-grunt

# ENV Variables
source ~/.config/env-files/main.sh

# Plugins
plugins=(git fzf fzf-zsh-plugin zsh-syntax-highlighting zsh-autosuggestions)

# Starship Prompt
eval "$(starship init zsh)"

# Execute neofetch on new terminal launch
if command -v neofetch > /dev/null; then
  neofetch
fi

# Initialize Oh My Zsh
source $HOME/.oh-my-zsh/oh-my-zsh.sh
