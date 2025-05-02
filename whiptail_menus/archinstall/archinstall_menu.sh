#!/bin/bash

# Set the directory
dir=$(dirname "$0")

# Source the utils
source "$dir/utils/utils.sh"

# Source the menu utils
source "$dir/whiptail_menus/utils/utils.sh"

# Function to show the archinstall menu
archinstall_menu() {
    yes_no_menu "Run archinstall?"
    if [ $? -eq 0 ]; then
        # Run the run with sudo menu
        source "$dir/whiptail_menus/run_with_sudo/run_with_sudo_menu.sh"
        run_with_sudo

        # Install archinstall
        install_package "archinstall"

        # Run archinstall with custom config
        yes_no_menu "Run archinstall with custom config?"
        if [ $? -eq 0 ]; then
            archinstall --config "$dir/archinstall-config/user_configuration.json"
        else
            # Run archinstall with default config
            archinstall
        fi
    fi
}