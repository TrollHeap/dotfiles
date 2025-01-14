#!/bin/bash
# Install packages from a list using a package manager
install_packages() {
    local package_list=$1
    local package_manager=$2
    echo "Installing packages from the list: $package_list using $package_manager..."

    # Check if the package list file exists
    if [ ! -f "$package_list" ]; then
        echo "Error: Package list file '$package_list' not found!"
        exit 1
    fi

    # Install packages from the list
    for package in $(cat $package_list); do
        echo "Installing $package..."
        $package_manager install $package
    done
}
