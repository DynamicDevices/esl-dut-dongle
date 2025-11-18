#!/bin/bash
# Organize SnapEDA downloads from ~/Downloads to project

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SYMBOLS_DIR="$SCRIPT_DIR/symbols"
FOOTPRINTS_DIR="$SCRIPT_DIR/footprints"
DOWNLOADS_DIR="$HOME/Downloads"

echo "=== Organizing SnapEDA Downloads ==="
echo ""

# Find and extract relevant files
shopt -s nullglob
for file in "$DOWNLOADS_DIR"/*FT4232*.zip "$DOWNLOADS_DIR"/*INA219*.zip "$DOWNLOADS_DIR"/*INA228*.zip; do
    if [ -f "$file" ]; then
        echo "Found: $(basename "$file")"
        
        # Extract to temp directory
        TEMP_DIR=$(mktemp -d)
        unzip -q "$file" -d "$TEMP_DIR"
        
        # Find and copy .kicad_sym files
        find "$TEMP_DIR" -name "*.kicad_sym" -exec cp {} "$SYMBOLS_DIR/" \;
        
        # Find and copy .kicad_mod files
        find "$TEMP_DIR" -name "*.kicad_mod" -exec cp {} "$FOOTPRINTS_DIR/" \;
        
        # Cleanup
        rm -rf "$TEMP_DIR"
        
        echo "  ✓ Extracted symbol and footprint files"
    fi
done

echo ""
echo "=== Summary ==="
echo "Symbols:"
ls -lh "$SYMBOLS_DIR"/*.kicad_sym 2>/dev/null || echo "  No symbols found"
echo ""
echo "Footprints:"
ls -lh "$FOOTPRINTS_DIR"/*.kicad_mod 2>/dev/null || echo "  No footprints found"
