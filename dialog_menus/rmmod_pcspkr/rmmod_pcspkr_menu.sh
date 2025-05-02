#!/bin/bash

# Function to show the rmmod pcspkr menu
rmmod_pcspkr_menu() {
    # Check if pcspkr is loaded
    if lsmod | grep -q pcspkr; then
        yes_no_menu "Remove pcspkr module?"
        if [ $? -eq 0 ]; then
            rmmod pcspkr
        fi
    fi
}