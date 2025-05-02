#! /bin/bash

# Source the bash utils
source "bash-utils/utils.sh"

# Set the variables
SCRIPT_NAME="Ângelo's Arch Linux Installation"
VERSION="0.1.0"
AUTHOR="Ângelo Azevedo"

MENU_DIR="$(dirname "$(dirname "${BASH_SOURCE[0]}")")"
BACKTITLE="Ângelo's Arch Linux Installation"
TITLE="Installation Options"
HEIGHT=15
WIDTH=50

# Get the number of CPU cores
cpu_cores=$(nproc)

choices=()
thread_count=0
parallel_downloads=0

# Function to show a yes/no menu
yes_no_menu() {
    local message=$1

    dialog --clear --backtitle "$BACKTITLE" --title "$TITLE" --yesno "$message" $HEIGHT $WIDTH

    # If the user cancels the input, return 1
    if [ $? -eq 1 ]; then
        return 1
    fi
}

# Function to show the welcome screen
welcome_screen() {
    dialog --clear --backtitle "$BACKTITLE" --title "$TITLE" --msgbox "Welcome to $SCRIPT_NAME \nv$VERSION by $AUTHOR" $HEIGHT $WIDTH
}

# Function to show an input menu
input_menu() {
    local choice=$1
    local title=$2
    local inputbox=$3
    local default_value=$4 || $cpu_cores

    # Get number of threads
    input=$(dialog --clear \
        --backtitle "$BACKTITLE" \
        --title "$TITLE" \
        --inputbox "$inputbox" \
        $HEIGHT $WIDTH \
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