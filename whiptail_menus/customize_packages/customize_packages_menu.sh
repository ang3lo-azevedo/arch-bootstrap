#!/bin/bash

# Set the directory
dir=$(dirname "$0")

# Source the utils
source "$dir/utils/utils.sh"

# Source the menu utils
source "$dir/whiptail_menus/utils/utils.sh"

# Function to show the customize packages menu
customize_packages_menu() {
    yes_no_menu "Customize packages?"
    if [ $? -eq 0 ]; then
        choices+=("customize_packages")
    fi
}