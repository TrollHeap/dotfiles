#!/bin/bash

# ----- Initialize Cargo (Rust) -----
# Source Cargo's environment if the configuration file exists
if [ -f "$HOME/.cargo/env" ]; then
    source "$HOME/.cargo/env"
fi

# ----- Initialize NVM (Node Version Manager) -----
# Set the NVM directory
export NVM_DIR="$HOME/.nvm"

# Load NVM if its script is available
if [ -s "$NVM_DIR/nvm.sh" ]; then
    source "$NVM_DIR/nvm.sh" # Load NVM
fi

# Load NVM bash completion if available
if [ -s "$NVM_DIR/bash_completion" ]; then
    source "$NVM_DIR/bash_completion"
fi

# ----- Initialize Pyenv (Python Version Manager) -----
# Check if Pyenv is installed
if command -v pyenv >/dev/null; then
    # Activate Pyenv configuration
    eval "$(pyenv init --path)"
    eval "$(pyenv virtualenv-init -)"
fi

# ----- Configure FZF (Fuzzy Finder) -----
# Source FZF completion if the file exists
if [ -f "$HOME/.fzf/shell/completion.zsh" ]; then
    source "$HOME/.fzf/shell/completion.zsh"
fi

# Source FZF key bindings if the file exists
if [ -f "$HOME/.fzf/shell/key-bindings.zsh" ]; then
    source "$HOME/.fzf/shell/key-bindings.zsh"
fi
