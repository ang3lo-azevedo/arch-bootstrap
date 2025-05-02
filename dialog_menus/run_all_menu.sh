#!/bin/bash

# Source the menu utils
source "dialog_menus/utils/menu_utils.sh"

# Show the run all menu
run_all_menu() {
    yes_no_menu "Run all?"
    if [ $? -eq 0 ]; then
        # Run all
        source "dialog_menus/rmmod_pcspkr/rmmod_pcspkr_menu.sh"
        rmmod_pcspkr

        source "dialog_menus/loadkeys/loadkeys_menu.sh"
        load_pt_latin1

        source "dialog_menus/archinstall/archinstall_menu.sh"
        run_full_archinstall
    fi
    return 0
}