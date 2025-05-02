#!/bin/bash

# Function to show the NVIDIA drivers menu
nvidia_drivers_menu() {
    yes_no_menu "Install NVIDIA Drivers?"
    if [ $? -eq 0 ]; then
        choices+=("nvidia")
    fi
}