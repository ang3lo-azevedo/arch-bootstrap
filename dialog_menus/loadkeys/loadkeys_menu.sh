#!/bin/bash

# Function to load the pt-latin1 keyboard layout
load_pt_latin1() {
    loadkeys pt-latin1
}

# Function to show the loadkeys menu
loadkeys_menu() {
    # Check if pt-latin1 is loaded
    if ! loadkeys -q pt-latin1; then
        yes_no_menu "Load pt-latin1 keyboard layout?"
        if [ $? -eq 0 ]; then
            load_pt_latin1
        fi
    fi
}