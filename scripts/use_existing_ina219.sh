#!/bin/bash
# Extract and use INA219 symbol from Usini Sensors library
# This uses what we already have instead of waiting for SnapEDA download

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
SYMBOL_SOURCES="$PROJECT_ROOT/hardware/examples/pcb-design-investigation/symbol-sources"
PROJECT_SYMBOL_DIR="$PROJECT_ROOT/hardware/examples/pcb-design-investigation/kicad-project/symbols"
PROJECT_FOOTPRINT_DIR="$PROJECT_ROOT/hardware/examples/pcb-design-investigation/kicad-project/footprints"

mkdir -p "$PROJECT_SYMBOL_DIR"
mkdir -p "$PROJECT_FOOTPRINT_DIR"

echo "=========================================="
echo "Using Existing INA219 from GitHub"
echo "=========================================="
echo ""

# Copy INA219 symbol library
if [ -f "$SYMBOL_SOURCES/usini_kicad_sensors/usini_sensors.kicad_sym" ]; then
    echo "1. Copying INA219 symbol library..."
    cp "$SYMBOL_SOURCES/usini_kicad_sensors/usini_sensors.kicad_sym" \
       "$PROJECT_SYMBOL_DIR/usini_sensors.kicad_sym"
    echo "   ✓ Symbol library copied"
    echo "   Location: $PROJECT_SYMBOL_DIR/usini_sensors.kicad_sym"
else
    echo "   ❌ Symbol library not found"
fi

echo ""

# Copy INA219 footprint
if [ -f "$SYMBOL_SOURCES/usini_kicad_sensors/usini_sensors.pretty/module_ina219.kicad_mod" ]; then
    echo "2. Copying INA219 footprint..."
    mkdir -p "$PROJECT_FOOTPRINT_DIR/usini_sensors.pretty"
    cp "$SYMBOL_SOURCES/usini_kicad_sensors/usini_sensors.pretty/module_ina219.kicad_mod" \
       "$PROJECT_FOOTPRINT_DIR/usini_sensors.pretty/"
    echo "   ✓ Footprint copied"
    echo "   Location: $PROJECT_FOOTPRINT_DIR/usini_sensors.pretty/module_ina219.kicad_mod"
else
    echo "   ❌ Footprint not found"
fi

echo ""
echo "=========================================="
echo "Summary"
echo "=========================================="
echo ""
echo "INA219 is now available in your project:"
echo "  Symbol: $PROJECT_SYMBOL_DIR/usini_sensors.kicad_sym"
echo "  Footprint: $PROJECT_FOOTPRINT_DIR/usini_sensors.pretty/module_ina219.kicad_mod"
echo ""
echo "Next steps:"
echo "1. Add symbol library to KiCAD:"
echo "   Preferences → Manage Symbol Libraries"
echo "   Add: $PROJECT_SYMBOL_DIR/usini_sensors.kicad_sym"
echo ""
echo "2. Add footprint library to KiCAD:"
echo "   Preferences → Manage Footprint Libraries"
echo "   Add: $PROJECT_FOOTPRINT_DIR/usini_sensors.pretty"
echo ""
echo "3. Still need to download from SnapEDA:"
echo "   - INA228: Search SnapEDA for 'INA228AIDCNT'"
echo "   - FT4232H: Search SnapEDA for 'FT4232H-56Q'"
echo ""
echo "4. After downloading SnapEDA files, run:"
echo "   ./scripts/organize_snapeda_downloads.sh"
echo ""

