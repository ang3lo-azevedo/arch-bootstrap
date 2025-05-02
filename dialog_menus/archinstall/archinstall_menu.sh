#!/bin/bash

# Function to show the archinstall menu
archinstall_menu() {
    yes_no_menu "Run archinstall?"
    if [ $? -eq 0 ]; then
        # Install archinstall
        install_package "archinstall"
        
        # Run archinstall with custom config
        yes_no_menu "Use custom config?"
        if [ $? -eq 0 ]; then
            sudo archinstall --config archinstall-config/user_configuration.json
        else
            # Run archinstall with default config
            sudo archinstall
        fi

        # If the archinstall succeeds, run the post-installation script
        if [ $? -eq 0 ]; then
            arch-chroot /mnt 
        fi
    fi
}