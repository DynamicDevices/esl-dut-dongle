#!/bin/bash
# Check what symbols are available from downloaded sources
# and provide status on what still needs to be downloaded from SnapEDA

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
SYMBOL_SOURCES="$PROJECT_ROOT/hardware/examples/pcb-design-investigation/symbol-sources"
SNAPEDA_DIR="$SYMBOL_SOURCES/snapeda"

echo "=========================================="
echo "Symbol Availability Check"
echo "=========================================="
echo ""

# Check INA219
echo "1. INA219 Status:"
if [ -f "$SYMBOL_SOURCES/usini_kicad_sensors/usini_sensors.kicad_sym" ]; then
    if grep -qi "ina219\|module_ina219" "$SYMBOL_SOURCES/usini_kicad_sensors/usini_sensors.kicad_sym" 2>/dev/null; then
        echo "   ✅ Found in Usini Sensors library (GitHub)"
        echo "   Location: usini_kicad_sensors/usini_sensors.kicad_sym"
    else
        echo "   ⚠️  Usini Sensors library exists but INA219 not found"
    fi
else
    echo "   ❌ Usini Sensors library not found"
fi

if [ -d "$SNAPEDA_DIR/INA219" ] && [ "$(ls -A $SNAPEDA_DIR/INA219 2>/dev/null)" ]; then
    echo "   ✅ Also found in SnapEDA downloads"
    ls -lh "$SNAPEDA_DIR/INA219" | tail -n +2 | sed 's/^/      /'
else
    echo "   ⚠️  Not downloaded from SnapEDA yet"
fi

echo ""

# Check INA228
echo "2. INA228 Status:"
if [ -d "$SNAPEDA_DIR/INA228" ] && [ "$(ls -A $SNAPEDA_DIR/INA228 2>/dev/null)" ]; then
    echo "   ✅ Found in SnapEDA downloads"
    ls -lh "$SNAPEDA_DIR/INA228" | tail -n +2 | sed 's/^/      /'
else
    echo "   ❌ Not downloaded from SnapEDA"
    echo "   Action: Download from https://www.snapeda.com/ (search: INA228AIDCNT)"
fi

echo ""

# Check FT4232H
echo "3. FT4232H Status:"
if [ -d "$SNAPEDA_DIR/FT4232H" ] && [ "$(ls -A $SNAPEDA_DIR/FT4232H 2>/dev/null)" ]; then
    echo "   ✅ Found in SnapEDA downloads"
    ls -lh "$SNAPEDA_DIR/FT4232H" | tail -n +2 | sed 's/^/      /'
else
    echo "   ❌ Not downloaded from SnapEDA"
    echo "   Action: Download from https://www.snapeda.com/ (search: FT4232H-56Q)"
    echo "   Alternative: Check Ultra Librarian: https://app.ultralibrarian.com/"
fi

echo ""
echo "=========================================="
echo "Summary"
echo "=========================================="
echo ""

# Count available
INA219_AVAILABLE=0
INA228_AVAILABLE=0
FT4232H_AVAILABLE=0

if grep -qi "ina219\|module_ina219" "$SYMBOL_SOURCES/usini_kicad_sensors/usini_sensors.kicad_sym" 2>/dev/null || \
   [ -d "$SNAPEDA_DIR/INA219" ] && [ "$(ls -A $SNAPEDA_DIR/INA219 2>/dev/null)" ]; then
    INA219_AVAILABLE=1
fi

if [ -d "$SNAPEDA_DIR/INA228" ] && [ "$(ls -A $SNAPEDA_DIR/INA228 2>/dev/null)" ]; then
    INA228_AVAILABLE=1
fi

if [ -d "$SNAPEDA_DIR/FT4232H" ] && [ "$(ls -A $SNAPEDA_DIR/FT4232H 2>/dev/null)" ]; then
    FT4232H_AVAILABLE=1
fi

TOTAL=$((INA219_AVAILABLE + INA228_AVAILABLE + FT4232H_AVAILABLE))

echo "Available: $TOTAL / 3 components"
echo ""
echo "✅ INA219: $([ $INA219_AVAILABLE -eq 1 ] && echo 'Available' || echo 'Need download')"
echo "❌ INA228: $([ $INA228_AVAILABLE -eq 1 ] && echo 'Available' || echo 'Need download')"
echo "❌ FT4232H: $([ $FT4232H_AVAILABLE -eq 1 ] && echo 'Available' || echo 'Need download')"
echo ""

if [ $TOTAL -lt 3 ]; then
    echo "=========================================="
    echo "Next Steps"
    echo "=========================================="
    echo ""
    echo "Download missing components from SnapEDA:"
    echo ""
    if [ $INA219_AVAILABLE -eq 0 ]; then
        echo "1. INA219:"
        echo "   https://www.snapeda.com/parts/INA219BIDCNT/Texas%20Instruments/view-part/"
        echo "   OR use existing: usini_kicad_sensors/usini_sensors.kicad_sym"
        echo ""
    fi
    if [ $INA228_AVAILABLE -eq 0 ]; then
        echo "2. INA228:"
        echo "   Search SnapEDA for: INA228AIDCNT"
        echo "   https://www.snapeda.com/"
        echo ""
    fi
    if [ $FT4232H_AVAILABLE -eq 0 ]; then
        echo "3. FT4232H:"
        echo "   Search SnapEDA for: FT4232H-56Q"
        echo "   https://www.snapeda.com/"
        echo "   OR check Ultra Librarian: https://app.ultralibrarian.com/"
        echo ""
    fi
    echo "Save downloads to: $SNAPEDA_DIR/"
    echo ""
    echo "After downloading, run:"
    echo "  ./scripts/organize_snapeda_downloads.sh"
fi

