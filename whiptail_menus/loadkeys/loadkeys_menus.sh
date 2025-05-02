#!/bin/bash

# Set the directory
dir=$(dirname "$0")

# Source the utils
source "$dir/utils/utils.sh"

# Function to show the loadkeys menu
loadkeys_menu() {
    yes_no_menu "Loadkeys to pt-latin1?"
    if [ $? -eq 0 ]; then
        loadkeys pt-latin1
    fi
}