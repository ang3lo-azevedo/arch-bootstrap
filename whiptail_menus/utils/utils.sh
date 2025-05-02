#! /bin/bash

# Set the variables
backtitle="Ângelo's Arch Linux Installation"
title="Installation Options"
height=8
width=60

# Get the number of CPU cores
cpu_cores=$(nproc)

choices=()
thread_count=0
parallel_downloads=0

# Function to install whiptail if not present
install_whiptail() {
    if ! command_exists "whiptail"; then
        print_status "Installing whiptail..."
        sudo pacman -S --noconfirm whiptail
    fi
}

# Function to show a yes/no menu
yes_no_menu() {
    local message=$1

    whiptail --clear --backtitle "$backtitle" --title "$title" --yesno "$message" $height $width
}

# Function to show the welcome screen
welcome_screen() {
    whiptail --clear --backtitle "$backtitle" --title "$title" --msgbox "Welcome to my Arch Linux Installation" $height $width
}

# Function to show an input menu
input_menu() {
    local choice=$1
    local title=$2
    local inputbox=$3
    local default_value=$4 || $cpu_cores

    if [ $? -eq 0 ]; then
        choices+=("$choice")
        # Get number of threads
        input=$(whiptail --clear \
            --backtitle "$backtitle" \
            --title "$title" \
            --inputbox "$inputbox" \
            "$height" "$width" \
            "$default_value" \
            3>&1 1>&2 2>&3)
        # If user cancels thread input, remove the choice from choices
        if [ $? -ne 0 ]; then
            choices=("${choices[@]/$choice}")
        fi
    fi

    # Return the input
    echo "$input"
}