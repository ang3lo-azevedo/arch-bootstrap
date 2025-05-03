#! /bin/bash

# Get the directory where the script is located
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
PROJECT_ROOT="$(dirname "$(dirname "$SCRIPT_DIR")")"

# Source the bash utils
source "$PROJECT_ROOT/bash-utils/utils.sh"

# Function to get version from git
get_git_version() {
    # Get the number of commits excluding dotfiles
    local commit_count=$(git rev-list --count HEAD -- . ':!dotfiles/' 2>/dev/null)

    major_version=$(($commit_count / 100))
    minor_version=$(($commit_count / 10))
    patch_version=$(($commit_count % 10))

    echo "$major_version.$minor_version.$patch_version"

}

# Set the variables
SCRIPT_NAME="Ângelo's Arch Linux Installation"
VERSION=$(get_git_version)
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

# Function to handle script exit
exit_script() {
    dialog --clear --backtitle "$BACKTITLE" --title "Exit" --msgbox "Installation cancelled. Exiting..." $HEIGHT $WIDTH

    # Source the USB utils
    source "usb_utils.sh"

    # Unmount the USB drive
    unmount_usb

    # Exit the script
    exit 0
}

# Function to show a yes/no menu
yes_no_menu() {
    local message=$1

    dialog --clear --backtitle "$BACKTITLE" --title "$TITLE" --yesno "$message" $HEIGHT $WIDTH
    return $?
}

# Function to show the welcome screen
welcome_screen() {
    dialog --clear --backtitle "$BACKTITLE" --title "$TITLE" --msgbox "Welcome to $SCRIPT_NAME \nv$VERSION \nby $AUTHOR" $HEIGHT $WIDTH
    
    # If the user cancels, exit the script
    if [ $? -eq 1 ]; then
        exit_script
    fi
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
        --title "$title" \
        --inputbox "$inputbox" \
        $HEIGHT $WIDTH \
        "$default_value" \
        3>&1 1>&2 2>&3)
    
    choices+=("$choice")

    # Return the input
    echo "$input"
}