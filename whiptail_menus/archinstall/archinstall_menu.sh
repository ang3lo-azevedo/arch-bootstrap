#!/bin/bash

# Source the menu utils
source "whiptail_menus/utils/menu_utils.sh"

# Function to show the archinstall menu
archinstall_menu() {
    yes_no_menu "Run archinstall?"
    if [ $? -eq 0 ]; then
        # Run the run with sudo menu
        source "whiptail_menus/run_with_sudo/run_with_sudo_menu.sh"

        # Install archinstall
        install_package "archinstall"

        # Configure terminal for proper input handling
        stty -echo
        stty -icanon
        stty -isig
        stty -ixon
        stty -iexten

        # Run archinstall with custom config
        yes_no_menu "Run archinstall with custom config?"
        if [ $? -eq 0 ]; then
            archinstall --config "archinstall-config/user_configuration.json"
        else
            # Run archinstall with default config
            archinstall
        fi

        # Restore terminal settings
        stty echo
        stty icanon
        stty isig
        stty ixon
        stty iexten

        # If the archinstall succeeds, run the post-installation script
        if [ $? -eq 0 ]; then
            arch-chroot /mnt 
        fi
    fi
}