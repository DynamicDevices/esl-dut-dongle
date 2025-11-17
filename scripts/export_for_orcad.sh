#!/bin/bash
# Export KiCAD project files in formats compatible with OrCAD
# This script exports netlists, manufacturing files, and documentation

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
PROJECT_DIR="$PROJECT_ROOT/hardware/examples/pcb-design-investigation/kicad-project"
PROJECT_NAME="esl-dut-dongle-example"
EXPORT_DIR="$PROJECT_ROOT/hardware/examples/pcb-design-investigation/exports"

# Create export directories
mkdir -p "$EXPORT_DIR"/{netlists,gerber,drill,bom,documentation}

cd "$PROJECT_DIR"

echo "=========================================="
echo "Exporting KiCAD Project for OrCAD Compatibility"
echo "=========================================="
echo ""

# Check if kicad-cli is available
if ! command -v kicad-cli &> /dev/null; then
    echo "⚠️  kicad-cli not found"
    echo "   Manual export required:"
    echo "   1. Open KiCAD Schematic Editor"
    echo "   2. Tools → Generate Netlist"
    echo "   3. Select format: EDIF"
    echo "   4. Export to: $EXPORT_DIR/netlists/"
    echo ""
    echo "   For PCB:"
    echo "   1. Open KiCAD PCB Editor"
    echo "   2. File → Fabrication Outputs → Gerbers"
    echo "   3. Export to: $EXPORT_DIR/gerber/"
    echo ""
else
    echo "Using kicad-cli for export..."
    echo ""
    
    # Export netlist in EDIF format (best for OrCAD)
    if [ -f "$PROJECT_NAME.kicad_sch" ]; then
        echo "1. Exporting netlist (EDIF format)..."
        kicad-cli sch export netlist \
            --format edif \
            "$PROJECT_NAME.kicad_sch" \
            "$EXPORT_DIR/netlists/$PROJECT_NAME.edf" 2>/dev/null && \
            echo "   ✓ EDIF netlist exported" || \
            echo "   ⚠ EDIF export failed (may need manual export)"
        
        echo ""
        
        # Export SPICE netlist (alternative format)
        echo "2. Exporting netlist (SPICE format)..."
        kicad-cli sch export netlist \
            --format spice \
            "$PROJECT_NAME.kicad_sch" \
            "$EXPORT_DIR/netlists/$PROJECT_NAME.net" 2>/dev/null && \
            echo "   ✓ SPICE netlist exported" || \
            echo "   ⚠ SPICE export failed"
        
        echo ""
    else
        echo "⚠ Schematic file not found: $PROJECT_NAME.kicad_sch"
    fi
    
    # Export Gerber files
    if [ -f "$PROJECT_NAME.kicad_pcb" ]; then
        echo "3. Exporting Gerber files..."
        kicad-cli pcb export gerbers \
            "$PROJECT_NAME.kicad_pcb" \
            "$EXPORT_DIR/gerber/" 2>/dev/null && \
            echo "   ✓ Gerber files exported" || \
            echo "   ⚠ Gerber export failed (may need manual export)"
        
        echo ""
        
        # Export drill files
        echo "4. Exporting drill files..."
        kicad-cli pcb export drill \
            "$PROJECT_NAME.kicad_pcb" \
            "$EXPORT_DIR/drill/" 2>/dev/null && \
            echo "   ✓ Drill files exported" || \
            echo "   ⚠ Drill export failed"
        
        echo ""
    else
        echo "⚠ PCB file not found: $PROJECT_NAME.kicad_pcb"
    fi
fi

# Copy documentation
echo "5. Copying documentation..."
cp "$PROJECT_ROOT/hardware/examples/pcb-design-investigation/schematics/SCHEMATIC_DESIGN.md" \
   "$EXPORT_DIR/documentation/" 2>/dev/null && echo "   ✓ Schematic design doc copied" || echo "   ⚠ Doc not found"

cp "$PROJECT_ROOT/hardware/examples/pcb-design-investigation/schematics/NETLIST.md" \
   "$EXPORT_DIR/documentation/" 2>/dev/null && echo "   ✓ Netlist doc copied" || echo "   ⚠ Doc not found"

cp "$PROJECT_ROOT/hardware/examples/pcb-design-investigation/CUSTOM_SYMBOLS_NEEDED.md" \
   "$EXPORT_DIR/documentation/" 2>/dev/null && echo "   ✓ Custom symbols doc copied" || echo "   ⚠ Doc not found"

echo ""

# Create summary
echo "=========================================="
echo "Export Summary"
echo "=========================================="
echo ""
echo "Exported files location: $EXPORT_DIR"
echo ""
echo "Netlists:"
ls -lh "$EXPORT_DIR/netlists/" 2>/dev/null | tail -n +2 | sed 's/^/  /' || echo "  (none exported yet)"
echo ""
echo "Gerber files:"
ls -lh "$EXPORT_DIR/gerber/" 2>/dev/null | tail -n +2 | sed 's/^/  /' || echo "  (none exported yet)"
echo ""
echo "Drill files:"
ls -lh "$EXPORT_DIR/drill/" 2>/dev/null | tail -n +2 | sed 's/^/  /' || echo "  (none exported yet)"
echo ""
echo "Documentation:"
ls -lh "$EXPORT_DIR/documentation/" 2>/dev/null | tail -n +2 | sed 's/^/  /' || echo "  (none copied yet)"
echo ""
echo "=========================================="
echo "Next Steps for OrCAD Import"
echo "=========================================="
echo ""
echo "1. Import EDIF netlist into OrCAD Capture:"
echo "   File → Import → Netlist"
echo "   Select: $EXPORT_DIR/netlists/$PROJECT_NAME.edf"
echo ""
echo "2. Review documentation:"
echo "   - Component list: CUSTOM_SYMBOLS_NEEDED.md"
echo "   - Pin assignments: SCHEMATIC_DESIGN.md"
echo "   - Netlist: NETLIST.md"
echo ""
echo "3. Recreate custom symbols in OrCAD:"
echo "   - Use documented pin assignments"
echo "   - Reference component datasheets"
echo ""
echo "For detailed instructions, see:"
echo "  docs/development/ORCAD_COMPATIBILITY.md"
echo ""

