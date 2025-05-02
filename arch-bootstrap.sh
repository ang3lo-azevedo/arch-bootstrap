#!/bin/bash

# Check if git is installed
if ! command -v git &> /dev/null; then
    echo "Git is not installed. Installing git..."
    sudo pacman -S --needed --noconfirm git
    if [ $? -ne 0 ]; then
        while [ $? -ne 0 ]; do
            echo "Failed to install git."
            sudo pacman -Syu
            sudo pacman -S --needed --noconfirm git
        done
    fi
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
        git clone "$REPO_URL" "$REPO_DIR"
    fi
    cd "$REPO_DIR" || exit
else
    echo "Already inside the $REPO_DIR directory."
fi

# Update the repository
git pull --recurse-submodules


# Source the menu script
source "dialog_menus/main_menu.sh"

# Run the menu
menu