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

# Function to run the full archinstall
run_full_archinstall() {
    # Install archinstall
    install_package "archinstall"

    # Mount the USB drive
    mount_usb

    # Get the user_password from the usb
    local user_password=$(cat $USER_PASSWORD_FILE)

    # Run the full archinstall
    sudo archinstall --config $CONFIG_FILE --user_password $user_password
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

        # Run archinstall with custom config
        yes_no_menu "Use custom config?"
        if [ $? -eq 0 ]; then
            command="$command --config $CONFIG_FILE"
        fi

        # Run the command
        $command

        # If the archinstall succeeds, enter the chroot environment
        if [ $? -eq 0 ]; then
            print_status "Entering chroot environment"
            custom_arch_chroot
        fi
    fi
}