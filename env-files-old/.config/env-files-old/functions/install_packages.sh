#!/bin/bash

# Function to install packages from a list using a package manager
install_packages() {
    local package_file="$1"
    local manager="$2"

    while IFS= read -r package || [ -n "$package" ]; do
        [[ -z "$package" || "$package" == \#* ]] && continue

        if [[ "$package" == "-- cask "* ]]; then
            continue  # Mac-only
        fi

        case "$manager" in
            apt)
                sudo apt install -y "$package"
                ;;
            dnf)
                sudo dnf install -y "$package"
                ;;
            pacman)
                sudo pacman -S --needed --noconfirm "$package"
                ;;
            yay)
                yay -S --needed --noconfirm "$package"
                ;;
            *)
                echo "Unsupported package manager: $manager"
                exit 1
                ;;
        esac
    done < "$package_file"
}
