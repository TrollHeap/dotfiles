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
    source ~/.config/env-files/loads/macos_load.sh
else
    for linux_file in ~/.config/env-files/linux/*.env; do
        source "$linux_file"
    done
    source ~/.config/env-files/loads/ubuntu_load.sh
fi

## Load all PATH configurations
for path_file in ~/.config/env-files/path/*.env; do
    source "$path_file"
done

# Load shell functions
source ~/.config/env-files/functions/global-functions.sh
source ~/.config/env-files/functions/dev-functions.sh


# Load aliases
source ~/.config/env-files/env/aliases.env

# ----- Create the Developer directory -----
source ./folders_load.sh

# Finalization message
echo "All configurations have been loaded."
