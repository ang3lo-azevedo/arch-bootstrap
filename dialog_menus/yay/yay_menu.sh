#!/bin/bash

# Function to show the yay menu
yay_menu() {
    yes_no_menu "Install yay?"
    if [ $? -eq 0 ]; then
        choices+=("yay")
    fi
}