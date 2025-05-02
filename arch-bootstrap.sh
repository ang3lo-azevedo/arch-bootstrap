#!/bin/bash

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function to print colored messages
print_message() {
    local color=$1
    local message=$2
    echo -e "${color}${message}${NC}"
}

# Check if git is installed
if ! command -v git &> /dev/null; then
    print_message "$YELLOW" "Git is not installed. Installing git..."
    while ! sudo pacman -S --needed --noconfirm git; do
        print_message "$YELLOW" "Updating system and retrying git installation..."
        sudo pacman -Sy
    done
    print_message "$GREEN" "Git installed successfully!"
else
    print_message "$GREEN" "Git is already installed."
fi

# Repository information
REPO_DIR="arch-bootstrap"
REPO_URL="https://github.com/ang3lo-azevedo/arch-bootstrap"

print_message "$YELLOW" "Current directory: $PWD"

# Check if already inside the repository directory
if [ "$(basename "$PWD")" != "$REPO_DIR" ]; then
    print_message "$YELLOW" "Not in repository directory. Current directory: $(basename "$PWD")"
    # Only clone if the directory doesn't exist
    if [ ! -d "$REPO_DIR" ]; then
        print_message "$YELLOW" "Cloning the repository..."
        if ! git clone "$REPO_URL" "$REPO_DIR" --recurse-submodules; then
            print_message "$RED" "Failed to clone repository. Please check your internet connection and try again."
            exit 1
        fi
    fi
    print_message "$YELLOW" "Changing to repository directory..."
    if ! cd "$REPO_DIR"; then
        print_message "$RED" "Failed to change to repository directory."
        exit 1
    fi
    print_message "$GREEN" "Successfully changed to repository directory: $PWD"
else
    print_message "$GREEN" "Already inside the $REPO_DIR directory."
fi

# Update the repository
print_message "$YELLOW" "Updating repository..."
if ! git pull --recurse-submodules; then
    print_message "$RED" "Failed to update repository."
    exit 1
fi

# Source the menu script
print_message "$YELLOW" "Looking for menu script at: $PWD/dialog_menus/main_menu.sh"
if [ -f "dialog_menus/main_menu.sh" ]; then
    print_message "$GREEN" "Found menu script. Sourcing it..."
    source "dialog_menus/main_menu.sh"
    # Run the menu
    print_message "$YELLOW" "Running menu..."
    menu
else
    print_message "$RED" "Menu script not found at: $PWD/dialog_menus/main_menu.sh"
    ls -la dialog_menus/
    exit 1
fi