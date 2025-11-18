#!/bin/bash
# Script to grant KiCAD snap access to data_drive

echo "=== Granting KiCAD Snap Access to /data_drive ==="
echo ""

# Check if running as root
if [ "$EUID" -ne 0 ]; then 
    echo "This script needs sudo privileges."
    echo "Run: sudo $0"
    exit 1
fi

echo "1. Connecting removable-media interface..."
snap connect kicad:removable-media
if [ $? -eq 0 ]; then
    echo "   ✅ Connected removable-media interface"
else
    echo "   ⚠️  Could not connect removable-media (may not be available)"
fi

echo ""
echo "2. Verifying home interface..."
snap connect kicad:home
echo "   ✅ Home interface connected"

echo ""
echo "3. Checking connections..."
echo "   Current KiCAD snap connections:"
snap connections kicad | grep -E "removable|home"

echo ""
echo "=== Done ==="
echo ""
echo "Note: If /data_drive is not removable storage, you may need to:"
echo "  - Access via /home/ajlennon/data_drive (symlink)"
echo "  - Or create a bind mount in your home directory"
