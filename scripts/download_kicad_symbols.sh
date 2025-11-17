#!/bin/bash
# Download KiCAD symbols and footprints from online sources
# This script downloads community libraries that may contain the needed symbols

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
DOWNLOAD_DIR="$PROJECT_ROOT/hardware/examples/pcb-design-investigation/symbol-sources"
SYMBOL_DIR="$PROJECT_ROOT/hardware/examples/pcb-design-investigation/kicad-project/symbols"
FOOTPRINT_DIR="$PROJECT_ROOT/hardware/examples/pcb-design-investigation/kicad-project/footprints"

mkdir -p "$DOWNLOAD_DIR"
mkdir -p "$SYMBOL_DIR"
mkdir -p "$FOOTPRINT_DIR"

cd "$DOWNLOAD_DIR"

echo "=========================================="
echo "Downloading KiCAD Symbols and Footprints"
echo "=========================================="
echo ""

# 1. Download Usini Sensors library (contains INA219)
echo "1. Downloading Usini Sensors library (INA219)..."
if [ ! -d "usini_kicad_sensors" ]; then
    git clone --depth 1 https://github.com/usini/usini_kicad_sensors.git
    echo "   ✓ Downloaded"
    
    # Search for INA219
    if find usini_kicad_sensors -name "*INA219*" -o -name "*ina219*" | head -1 | grep -q .; then
        echo "   ✓ Found INA219 files"
        find usini_kicad_sensors -name "*INA219*" -o -name "*ina219*" | head -5
    else
        echo "   ⚠ INA219 not found, but library downloaded"
    fi
else
    echo "   ✓ Already exists"
fi

echo ""

# 2. Download Type-C.pretty (USB-C connectors)
echo "2. Downloading Type-C.pretty (USB-C connectors)..."
if [ ! -d "Type-C.pretty" ]; then
    git clone --depth 1 https://github.com/ai03-2725/Type-C.pretty.git
    echo "   ✓ Downloaded"
    echo "   Available USB-C footprints:"
    ls Type-C.pretty/*.kicad_mod 2>/dev/null | head -5 | sed 's/^/      /'
else
    echo "   ✓ Already exists"
fi

echo ""

# 3. Download Alternate KiCad Library (may have FT4232H or similar)
echo "3. Downloading Alternate KiCad Library (may have FT4232H)..."
if [ ! -d "Alternate-KiCad-Library" ]; then
    git clone --depth 1 https://github.com/DawidCislo/Alternate-KiCad-Library.git
    echo "   ✓ Downloaded"
    
    # Search for FT4232H or similar FTDI parts
    echo "   Searching for FT4232H or similar FTDI parts..."
    if find Alternate-KiCad-Library -type f \( -name "*FT4232*" -o -name "*FT*4232*" -o -name "*ft4232*" \) 2>/dev/null | head -1 | grep -q .; then
        echo "   ✓ Found FT4232H or similar"
        find Alternate-KiCad-Library -type f \( -name "*FT4232*" -o -name "*FT*4232*" -o -name "*ft4232*" \) 2>/dev/null | head -5
    else
        echo "   ⚠ FT4232H not found, searching for other FTDI parts..."
        find Alternate-KiCad-Library -type f -name "*FT*" 2>/dev/null | head -5 | sed 's/^/      /' || echo "      No FTDI parts found"
    fi
else
    echo "   ✓ Already exists"
fi

echo ""

# 4. Download CGrassin's KiCad Parts (may have FT4232H)
echo "4. Downloading CGrassin's KiCad Parts (may have FT4232H)..."
if [ ! -d "kicad_parts" ]; then
    git clone --depth 1 https://github.com/CGrassin/kicad_parts.git
    echo "   ✓ Downloaded"
    
    # Search for FT4232H
    if find kicad_parts -type f \( -name "*FT4232*" -o -name "*ft4232*" \) 2>/dev/null | head -1 | grep -q .; then
        echo "   ✓ Found FT4232H"
        find kicad_parts -type f \( -name "*FT4232*" -o -name "*ft4232*" \) 2>/dev/null | head -5
    else
        echo "   ⚠ FT4232H not found"
    fi
else
    echo "   ✓ Already exists"
fi

echo ""
echo "=========================================="
echo "Download Summary"
echo "=========================================="
echo ""
echo "Downloaded libraries:"
echo "  - Usini Sensors (INA219)"
echo "  - Type-C.pretty (USB-C connectors)"
echo "  - Alternate KiCad Library (FT4232H search)"
echo "  - CGrassin's KiCad Parts (FT4232H search)"
echo ""
echo "Location: $DOWNLOAD_DIR"
echo ""
echo "Next steps:"
echo "1. Check SnapEDA for INA219BIDCNT and INA228 symbols:"
echo "   - INA219: https://www.snapeda.com/parts/INA219BIDCNT/Texas%20Instruments/view-part/"
echo "   - INA228: Search SnapEDA for 'INA228AIDCNT'"
echo ""
echo "2. Search downloaded libraries for components:"
echo "   find $DOWNLOAD_DIR -name '*INA219*'"
echo "   find $DOWNLOAD_DIR -name '*FT4232*'"
echo ""
echo "3. Copy symbols to project library:"
echo "   cp <found_symbol>.kicad_sym $SYMBOL_DIR/"
echo ""
echo "4. Import into KiCAD:"
echo "   - Open KiCAD Symbol Editor"
echo "   - File → Import Symbol"
echo "   - Select downloaded symbol file"
echo ""

