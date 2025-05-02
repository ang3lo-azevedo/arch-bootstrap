#! /bin/bash

# Get the absolute path of the script directory
root_dir=$(dirname "$0")

# Source the utils
source "$root_dir/utils/utils.sh"

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

    whiptail --clear --backtitle "$backtitle" --title "$title" --yes-button "Yes" --no-button "No" --cancel-button "Cancel" --yesno "$message" $height $width
    exit
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

    # Get number of threads
    input=$(whiptail --clear \
        --backtitle "$backtitle" \
        --title "$title" \
        --inputbox "$inputbox" \
        --ok-button "OK" \
        --cancel-button "Cancel" \
        "$height" "$width" \
        "$default_value" \
        3>&1 1>&2 2>&3)
    
    local exit_code=$?
    if [ $exit_code -eq 0 ]; then
        choices+=("$choice")
    fi

    # Return the input and exit code
    echo "$input"
    return $exit_code
}

# Function to show a package installation menu
install_package_menu() {
    local package=$1

    if ! command_exists "$package"; then
        running_command_menu "sudo pacman -S --noconfirm $package" "Installing $package" "$package is being installed"
    else
        whiptail --clear \
            --backtitle "$backtitle" \
            --title "$title" \
            --msgbox "$package is already installed" \
            $height $width
    fi
}