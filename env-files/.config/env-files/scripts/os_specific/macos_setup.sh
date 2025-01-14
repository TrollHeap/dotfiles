BREW_LIST="$CONFIG_ENV/macos/brew_list.txt"
source "$CONFIG_FUNCTIONS/install_packages.sh"

# Install Homebrew
echo "Installing Homebrew..."
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install packages from the list
install_packages "$BREW_LIST" brew
