#!/bin/bash

dir="$(dirname "$0")"

# Source utils
source "$dir/utils/utils.sh"

# Source menu
source "$dir/whiptail_menus/main_menu.sh"

# Run menu
menu

# Install archpostinstall

# Install dotfiles