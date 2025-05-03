#!/bin/bash

# Get the directory where the script is located
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
PROJECT_ROOT="$(dirname "$(dirname "$SCRIPT_DIR")")"

# Source the bash utils
source "$PROJECT_ROOT/bash-utils/utils.sh"

# Set the variables
USB_DRIVE="/dev/sdb3"
MOUNT_POINT="/mnt/usb"
LUKS_MAPPER="usb_luks"

# Function to mount the USB drive
mount_usb() {
    # Check if the USB drive exists
    if [ ! -b "$USB_DRIVE" ]; then
        print_error "USB drive not found"
        return 1
    fi

    # Check if the USB drive is mounted
    if is_usb_mounted; then
        print_success "USB drive already mounted at $MOUNT_POINT"
        return
    fi

    # Create the mount point
    sudo mkdir -p "$MOUNT_POINT"

    # Open the LUKS container
    sudo cryptsetup luksOpen "$USB_DRIVE" "$LUKS_MAPPER"
    
    # Mount the decrypted device
    sudo mount "/dev/mapper/$LUKS_MAPPER" "$MOUNT_POINT"
    
    print_success "USB drive mounted at $MOUNT_POINT"
}

# Function to unmount the USB drive
unmount_usb() {
    # Unmount the device
    sudo umount "$MOUNT_POINT"
    
    # Close the LUKS container
    sudo cryptsetup luksClose "$LUKS_MAPPER"
    
    print_success "USB drive unmounted and LUKS container closed"
}

# Function to check if the USB drive is mounted
is_usb_mounted() {
    return "$(mountpoint -q "$MOUNT_POINT")"
}