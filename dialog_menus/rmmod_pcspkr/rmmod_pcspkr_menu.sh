#!/bin/bash

# Function to remove the pcspkr module
rmmod_pcspkr() {
    # Check if pcspkr is loaded
    if lsmod | grep -q pcspkr; then
        rmmod pcspkr
    fi
}

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