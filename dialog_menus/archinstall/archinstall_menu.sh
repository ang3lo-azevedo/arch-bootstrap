#!/bin/bash

# Function to show the archinstall menu
archinstall_menu() {
    yes_no_menu "Run archinstall?"
    if [ $? -eq 0 ]; then
        # Install archinstall
        install_package "archinstall"
        
        # Clear the screen and reset terminal
        clear
        reset
        
        # Run archinstall with custom config
        yes_no_menu "Use custom config?"
        if [ $? -eq 0 ]; then
            # Ensure we're in a clean terminal state
            stty sane
            sudo archinstall --config archinstall-config/user_configuration.json
        else
            # Ensure we're in a clean terminal state
            stty sane
            sudo archinstall
        fi

        # If the archinstall succeeds, run the post-installation script
        if [ $? -eq 0 ]; then
            arch-chroot /mnt 
        fi
    fi
}