BREW_LIST="$HOME/.config/env-files/env/macos/brew_list.txt"

# Install Homebrew
echo "Installing Homebrew..."
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install packages from the list
echo "Installing packages from the list..."
for i in $(cat BREW_LIST); do
  brew install $i
done
