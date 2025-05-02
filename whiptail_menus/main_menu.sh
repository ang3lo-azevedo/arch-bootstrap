#!/bin/bash



# Source the menu utils
source "whiptail_menus/utils/menu_utils.sh"

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
        echo "All packages and configurations installed"
        exit 0
    fi
}

# Function to show the main menu
menu() {
    # Install whiptail if not present
    install_whiptail

    # Show the welcome screen
    welcome_screen

    # Show the rmmod pcspkr menu
    source "whiptail_menus/rmmod_pcspkr/rmmod_pcspkr_menu.sh"
    rmmod_pcspkr_menu

    # Show the loadkeys menu
    source "whiptail_menus/loadkeys/loadkeys_menu.sh"
    loadkeys_menu

    # Show the archinstall menu
    source "whiptail_menus/archinstall/archinstall_menu.sh"
    archinstall_menu

    # Install all menu
    install_all_menu

    # Show the multithreading menu
    multithread_makepkg_menu

    # Show the pacman parallel downloads menu
    pacman_parallel_downloads_menu

    # Show the yay menu
    yay_menu

    # Show the NVIDIA drivers menu
    nvidia_drivers_menu

    # Show the customize packages menu
    customize_packages_menu


    # Process selected options
    for choice in "${choices[@]}"; do
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
    done
}

# Run the menu
menu