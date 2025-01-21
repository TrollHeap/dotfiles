# Description: Load all the necessary configurations

# ----- Variables -----
INIT_FLAG="$CONFIG_PATH/.init_done"

# ----- First-Time Initialization -----
if [ ! -f "$INIT_FLAG" ]; then
    echo "Performing first-time initialization..."
    
    # Load global environment variables
    for env in $CONFIG_PATH/env/global/*.env; do
        echo "Loading global environment variables..."
        [ -r "$env" ] && source "$env"
    done

    # Load OS-specific configurations
    if [[ "$OSTYPE" == "darwin"* ]]; then
        echo "Loading macOS-specific configurations..."
        source "$CONFIG_PATH/scripts/os_specific/macos_setup.sh"
    else
        echo "Loading Ubuntu-specific configurations..."
        source "$CONFIG_PATH/scripts/os_specific/ubuntu_setup.sh"
    fi

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
else
    source "$CONFIG_PATH/env/linux" ".env"
fi
