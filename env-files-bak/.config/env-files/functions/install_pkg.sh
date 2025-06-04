#!/bin/bash

install_pkgs() {
    local package_file="$1"
    local manager="$2"

    [[ ! -f "$package_file" ]] && {
        echo "❌ Package list not found: $package_file"
        return 1
    }

    while IFS= read -r package || [[ -n "$package" ]]; do
        [[ -z "$package" || "$package" =~ ^# ]] && continue

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
            brew)
                brew install "$package"
                ;;
            *)
                echo "❌ Unsupported package manager: $manager"
                return 1
                ;;
        esac
    done < "$package_file"
}
