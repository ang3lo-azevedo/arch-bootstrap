#!/bin/bash

# Source the menu utils
source "dialog_menus/utils/menu_utils.sh"

# Configure variables
POSTINSTALL_DIR="archpostinstall/install"

# Configuration array for sources and functions
declare -A config=(
    ["multithread_make"]="$POSTINSTALL_DIR/configs/multithread_make.sh:multithread_make"
    ["parallel_downloads"]="$POSTINSTALL_DIR/configs/parallel_downloads.sh:parallel_downloads"
    ["nvidia"]="$POSTINSTALL_DIR/configs/nvidia/nvidia.sh:install_nvidia"
    ["yay"]="$POSTINSTALL_DIR/packages/yay/yay.sh:install_yay"
    ["packages"]="$POSTINSTALL_DIR/packages.sh:install_packages"
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

# Function to show the menu after chroot
menu_after_chroot() {
    # Show the install all menu
    install_all_menu

    # Show the multithreading menu
    source "$MENU_DIR/multithread_makepkg/multithread_makepkg_menu.sh"
    multithread_makepkg_menu

    # Show the pacman parallel downloads menu
    source "$MENU_DIR/pacman_parallel_downloads/pacman_parallel_downloads_menu.sh"
    pacman_parallel_downloads_menu

    # Show the yay menu
    source "$MENU_DIR/yay/yay_menu.sh"
    yay_menu

    # Show the NVIDIA drivers menu
    source "$MENU_DIR/nvidia_drivers/nvidia_drivers_menu.sh"
    nvidia_drivers_menu

    # Show the customize packages menu
    source "$MENU_DIR/customize_packages/customize_packages_menu.sh"
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

# Function to show the main menu
menu() {
    # Ensure we have a proper tty
    exec < /dev/tty
    exec > /dev/tty

    # Install dialog if not present
    install_package "dialog"

    # Source the USB utils
    source "$MENU_DIR/utils/usb_utils.sh"

    # Mount the USB drive
    mount_usb

    pause "Press any key to continue..."

    # Show the welcome screen
    welcome_screen

    # Show the run all menu
    source "$MENU_DIR/run_all_menu.sh"
    if run_all_menu; then
        exit 0
    fi

    # Show the rmmod pcspkr menu
    source "$MENU_DIR/rmmod_pcspkr/rmmod_pcspkr_menu.sh"
    rmmod_pcspkr_menu

    # Show the loadkeys menu
    source "$MENU_DIR/loadkeys/loadkeys_menu.sh"
    loadkeys_menu

    # Show the archinstall menu
    source "$MENU_DIR/archinstall/archinstall_menu.sh"
    archinstall_menu
}