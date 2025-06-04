#!/bin/bash

source "$CONFIG_FUNCTIONS/init_path.sh"

# ----- Log File -----
mkdir -p "$(dirname "$LOG_FILE")"

# ----- Load external initialization scripts -----
init_path "$CONFIG_INIT/tools/init_fzf.sh"
init_path "$CONFIG_INIT/tools/init_nvm.sh"
init_path "$CONFIG_INIT/tools/init_pyenv.sh"
