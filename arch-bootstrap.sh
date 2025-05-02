#!/bin/bash

# Install dependencies
echo "Installing git"
sudo pacman -Sy
sudo pacman -S --needed --noconfirm git

# Clone the repository
echo "Cloning the repository"
git clone https://github.com/ang3lo-azevedo/arch-bootstrap.git

# Change to the repository directory
cd arch-bootstrap || exit

# Update the repository
git pull --recurse-submodules

# Run menu
sudo ./whiptail_menus/main_menu.sh