#!/bin/bash

source "$CONFIG_FUNCTIONS/init_path.sh"

# Check if the logs directory exists, create it if not
mkdir -p "$(dirname "$LOG_FILE")"

# Load external initialization scripts
init_path "$CONFIG_SCRIPTS/tools/init_fzf.sh"
init_path "$CONFIG_SCRIPTS/tools/init_nvm.sh"
init_path "$CONFIG_SCRIPTS/tools/init_pyenv.sh"
