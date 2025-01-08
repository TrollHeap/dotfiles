# Load all environment variables
CONFIG_PATH="~/.config/env-files"

# Load shell functions
source $CONFIG_PATH/functions/global-functions.sh
source $CONFIG_PATH/functions/dev-functions.sh

# Load general configurations if available
source $CONFIG_PATH/loads/general_load.sh

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
    source $CONFIG_PATH/loads/macos_load.sh
else
    for linux_file in ~/.config/env-files/linux/*.env; do
        source "$linux_file"
    done
    source $CONFIG_PATH/loads/ubuntu_load.sh
fi

## Load all PATH configurations
for path_file in ~/.config/env-files/path/*.env; do
    source "$path_file"
done

# ----- Create the Developer directory -----
source $CONFIG_PATH/loads/folders_load.sh
# ---- Stow the dotfiles -----
source $CONFIG_PATH/loads/stow_load.sh

# Finalization message
echo "All configurations have been loaded."
