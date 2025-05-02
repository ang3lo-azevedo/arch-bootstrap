#!/bin/bash

# Set the variables
pacman_parallel_downloads_menu_message="Enable parallel downloads in pacman?"
pacman_parallel_downloads_menu_title="Parallel Downloads"
pacman_parallel_downloads_menu_inputbox="Enter the number of parallel downloads (recommended: number of CPU cores):"

# Function to show the downloads count menu
downloads_count_menu() {
    parallel_downloads=$(input_menu "parallel_downloads" "$pacman_parallel_downloads_menu_title" "$pacman_parallel_downloads_menu_inputbox")
}

# Function to show the pacman parallel downloads menu
pacman_parallel_downloads_menu() {
    yes_no_menu "$pacman_parallel_downloads_menu_message"
    downloads_count_menu
}
