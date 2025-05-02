#!/bin/bash

# Function to run the main menu in the chroot environment
custom_arch_chroot() {
    local command="
        git clone $REPO_URL $REPO_DIR
        cd $REPO_DIR
        source dialog_menus/menu_utils.sh
        menu_after_chroot
    "

    arch-chroot /mnt /bin/bash -c "$command"
}

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
            sudo archinstall
        fi

        # If the archinstall succeeds, enter the chroot environment
        if [ $? -eq 0 ]; then
            print_status "Entering chroot environment"
            custom_arch_chroot
        fi
    fi
}