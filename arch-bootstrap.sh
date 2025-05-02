#!/bin/bash

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Script information
SCRIPT_NAME="Arch Bootstrap"
VERSION="0.1.0"
AUTHOR="ang3lo-azevedo"

# Function to print colored messages
print_message() {
    local color=$1
    local message=$2
    echo -e "${color}${message}${NC}"
}

# Function to print help message
print_help() {
    echo "Usage: $0 [OPTIONS]"
    echo "Bootstrap script for Arch Linux configuration"
    echo
    echo "Options:"
    echo "  -h, --help     Show this help message"
    echo "  -v, --version  Show version information"
    echo
    echo "Author: $AUTHOR"
}

# Parse command line arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        -h|--help)
            print_help
            exit 0
            ;;
        -v|--version)
            echo "$SCRIPT_NAME v$VERSION"
            exit 0
            ;;
        *)
            print_message "$RED" "Unknown option: $1"
            print_help
            exit 1
            ;;
    esac
    shift
done

# Check for internet connectivity
if ! ping -c 1 archlinux.org &> /dev/null; then
    print_message "$RED" "No internet connection. Please check your network."
    exit 1
fi

# Check if git is installed
if ! command -v git &> /dev/null; then
    print_message "$YELLOW" "Git is not installed. Installing git..."
    if ! sudo pacman -S --needed --noconfirm git; then
        print_message "$YELLOW" "Updating system and retrying git installation..."
        sudo pacman -Syu
        while ! sudo pacman -S --needed --noconfirm git; do
            print_message "$RED" "Failed to install git. Retrying..."
            sudo pacman -Syu
            sleep 2
        done
    fi
    print_message "$GREEN" "Git installed successfully!"
else
    print_message "$GREEN" "Git is already installed."
fi

# Repository information
REPO_DIR="arch-bootstrap"
REPO_URL="https://github.com/ang3lo-azevedo/arch-bootstrap"

# Check if already inside the repository directory
if [ "$(basename "$PWD")" != "$REPO_DIR" ]; then
    # Only clone if the directory doesn't exist
    if [ ! -d "$REPO_DIR" ]; then
        print_message "$YELLOW" "Cloning the repository..."
        if ! git clone "$REPO_URL" "$REPO_DIR"; then
            print_message "$RED" "Failed to clone repository. Please check your internet connection and try again."
            exit 1
        fi
    fi
    if ! cd "$REPO_DIR"; then
        print_message "$RED" "Failed to change to repository directory."
        exit 1
    fi
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
if [ -f "dialog_menus/main_menu.sh" ]; then
    source "dialog_menus/main_menu.sh"
    # Run the menu
    menu
else
    print_message "$RED" "Menu script not found!"
    exit 1
fi