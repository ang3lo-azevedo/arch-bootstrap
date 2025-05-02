#! /bin/bash

# Source the utils
source "utils/utils.sh"

# Set the variables
MENU_DIR="$(dirname "$(dirname "${BASH_SOURCE[0]}")")"
backtitle="Ângelo's Arch Linux Installation"
title="Installation Options"
height=15
width=50

# Get the number of CPU cores
cpu_cores=$(nproc)

choices=()
thread_count=0
parallel_downloads=0

# Function to show a yes/no menu
yes_no_menu() {
    local message=$1

    dialog --clear --backtitle "$backtitle" --title "$title" --yesno "$message" $height $width

    # If the user cancels the input, return 1
    if [ $? -eq 1 ]; then
        return 1
    fi
}

# Function to show the welcome screen
welcome_screen() {
    dialog --clear --backtitle "$backtitle" --title "$title" --msgbox "Welcome to my Arch Linux Installation \nv$VERSION" $height $width
}

# Function to show an input menu
input_menu() {
    local choice=$1
    local title=$2
    local inputbox=$3
    local default_value=$4 || $cpu_cores

    # Get number of threads
    input=$(dialog --clear \
        --backtitle "$backtitle" \
        --title "$title" \
        --inputbox "$inputbox" \
        $height $width \
        "$default_value" \
        3>&1 1>&2 2>&3)
    
    local exit_code=$?
    if [ $exit_code -eq 0 ]; then
        choices+=("$choice")
    fi

    # Return the input and exit code
    echo "$input"

    # If the user cancels the input, return 1
    if [ $exit_code -eq 1 ]; then
        return 1
    fi
}