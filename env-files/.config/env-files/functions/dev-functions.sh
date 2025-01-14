#!/bin/zsh

CARGO_ENV="$HOME/.cargo/env"
FZF_DIR="$HOME/.fzf/shell"
NVM_DIR="$HOME/.nvm"

initialize_path() {
    local path=$1
    # Check if the path exists
    if [ -f "$path" ]; then
        source "$path"
    else
        echo "Error: File '$path' not found!"
        exit 1
    fi
}

# ----- Initialize Cargo (Rust) -----
initialize_path $CARGO_ENV

# ----- Initialize NVM (Node Version Manager) -----
# NVM commands
if [ -s "$HOME/.nvm/nvm.sh" ]; then
    export NVM_DIR="$HOME/.nvm"
    source "$NVM_DIR/nvm.sh"
    export PATH="$HOME/.nvm/versions/node/$(nvm current)/bin:$PATH"
else
    echo "Warning: NVM is not installed or initialized."
fi

# ----- Initialise Bash completion -----
initialize_path $NVM_DIR/bash_completion

# ----- Initialize FZF (Fuzzy Finder) -----
initialize_path $FZF_DIR/completion.zsh
initialize_path $FZF_DIR/key-bindings.zsh

# ----- Initialize Pyenv (Python Version Manager) -----
# Check if Pyenv is installed
if command -v pyenv >/dev/null; then
    # Activate Pyenv configuration
    eval "$(pyenv init --path)"
    eval "$(pyenv virtualenv-init -)"
fi
