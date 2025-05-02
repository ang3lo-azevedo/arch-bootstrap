#!/bin/bash

# Check if script is being run with sudo
if [ "$EUID" -ne 0 ]; then
    echo "Please run this script with sudo"
    exit 1
fi

# Check if running in interactive terminal
if [ ! -t 1 ]; then
    echo "Script is being run in non-interactive mode. Downloading and executing locally..."
    # Create a temporary directory
    TEMP_DIR=$(mktemp -d)
    cd "$TEMP_DIR" || exit 1
    
    # Download the script
    curl -L arch.azevedos.eu.org -o arch-bootstrap.sh
    
    # Make it executable
    chmod +x arch-bootstrap.sh
    
    # Execute it
    exec ./arch-bootstrap.sh
fi

# Check if git is installed
if ! command -v git &> /dev/null; then
    echo "Git is not installed. Installing git..."
    sudo pacman -Sy
    sudo pacman -S --needed --noconfirm git
else
    echo "Git is already installed."
fi

# Check if already inside the repository directory
REPO_DIR="arch-bootstrap"
REPO_URL="https://github.com/ang3lo-azevedo/arch-bootstrap"

if [ "$(basename "$PWD")" != "$REPO_DIR" ]; then
    # Only clone if the directory doesn't exist
    if [ ! -d "$REPO_DIR" ]; then
        echo "Cloning the repository"
        git config
        git clone "$REPO_URL"
    fi
    cd "$REPO_DIR" || exit
else
    echo "Already inside the $REPO_DIR directory."
fi

# Update the repository
if [ -d .git ]; then
    git pull --recurse-submodules
fi

# Source the menu script
source "whiptail_menus/main_menu.sh"

# Run the menu
menu