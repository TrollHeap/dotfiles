#!/bin/bash

PACKAGE_LIST="$CONFIG_ENV/linux/package_list.txt"
source "$CONFIG_FUNCTIONS/install_packages.sh"

# Detect the OS
detect_os() {
    if [[ -f "/etc/os-release" ]]; then
        source /etc/os-release
        case "$ID" in
            arch | manjaro | cachyos)
                echo "arch"
                ;;
            *)
                echo "$ID"
                ;;
        esac
    else
        echo "unknown"
    fi
}

OS=$(detect_os)

# ----- Update the system -----
echo "Updating the system..."
case "$OS" in
    ubuntu|debian)
        sudo apt update && sudo apt upgrade -y && sudo apt install -y build-essential
        PACKAGE_MANAGER="apt"
        ;;
    fedora)
        sudo dnf check-update && sudo dnf upgrade -y && sudo dnf groupinstall -y "Development Tools"
        PACKAGE_MANAGER="dnf"
        ;;
    arch)
        if command -v yay &>/dev/null; then
            yay -Syu --noconfirm
            PACKAGE_MANAGER="yay"
        else
            sudo pacman -Syu --noconfirm
            sudo pacman -S --needed --noconfirm base-devel
            PACKAGE_MANAGER="pacman"
        fi
        ;;
    *)
        echo "Unsupported OS: $OS"
        exit 1
        ;;
esac

# -----  Install essential packages -----
echo "Installing essential packages..."
if [ -f "$PACKAGE_LIST" ]; then
    install_packages "$PACKAGE_LIST" "$PACKAGE_MANAGER"
else
    echo "Error: Package list file not found at $PACKAGE_LIST!" >&2
    exit 1
fi
