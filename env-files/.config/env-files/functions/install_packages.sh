#!/bin/bash

# Function to install packages from a list using a package manager
install_packages() {
    local package_list=$1
    local package_manager=$2

    echo "Installing packages from the list: $package_list using $package_manager..." >> "$LOG_FILE/install_packages.log"

    # Check if the package list file exists
    if [ ! -f "$package_list" ]; then
        echo "Error: Package list file '$package_list' not found!" >> "$LOG_FILE/install_packages.log"
        return 1
    fi

    # Install packages from the list
    while IFS= read -r package; do
        if [ -n "$package" ]; then
            echo "Installing $package..." 
            if ! sudo "$package_manager" install -y "$package"; then
                echo "Error: Failed to install $package. Check the log for details." >> "$LOG_FILE/install_packages.log"
            else
                echo "$package installed successfully." >> "$LOG_FILE/install_packages.log"
            fi
        fi
    done < "$package_list"

    echo "Package installation completed." >> "$LOG_FILE/install_packages.log"
}
