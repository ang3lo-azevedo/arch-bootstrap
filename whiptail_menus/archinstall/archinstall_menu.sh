#!/bin/bash

# Source the menu utils
source "whiptail_menus/utils/menu_utils.sh"

# Function to show the archinstall menu
archinstall_menu() {
    yes_no_menu "Run archinstall?"
    if [ $? -eq 0 ]; then
        # Run the run with sudo menu
        source "whiptail_menus/run_with_sudo/run_with_sudo_menu.sh"
        run_with_sudo

        # Install archinstall
        install_package_menu "archinstall"

        # Run archinstall with custom config
        yes_no_menu "Use custom config?"
        local title="Running archinstall"
        if [ $? -eq 0 ]; then
            local command="archinstall --config 'archinstall-config/user_configuration.json'"
            local title="$title with custom config"
        else
            local command="archinstall"
        fi

        running_command_menu "$command" "$title" "$title"
    fi
}