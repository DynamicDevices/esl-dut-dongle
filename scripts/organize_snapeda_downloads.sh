#!/bin/bash
# Organize SnapEDA downloads into project structure
# Run this script after downloading files from SnapEDA

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
DOWNLOAD_DIR="$PROJECT_ROOT/hardware/examples/pcb-design-investigation/symbol-sources/snapeda"
SYMBOL_DIR="$PROJECT_ROOT/hardware/examples/pcb-design-investigation/kicad-project/symbols"
FOOTPRINT_DIR="$PROJECT_ROOT/hardware/examples/pcb-design-investigation/kicad-project/footprints"

echo "=========================================="
echo "Organizing SnapEDA Downloads"
echo "=========================================="
echo ""

# Create directories
mkdir -p "$DOWNLOAD_DIR"/{INA219,INA228,FT4232H}
mkdir -p "$SYMBOL_DIR"
mkdir -p "$FOOTPRINT_DIR"

echo "Directory structure created:"
echo "  Downloads: $DOWNLOAD_DIR"
echo "  Symbols: $SYMBOL_DIR"
echo "  Footprints: $FOOTPRINT_DIR"
echo ""

# Check for downloaded files
echo "Checking for downloaded files..."
echo ""

# INA219
if [ -d "$DOWNLOAD_DIR/INA219" ] && [ "$(ls -A $DOWNLOAD_DIR/INA219 2>/dev/null)" ]; then
    echo "✓ INA219 files found:"
    ls -lh "$DOWNLOAD_DIR/INA219" | tail -n +2 | sed 's/^/    /'
    
    # Copy symbol
    if find "$DOWNLOAD_DIR/INA219" -name "*.kicad_sym" -o -name "*.lib" | head -1 | grep -q .; then
        SYMBOL_FILE=$(find "$DOWNLOAD_DIR/INA219" -name "*.kicad_sym" -o -name "*.lib" | head -1)
        cp "$SYMBOL_FILE" "$SYMBOL_DIR/INA219BIDCNT.kicad_sym" 2>/dev/null || \
        cp "$SYMBOL_FILE" "$SYMBOL_DIR/INA219BIDCNT.lib"
        echo "    → Copied symbol to project"
    fi
    
    # Copy footprint
    if find "$DOWNLOAD_DIR/INA219" -name "*.kicad_mod" | head -1 | grep -q .; then
        FOOTPRINT_FILE=$(find "$DOWNLOAD_DIR/INA219" -name "*.kicad_mod" | head -1)
        cp "$FOOTPRINT_FILE" "$FOOTPRINT_DIR/INA219BIDCNT.kicad_mod"
        echo "    → Copied footprint to project"
    fi
else
    echo "⚠ INA219 files not found"
    echo "   Expected location: $DOWNLOAD_DIR/INA219/"
    echo "   Download from: https://www.snapeda.com/parts/INA219BIDCNT/Texas%20Instruments/view-part/"
fi

echo ""

# INA228
if [ -d "$DOWNLOAD_DIR/INA228" ] && [ "$(ls -A $DOWNLOAD_DIR/INA228 2>/dev/null)" ]; then
    echo "✓ INA228 files found:"
    ls -lh "$DOWNLOAD_DIR/INA228" | tail -n +2 | sed 's/^/    /'
    
    # Copy symbol
    if find "$DOWNLOAD_DIR/INA228" -name "*.kicad_sym" -o -name "*.lib" | head -1 | grep -q .; then
        SYMBOL_FILE=$(find "$DOWNLOAD_DIR/INA228" -name "*.kicad_sym" -o -name "*.lib" | head -1)
        cp "$SYMBOL_FILE" "$SYMBOL_DIR/INA228AIDCNT.kicad_sym" 2>/dev/null || \
        cp "$SYMBOL_FILE" "$SYMBOL_DIR/INA228AIDCNT.lib"
        echo "    → Copied symbol to project"
    fi
    
    # Copy footprint
    if find "$DOWNLOAD_DIR/INA228" -name "*.kicad_mod" | head -1 | grep -q .; then
        FOOTPRINT_FILE=$(find "$DOWNLOAD_DIR/INA228" -name "*.kicad_mod" | head -1)
        cp "$FOOTPRINT_FILE" "$FOOTPRINT_DIR/INA228AIDCNT.kicad_mod"
        echo "    → Copied footprint to project"
    fi
