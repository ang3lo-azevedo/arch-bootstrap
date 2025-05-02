#!/bin/bash

# Set the directory
dir=$(dirname "$0")

# Source the utils
source "$dir/utils/utils.sh"

# Source the menu utils
source "$dir/whiptail_menus/utils/utils.sh"

# Set the variables
not_sudo_title="Error"
not_sudo_message="You need to run with sudo"

# Function to show the not sudo menu
not_sudo_menu() {
    whiptail --backtitle "$backtitle" --title "$not_sudo_title" --msgbox "$not_sudo_message" 10 30
    run_with_sudo_menu
}

# Function to show the run with sudo menu
run_with_sudo_menu() {
    yes_no_menu "Run with sudo?"
    if [ $? -eq 0 ]; then
        sudo su
    fi
}

# Function to check if the user is root and show the not root menu if not
run_with_sudo() {
    if [ "$EUID" -ne 0 ]; then
        not_sudo_menu
    fi
}