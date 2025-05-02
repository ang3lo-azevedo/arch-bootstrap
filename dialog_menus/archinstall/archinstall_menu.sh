#!/bin/bash

CONFIG_FILE="archinstall-config/user_configuration.json"
USER_PASSWORD_FILE="/mnt/usb/user_password"

# Function to run the main menu in the chroot environment
custom_arch_chroot() {
    local command="
        git clone $REPO_URL $REPO_DIR
        cd $REPO_DIR
        ./dialog_menus/menu_after_chroot.sh
    "

    arch-chroot /mnt /bin/bash -c "$command"
}

# Function to run archinstall
run_archinstall() {
    local command=$1
    
    # Install archinstall
    install_package "archinstall"

    if [ -z "$command" ]; then
        # Run the full archinstall
        sudo archinstall --config $CONFIG_FILE
    else
        yes_no_menu "Use custom config?"
        if [ $? -eq 0 ]; then
            command="$command --config $CONFIG_FILE"
        fi

        # Run the command
        $command
    fi

    # If the archinstall succeeds, enter the chroot environment
    if [ $? -eq 0 ]; then
        print_status "Entering chroot environment"
        custom_arch_chroot
    fi
}

# Function to show the archinstall menu
archinstall_menu() {
    yes_no_menu "Run archinstall?"
    if [ $? -eq 0 ]; then
        # Install archinstall
        install_package "archinstall"
        
        local command="
            sudo archinstall
        "

        # Run the archinstall
        run_archinstall "$command"
    fi
}