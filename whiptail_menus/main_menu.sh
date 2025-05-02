#!/bin/bash

dir=$(dirname "$0")

# Source the utils
source "$dir/utils/utils.sh"

# Source the menu utils
source "$dir/whiptail_menus/utils/utils.sh"

# Configuration array for sources and functions
declare -A config=(
    ["multithread_make"]="configs/multithread_make.sh:multithread_make"
    ["parallel_downloads"]="configs/parallel_downloads.sh:parallel_downloads"
    ["nvidia"]="nvidia.sh:install_nvidia"
    ["yay"]="yay.sh:install_yay"
    ["packages"]="packages.sh:install_packages"
)

# Install all menu
install_all_menu() {
    yes_no_menu "Install all packages and configurations?"
    if [ $? -eq 0 ]; then
        choices+=("all")
    fi
}

# Function to show the main menu
menu() {
    install_whiptail

    # Show the welcome screen
    welcome_screen

    # Show the rmmod pcspkr menu
    source "$dir/whiptail_menus/rmmod_pcspkr/rmmod_pcspkr_menu.sh"
    rmmod_pcspkr_menu

    # Show the loadkeys menu
    source "$dir/whiptail_menus/loadkeys/loadkeys_menu.sh"
    loadkeys_menu

    # Show the archinstall menu
    source "$dir/whiptail_menus/archinstall/archinstall_menu.sh"
    archinstall_menu

    # Install all message
    install_all_message

    # If all is not selected, show the menus
    if [ "${choices[@]}" != "all" ]; then
        # Show the multithreading message
        multithread_makepkg_menu

        # Show the pacman parallel downloads message
        pacman_parallel_downloads_menu

        # Show the yay message
        yay_message

        # Show the NVIDIA drivers message
        nvidia_drivers_message

        # Show the customize packages message
        customize_packages_menu
    fi

    # Process selected options
    for choice in "${choices[@]}"; do
        if [ "$choice" = "all" ]; then
            # Execute all configurations
            for key in "${!config[@]}"; do
                IFS=':' read -r source_file function_name <<< "${config[$key]}"
                source "$(dirname "$0")/$source_file"
                if [ "$key" = "multithread_make" ]; then
                    $function_name "$thread_count"
                elif [ "$key" = "parallel_downloads" ]; then
                    $function_name "$parallel_downloads"
                else
                    $function_name
                fi
            done
        else
            # Execute single configuration
            if [ -n "${config[$choice]}" ]; then
                IFS=':' read -r source_file function_name <<< "${config[$choice]}"
                source "$(dirname "$0")/$source_file"
                if [ "$choice" = "multithread_make" ]; then
                    $function_name "$thread_count"
                elif [ "$choice" = "parallel_downloads" ]; then
                    $function_name "$parallel_downloads"
                else
                    $function_name
                fi
            fi
        fi
    done
}