else
    echo "⚠ INA228 files not found"
    echo "   Expected location: $DOWNLOAD_DIR/INA228/"
    echo "   Search SnapEDA for: INA228AIDCNT"
fi

echo ""

# FT4232H
if [ -d "$DOWNLOAD_DIR/FT4232H" ] && [ "$(ls -A $DOWNLOAD_DIR/FT4232H 2>/dev/null)" ]; then
    echo "✓ FT4232H files found:"
    ls -lh "$DOWNLOAD_DIR/FT4232H" | tail -n +2 | sed 's/^/    /'
    
    # Copy symbol
    if find "$DOWNLOAD_DIR/FT4232H" -name "*.kicad_sym" -o -name "*.lib" | head -1 | grep -q .; then
        SYMBOL_FILE=$(find "$DOWNLOAD_DIR/FT4232H" -name "*.kicad_sym" -o -name "*.lib" | head -1)
        cp "$SYMBOL_FILE" "$SYMBOL_DIR/FT4232H-56Q.kicad_sym" 2>/dev/null || \
        cp "$SYMBOL_FILE" "$SYMBOL_DIR/FT4232H-56Q.lib"
        echo "    → Copied symbol to project"
    fi
    
    # Copy footprint
    if find "$DOWNLOAD_DIR/FT4232H" -name "*.kicad_mod" | head -1 | grep -q .; then
        FOOTPRINT_FILE=$(find "$DOWNLOAD_DIR/FT4232H" -name "*.kicad_mod" | head -1)
        cp "$FOOTPRINT_FILE" "$FOOTPRINT_DIR/FT4232H-56Q.kicad_mod"
        echo "    → Copied footprint to project"
    fi
else
    echo "⚠ FT4232H files not found"
    echo "   Expected location: $DOWNLOAD_DIR/FT4232H/"
    echo "   Search SnapEDA for: FT4232H-56Q"
fi

echo ""
echo "=========================================="
echo "Summary"
echo "=========================================="
echo ""

# Count files
SYMBOL_COUNT=$(find "$SYMBOL_DIR" -name "*.kicad_sym" -o -name "*.lib" 2>/dev/null | wc -l)
FOOTPRINT_COUNT=$(find "$FOOTPRINT_DIR" -name "*.kicad_mod" 2>/dev/null | wc -l)

echo "Symbols in project: $SYMBOL_COUNT"
echo "Footprints in project: $FOOTPRINT_COUNT"
echo ""

if [ "$SYMBOL_COUNT" -ge 3 ] && [ "$FOOTPRINT_COUNT" -ge 3 ]; then
    echo "✅ All components ready!"
    echo ""
    echo "Next steps:"
    echo "1. Open KiCAD Symbol Editor"
    echo "2. Import symbols from: $SYMBOL_DIR"
    echo "3. Open KiCAD Footprint Editor"
    echo "4. Import footprints from: $FOOTPRINT_DIR"
    echo "5. Add libraries to project"
else
    echo "⚠ Some components missing"
    echo ""
    echo "Download missing components from SnapEDA:"
    echo "  - INA219: https://www.snapeda.com/parts/INA219BIDCNT/Texas%20Instruments/view-part/"
    echo "  - INA228: Search SnapEDA for 'INA228AIDCNT'"
    echo "  - FT4232H: Search SnapEDA for 'FT4232H-56Q'"
    echo ""
    echo "Save downloads to:"
    echo "  $DOWNLOAD_DIR/"
fi

echo ""
echo "For detailed instructions, see:"
echo "  hardware/examples/pcb-design-investigation/SNAPEDA_DOWNLOAD_GUIDE.md"

