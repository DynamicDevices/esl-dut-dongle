#!/bin/bash
# Create a bind mount for /data_drive in home directory for snap access

if [ "$EUID" -ne 0 ]; then 
    echo "This script needs sudo privileges."
    echo "Run: sudo $0"
    exit 1
fi

BIND_MOUNT="/home/ajlennon/data_drive_bind"

echo "Creating bind mount for snap access..."
echo "Source: /data_drive"
echo "Target: $BIND_MOUNT"

# Create directory if it doesn't exist
mkdir -p "$BIND_MOUNT"

# Create bind mount
mount --bind /data_drive "$BIND_MOUNT"

if [ $? -eq 0 ]; then
    echo "✅ Bind mount created successfully!"
    echo ""
    echo "You can now access /data_drive via:"
    echo "  $BIND_MOUNT/esl/esl-dut-dongle/hardware/schematics/esl-dut-dongle/"
    echo ""
    echo "To make this permanent, add to /etc/fstab:"
    echo "  /data_drive $BIND_MOUNT none bind 0 0"
else
    echo "❌ Failed to create bind mount"
    exit 1
fi
