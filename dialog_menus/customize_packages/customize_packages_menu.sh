#!/bin/bash

# Function to show the customize packages menu
customize_packages_menu() {
    yes_no_menu "Customize packages?"
    if [ $? -eq 0 ]; then
        choices+=("customize_packages")
    fi
}