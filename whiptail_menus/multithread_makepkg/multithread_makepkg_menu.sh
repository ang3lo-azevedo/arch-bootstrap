#!/bin/bash

# Set the directory
dir=$(dirname "$0")

# Source the utils
source "$dir/utils/utils.sh"

# Source the menu utils
source "$dir/whiptail_menus/utils/utils.sh"

# Set the variables
multithread_makepkg_menu_message="Enable multithreading in makepkg?"
multithread_makepkg_menu_title="Thread Count"
multithread_makepkg_menu_inputbox="Enter number of threads to use (recommended: number of CPU cores):"

# Function to show the thread count menu
thread_count_menu() {
    thread_count=$(input_menu "multithread_make" "$multithread_makepkg_menu_title" "$multithread_makepkg_menu_inputbox")
}

# Function to show the multithreading menu
multithread_makepkg_menu() {
    yes_no_menu "$multithread_makepkg_menu_message"
    if [ $? -eq 0 ]; then
        thread_count_menu
    fi
}