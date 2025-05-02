#!/bin/bash

# Set the directory
dir=$(dirname "$0")

# Source the utils
source "$dir/utils/utils.sh"

# Source the menu utils
source "$dir/whiptail_menus/utils/utils.sh"

# Function to show the NVIDIA drivers menu
nvidia_drivers_menu() {
    yes_no_menu "Install NVIDIA Drivers?"
    if [ $? -eq 0 ]; then
        choices+=("nvidia")
    fi
}