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

# Function to show a command output menu
running_command_menu() {
    local command=$1
    local title=$2
    local message=$3
    
    # Create a temporary file for the output
    local temp_file=$(mktemp)
    
    # Execute the command in background and redirect output to temp file
    (eval "$command" 2>&1 | tee "$temp_file") &
    local pid=$!
    
    # Show the output in real-time using whiptail
    while kill -0 $pid 2>/dev/null; do
        whiptail --clear \
            --backtitle "$backtitle" \
            --title "$title" \
            --msgbox "$message\n\n$(cat "$temp_file")" \
            $height $width
        sleep 1
    done
    
    # Show final output
    whiptail --clear \
        --backtitle "$backtitle" \
        --title "$title" \
        --msgbox "$message\n\n$(cat "$temp_file")" \
        $height $width
    
    # Clean up
    rm -f "$temp_file"
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