#!/bin/bash

# Set the directory
dir=$(dirname "$0")

# Source the utils
source "$dir/utils/utils.sh"

# Function to show the rmmod pcspkr menu
rmmod_pcspkr_menu() {
    yes_no_menu "Remove pcspkr module?"
    if [ $? -eq 0 ]; then
        rmmod pcspkr
    fi
}