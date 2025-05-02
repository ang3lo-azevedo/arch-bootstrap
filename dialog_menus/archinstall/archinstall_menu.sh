#!/bin/bash

# Function to mount the USB drive
mount_usb() {
    # Find the device with Ventoy partition
    local ventoy_device=$(lsblk -o NAME,LABEL | grep -i ventoy | awk '{print $1}' | sed 's/[0-9]*$//')
    
    if [ -z "$ventoy_device" ]; then
        print_error "No device with Ventoy partition found"
        return 1
    fi

    # Mount the second partition
    mount "/dev/${ventoy_device}2" /mnt
}

# Function to run the main menu in the chroot environment
custom_arch_chroot() {
    local command="
        git clone $REPO_URL $REPO_DIR
        cd $REPO_DIR
        ./dialog_menus/menu_after_chroot.sh
    "

    arch-chroot /mnt /bin/bash -c "$command"
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
            command="$command --config archinstall-config/user_configuration.json"
        fi
        
        # Get the user_password from the usb
        yes_no_menu "Get user_password from USB?"
        if [ $? -eq 0 ]; then
            # Mount the USB drive
            mount_usb

            # Get the user_password from the usb
            command="$command --user_password $(cat /mnt/user_password)"
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