#!/bin/bash
# Description: Load all the necessary configurations

# ----- Variables -----
INIT_FLAG="$CONFIG_PATH/.init_done"

# ----- First-Time Initialization -----
if [ ! -f "$INIT_FLAG" ]; then
    echo "Performing first-time initialization..."
    
    source "$CONFIG_PATH/scripts/modules/stow_setup.sh"

    # Load Main OS-Specific Configurations
    source "$CONFIG_PATH/scripts/os_specific/main_setup.sh"

    # Create the Developer directory
    source "$CONFIG_PATH/scripts/modules/folders_setup.sh"

    # Mark initialization as complete
    touch "$INIT_FLAG"
fi


# ----- Load OS-Specific Environment Variables -----
if [[ "$OSTYPE" == "darwin"* ]]; then
    source "$CONFIG_PATH/env/macos" ".env"

    # Homebrew initialization
    eval "$(/opt/homebrew/bin/brew shellenv)"
    source "$CONFIG_PATH/scripts/tools/init.sh"
else
    source "$CONFIG_PATH/env/linux" ".env"
    source "$CONFIG_PATH/scripts/tools/init.sh"
fi
