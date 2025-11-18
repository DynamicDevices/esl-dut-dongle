#!/bin/bash
# Grant KiCAD snap access to /data_drive via bind mount

set -e

BIND_MOUNT="/home/ajlennon/data_drive_bind"

echo "=== Granting Snap Access to /data_drive ==="
echo ""

if [ "$EUID" -ne 0 ]; then 
    echo "❌ This script needs sudo privileges."
    echo ""
    echo "Run: sudo $0"
    exit 1
fi

echo "1. Creating bind mount directory..."
mkdir -p "$BIND_MOUNT"
echo "   ✅ Created: $BIND_MOUNT"

echo ""
echo "2. Creating bind mount..."
mount --bind /data_drive "$BIND_MOUNT"
if [ $? -eq 0 ]; then
    echo "   ✅ Bind mount created successfully"
else
    echo "   ❌ Failed to create bind mount"
    exit 1
fi

echo ""
echo "3. Making bind mount permanent..."
if grep -q "$BIND_MOUNT" /etc/fstab; then
    echo "   ⚠️  Already in /etc/fstab"
else
    echo "/data_drive $BIND_MOUNT none bind 0 0" >> /etc/fstab
    echo "   ✅ Added to /etc/fstab (will persist after reboot)"
fi

echo ""
echo "4. Setting permissions..."
chown -R ajlennon:ajlennon "$BIND_MOUNT" 2>/dev/null || true
echo "   ✅ Permissions set"

echo ""
echo "=== Done ==="
echo ""
echo "✅ /data_drive is now accessible via: $BIND_MOUNT"
echo ""
echo "**In KiCAD file dialog:**"
echo "  Navigate to: $BIND_MOUNT/esl/esl-dut-dongle/hardware/schematics/esl-dut-dongle"
echo ""
echo "**Or use terminal:**
echo "  cd $BIND_MOUNT/esl/esl-dut-dongle/hardware/schematics/esl-dut-dongle"
echo "  kicad esl-dut-dongle.kicad_pro"
