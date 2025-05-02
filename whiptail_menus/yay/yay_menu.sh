#!/bin/bash

# Set the directory
dir=$(dirname "$0")

# Source the utils
source "$dir/utils/utils.sh"

# Source the menu utils
source "$dir/whiptail_menus/utils/utils.sh"

# Function to show the yay menu
yay_menu() {
    yes_no_menu "Install yay?"
    if [ $? -eq 0 ]; then
        choices+=("yay")
    fi
}