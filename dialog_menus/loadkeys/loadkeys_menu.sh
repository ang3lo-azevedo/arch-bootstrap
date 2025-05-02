#!/bin/bash

# Function to show the loadkeys menu
loadkeys_menu() {
    # Check if pt-latin1 is loaded
    if ! loadkeys -q pt-latin1; then
        yes_no_menu "Load pt-latin1 keyboard layout?"
        if [ $? -eq 0 ]; then
            loadkeys pt-latin1
        fi
    fi
}