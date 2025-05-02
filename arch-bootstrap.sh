#!/bin/bash

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
REPO_URL="https://github.com/ang3lo-azevedo/arch-bootstrap.git"

if [ "$(basename "$PWD")" != "$REPO_DIR" ]; then
    # Only clone if the directory doesn't exist
    if [ ! -d "$REPO_DIR" ]; then
        echo "Cloning the repository"
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

# Run menu as root
sudo su -c menu