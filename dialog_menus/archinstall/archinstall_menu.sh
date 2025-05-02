#!/bin/bash

# Function to show the archinstall menu
archinstall_menu() {
    yes_no_menu "Run archinstall?"
    if [ $? -eq 0 ]; then
        # Install archinstall
        install_package "archinstall"
        
        # Run archinstall with custom config
        yes_no_menu "Use custom config?"
        # Ensure we have a proper tty
            exec < /dev/tty
            exec > /dev/tty
        if [ $? -eq 0 ]; then
            sudo archinstall --config archinstall-config/user_configuration.json
        else
            sudo archinstall
        fi

        # If the archinstall succeeds, enter the chroot environment
        if [ $? -eq 0 ]; then
            print_status "Entering chroot environment"
            arch-chroot /mnt 
        fi
    fi
}