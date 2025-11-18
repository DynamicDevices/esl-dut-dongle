#!/bin/bash
# Make the bind mount permanent by adding to /etc/fstab

if [ "$EUID" -ne 0 ]; then 
    echo "This script needs sudo privileges."
    echo "Run: sudo $0"
    exit 1
fi

BIND_MOUNT="/home/ajlennon/data_drive_bind"

# Check if already in fstab
if grep -q "$BIND_MOUNT" /etc/fstab; then
    echo "Bind mount already in /etc/fstab"
else
    echo "Adding bind mount to /etc/fstab..."
    echo "/data_drive $BIND_MOUNT none bind 0 0" >> /etc/fstab
    echo "✅ Added to /etc/fstab"
    echo "The bind mount will persist after reboot"
fi
