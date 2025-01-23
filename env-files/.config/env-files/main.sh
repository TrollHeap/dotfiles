#!/bin/bash
CONFIG_PATH="$HOME/.config/env-files"

source "$CONFIG_PATH/scripts/init.sh"

for env_file in $CONFIG_PATH/env/global/*.env; do
    # Verify if the file is readable
    [ -r "$env_file" ] && source "$env_file"
done

source "$CONFIG_PATH/env/aliases/aliases.env"
source "$CONFIG_PATH/scripts/tools/init.sh"

# Finalization
echo "All configurations have been loaded."
