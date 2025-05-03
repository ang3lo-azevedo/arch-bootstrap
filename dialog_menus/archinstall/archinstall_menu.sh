#!/bin/bash

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

    # Check if the USB drive is mounted# Check if the USB drive is mounted
    source "$MENU_DIR/utils/usb_utils.sh"
    local creds_file="$MOUNT_POINT/archinstall-config/user_credentials.json"
    local config_file="$MOUNT_POINT/archinstall-config/user_configuration.json"

    if is_usb_mounted; then
        # Check if the config file exists
        if [ -f "$config_file" ]; then
            # If the config file exists, check if the user wants to use it
            if [ -z "$is_run_all" ]; then
                yes_no_menu "Use custom config?"
                if [ $? -eq 0 ]; then
                    command="$command --config $config_file"
                fi
            else
                command="$command --config $config_file"
            fi
        fi

        # Check if the credentials file exists
        if [ -f "$creds_file" ]; then
            # If the credentials file exists, check if the user wants to use it
            if [ -z "$is_run_all" ]; then
                yes_no_menu "Use credentials from USB drive?"
                if [ $? -eq 0 ]; then
                    command="$command --creds $creds_file"
                fi
            else
                command="$command --creds $creds_file"
            fi
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