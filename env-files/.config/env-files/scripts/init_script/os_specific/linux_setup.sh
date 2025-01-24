PACKAGE_LIST="$CONFIG_ENV/linux/package_list.txt"
source "$CONFIG_FUNCTIONS/install_packages.sh"

# ----- Update the system -----
echo "Updating the system..."
sudo apt update && sudo apt upgrade -y && sudo apt install -y build-essential

# ----- Install essential packages -----
echo "Installing essential packages..."
if [ -f "$PACKAGE_LIST" ]; then
    install_packages "$PACKAGE_LIST" apt
else
    echo "Error: Package list file not found at $PACKAGE_LIST!" >&2
    exit 1
fi

