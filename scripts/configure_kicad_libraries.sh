#!/bin/bash
# Configure KiCAD library tables to use installed libraries
# This script adds the libraries to KiCAD's library tables

set -e

KICAD_VERSION="6.0"
KICAD_CONFIG="$HOME/.config/kicad/$KICAD_VERSION"
LIB_DIR="$HOME/.local/share/kicad/$KICAD_VERSION/libraries"

echo "=========================================="
echo "KiCAD Library Configuration Script"
echo "=========================================="
echo ""

# Create config directory if it doesn't exist
mkdir -p "$KICAD_CONFIG"

# Symbol library table
SYM_LIB_TABLE="$KICAD_CONFIG/sym-lib-table"

echo "Configuring symbol library table..."

# Check if table exists, if not create it
if [ ! -f "$SYM_LIB_TABLE" ]; then
    echo "(sym_lib_table" > "$SYM_LIB_TABLE"
    echo ")" >> "$SYM_LIB_TABLE"
fi

# Check if kicad-symbols is already in the table
if grep -q "kicad-symbols" "$SYM_LIB_TABLE" 2>/dev/null; then
    echo "✓ Official KiCAD symbols already configured"
else
    echo "Adding official KiCAD symbol library..."
    # Add entry before the closing parenthesis
    sed -i '$ i\  (lib (name "kicad-symbols") (type "KiCad") (uri "${KICAD_SYMBOL_DIR}/kicad-symbols") (options "") (descr "Official KiCAD symbol library"))' "$SYM_LIB_TABLE"
    echo "✓ Official KiCAD symbols added"
fi

# Footprint library table
FP_LIB_TABLE="$KICAD_CONFIG/fp-lib-table"

echo ""
echo "Configuring footprint library table..."

# Check if table exists, if not create it
if [ ! -f "$FP_LIB_TABLE" ]; then
    echo "(fp_lib_table" > "$FP_LIB_TABLE"
    echo ")" >> "$FP_LIB_TABLE"
fi

# Check if kicad-footprints is already in the table
if grep -q "kicad-footprints" "$FP_LIB_TABLE" 2>/dev/null; then
    echo "✓ Official KiCAD footprints already configured"
else
    echo "Adding official KiCAD footprint library..."
    # Add entry before the closing parenthesis
    sed -i '$ i\  (lib (name "kicad-footprints") (type "KiCad") (uri "${KICAD_FOOTPRINTS_DIR}/kicad-footprints") (options "") (descr "Official KiCAD footprint library"))' "$FP_LIB_TABLE"
    echo "✓ Official KiCAD footprints added"
fi

echo ""
echo "=========================================="
echo "Library Configuration Complete!"
echo "=========================================="
echo ""
echo "Libraries configured:"
echo "  - Symbol libraries: $LIB_DIR/kicad-symbols"
echo "  - Footprint libraries: $LIB_DIR/kicad-footprints"
echo ""
echo "Note: You may need to restart KiCAD for changes to take effect."
echo ""
echo "To verify, open KiCAD and check:"
echo "  Preferences → Manage Symbol Libraries"
echo "  Preferences → Manage Footprint Libraries"

