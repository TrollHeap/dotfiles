#!/bin/bash
# Description: Load all the necessary configurations

# ----- Variables -----
INIT_FLAG="$CONFIG_PATH/.init_done"

# ----- First-Time Initialization -----
if [ ! -f "$INIT_FLAG" ]; then
    echo "Performing first-time initialization..."
   
    # Load General OS-Specific Configurations
    source "$CONFIG_INIT/os_specific/general_setup.sh"

    # Create the Developer directory
    source "$CONFIG_INIT/modules/folders_setup.sh"

    # Mark initialization as complete
    touch "$INIT_FLAG"
    echo "First-time initialization complete."

    # Load the ending stow setup
    if [ -e "$INIT_FLAG"] ; then
        source "$CONFIG_INIT/modules/stow_setup.sh"
    fi
fi


# ----- Load OS-Specific Environment Variables -----
if [[ "$OSTYPE" == "darwin"* ]]; then
    source "$CONFIG_PATH/env/macos" ".env"

    # Homebrew initialization
    eval "$(/opt/homebrew/bin/brew shellenv)"
    source "$CONFIG_INIT/tools/init.sh"
else
    source "$CONFIG_PATH/env/linux" ".env"
    source "$CONFIG_INIT/tools/init.sh"
fi
