#!/bin/bash

# Install dependencies
echo "Installing git"
sudo pacman -Sy
sudo pacman -S --needed --noconfirm git

# Clone the repository
echo "Cloning the repository"
git clone https://github.com/ang3lo-azevedo/arch-bootstrap.git

# Change to the repository directory
cd arch-bootstrap

# Get the submodules
git submodule update --init --recursive

# Source utils
source "utils/utils.sh"

# Source menu
source "whiptail_menus/main_menu.sh"

# Run menu
menu