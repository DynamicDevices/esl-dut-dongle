#!/bin/bash
# Export KiCAD Schematic to PDF using kicad-cli
# Requires KiCAD 9.0+ (kicad-cli)

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
PROJECT_DIR="$PROJECT_ROOT/hardware/examples/pcb-design-investigation/kicad-project"
SCHEMATIC_FILE="$PROJECT_DIR/esl-dut-dongle-example.kicad_sch"
PDF_OUTPUT="$PROJECT_DIR/exports-for-michael/esl-dut-dongle-example.pdf"

# Ensure snap bin is in PATH
export PATH="/snap/bin:$PATH"

echo "=== Exporting KiCAD Schematic to PDF ==="
echo ""

# Check if kicad-cli is available
if ! command -v kicad-cli &> /dev/null; then
    echo "❌ Error: kicad-cli not found"
    echo ""
    echo "Please ensure:"
    echo "1. KiCAD 9.0+ is installed (via snap: sudo snap install kicad)"
    echo "2. /snap/bin is in your PATH"
    echo ""
    echo "Current PATH: $PATH"
    exit 1
fi

# Check version
echo "✅ Found kicad-cli:"
kicad-cli --version 2>&1 | head -3
echo ""

# Check if schematic exists
if [ ! -f "$SCHEMATIC_FILE" ]; then
    echo "❌ Error: Schematic file not found: $SCHEMATIC_FILE"
    exit 1
fi

# Create output directory
mkdir -p "$(dirname "$PDF_OUTPUT")"

# Export PDF
echo "📄 Schematic: $SCHEMATIC_FILE"
echo "📄 Output: $PDF_OUTPUT"
echo ""
echo "Exporting PDF..."

if kicad-cli sch export pdf "$SCHEMATIC_FILE" -o "$PDF_OUTPUT" 2>&1; then
    echo ""
    echo "✅ PDF exported successfully!"
    echo "   Location: $PDF_OUTPUT"
    ls -lh "$PDF_OUTPUT"
    exit 0
else
    echo ""
    echo "❌ PDF export failed"
    exit 1
fi

