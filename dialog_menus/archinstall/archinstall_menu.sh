#!/bin/bash

CONFIG_FILE="archinstall-config/user_configuration.json"

# Function to run the main menu in the chroot environment
custom_arch_chroot() {
    local script_dir="dialog_menus"
    local script_name="menu_after_chroot.sh"

    local command="
        git clone $REPO_URL $REPO_DIR
        cd $REPO_DIR/$script_dir
        sudo chmod +x $script_name
        ./$script_name
    "

    arch-chroot /mnt /bin/bash -c "$command"
}

# Function to run archinstall
run_archinstall() {
    local is_run_all=$1
    local command="sudo archinstall"
    
    # Install archinstall
    install_package "archinstall"

    if [ -z "$is_run_all" ]; then
        yes_no_menu "Use custom config?"
        if [ $? -eq 0 ]; then
            command="$command --config $CONFIG_FILE"
        fi
    else
        command="$command --config $CONFIG_FILE"
    fi

    # Check if the USB drive is mounted
    source "$MENU_DIR/utils/usb_utils.sh"
    if is_usb_mounted && [ -f "$MOUNT_POINT/$CONFIG_FILE" ]; then
        if [ -z "$is_run_all" ]; then
            yes_no_menu "Use password config from USB drive?"
            if [ $? -eq 0 ]; then
                command="$command --config $MOUNT_POINT/$CONFIG_FILE"
            fi
        else
            command="$command --config $MOUNT_POINT/$CONFIG_FILE"
        fi
    fi
    

    # Run the command
    $command

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
        run_archinstall 0
    fi
}