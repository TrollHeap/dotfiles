# Load all environment variables
INIT_FLAG="$HOME/.config/env-files/.init_done"
CONFIG_PATH="$HOME/.config/env-files"

if [ ! -f "$INIT_FLAG" ]; then
    echo "Performing first-time initialization..."
    # Load general configurations if available
    source $CONFIG_PATH/loads/general_load.sh

    # Load OS-specific configurations
    if [[ "$OSTYPE" == "darwin"* ]]; then
        source $CONFIG_PATH/loads/macos_load.sh
    else
        source $CONFIG_PATH/loads/ubuntu_load.sh
    fi

    # ----- Create the Developer directory -----
    source $CONFIG_PATH/loads/folders_load.sh
    touch $INIT_FLAG
fi

# Load shell functions
for shell_file in $CONFIG_PATH/functions/*.sh; do
    source "$shell_file"
done

# Load all environment variables
for env_file in ~/.config/env-files/env/*.env; do
    source "$env_file"
done

# Load OS-specific configurations
if [[ "$OSTYPE" == "darwin"* ]]; then
 for macos_file in ~/.config/env-files/macos/*.env; do
        source "$macos_file"
    done

    # Homebrew initialization
    eval "$(/opt/homebrew/bin/brew shellenv)"
else
    for linux_file in ~/.config/env-files/linux/*.env; do
        source "$linux_file"
    done
fi

## Load all PATH configurations
for path_file in ~/.config/env-files/path/*.env; do
    source "$path_file"
done

# Finalization message
echo "All configurations have been loaded."
