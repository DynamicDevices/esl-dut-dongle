# OrCAD Compatibility Guide

## Overview

**Important:** Michael uses OrCAD for professional PCB design. We need to ensure that materials created in KiCAD can be used in OrCAD in the future.

## Key Requirements

- ✅ KiCAD files must be convertible/usable in OrCAD
- ✅ Component libraries should be compatible or convertible
- ✅ Netlists should be exportable in standard formats
- ✅ Manufacturing files (Gerber, drill) are tool-agnostic
- ✅ Documentation should be tool-independent where possible

## File Format Compatibility

### Schematic Files

| Tool | Format | Extension | OrCAD Compatible? |
|------|--------|-----------|-------------------|
| KiCAD | KiCAD Schematic | `.kicad_sch` | ❌ Direct - Need conversion |
| OrCAD | OrCAD Capture | `.dsn` | ✅ Native |
| **Standard** | **EDIF Netlist** | `.edf` | ✅ **Both support** |
| **Standard** | **SPICE Netlist** | `.net` | ✅ **Both support** |

### PCB Layout Files

| Tool | Format | Extension | OrCAD Compatible? |
|------|--------|-----------|-------------------|
| KiCAD | KiCAD PCB | `.kicad_pcb` | ❌ Direct - Need conversion |
| OrCAD | OrCAD PCB Editor | `.brd` | ✅ Native |
| **Standard** | **Gerber Files** | `.gbr`, `.gbrs` | ✅ **Both generate** |
| **Standard** | **Drill Files** | `.drl`, `.nc` | ✅ **Both generate** |
| **Standard** | **ODB++** | `.tgz` | ✅ **Both support** |

### Component Libraries

| Tool | Format | Extension | Conversion Options |
|------|--------|-----------|-------------------|
| KiCAD | KiCAD Symbol | `.kicad_sym` | Convert to OrCAD library |
| KiCAD | KiCAD Footprint | `.kicad_mod` | Convert to OrCAD footprint |
| OrCAD | OrCAD Library | `.olb` | Native OrCAD format |
| **Standard** | **IPC-2581** | `.xml` | ✅ **Both support** |

## Conversion Strategies

### 1. Netlist-Based Workflow (Recommended)

**Best Practice:** Use standard netlist formats for cross-tool compatibility.

**KiCAD → OrCAD:**
1. Design schematic in KiCAD
2. Export netlist in standard format (EDIF, SPICE, or IPC-D-356)
3. Import netlist into OrCAD Capture
4. OrCAD can then generate PCB layout

**Advantages:**
- ✅ Standard format, tool-agnostic
- ✅ Preserves connectivity information
- ✅ Works for both schematic and PCB

**Netlist Export Formats:**
- **EDIF** - Electronic Design Interchange Format (most compatible)
- **SPICE** - Circuit simulation format
- **IPC-D-356** - Standard netlist format
- **Cadence Allegro** - If OrCAD uses Allegro backend

### 2. Gerber-Based Workflow (For PCB Layout)

**Best Practice:** Use Gerber files for manufacturing and review.

**KiCAD → OrCAD:**
1. Design PCB in KiCAD
2. Export Gerber files (RS-274X format)
3. Export drill files (Excellon format)
4. OrCAD can import Gerber files for review/verification

**Note:** Gerber import is typically read-only in OrCAD (for review), not for editing.

### 3. Library Conversion

**Component Libraries:**

**KiCAD Symbol → OrCAD Library:**
- Manual recreation in OrCAD (most reliable)
- Use conversion tools if available
- Export symbol data to spreadsheet, recreate in OrCAD

**Footprints:**
- Manual recreation recommended (most accurate)
- Use IPC-2581 format if supported
- Export footprint data, recreate in OrCAD

## Best Practices for Cross-Tool Compatibility

### 1. Use Standard Netlist Formats

**Export from KiCAD:**
- Use EDIF format for maximum compatibility
- Include component properties and values
- Verify netlist before exporting

**Import to OrCAD:**
- OrCAD Capture can import EDIF netlists
- Verify component mapping
- Check for missing components

### 2. Document Component Libraries

**Create Library Documentation:**
- List all custom symbols created
- Document pin assignments
- Note package types and footprints
- Create reference tables for easy recreation

**File:** `hardware/examples/pcb-design-investigation/CUSTOM_SYMBOLS_NEEDED.md`

### 3. Use Standard Component Names

**Naming Conventions:**
- Use manufacturer part numbers (e.g., INA219BIDCNT)
- Avoid tool-specific naming
- Include package information (e.g., MSOP-10)

### 4. Export Standard Manufacturing Files

**From KiCAD:**
- Gerber files (RS-274X)
- Drill files (Excellon)
- Pick and place files
- BOM (Bill of Materials)

**These are tool-agnostic and can be used by OrCAD for review.**

### 5. Maintain Design Documentation

**Documentation Should Include:**
- Component list with part numbers
- Netlist (in standard format)
- Pin assignments
- Design decisions
- Schematic block diagrams

**These are tool-independent and useful for OrCAD recreation.**

## KiCAD to OrCAD Conversion Tools

### Available Tools

1. **KiCAD Built-in Export:**
   - File → Export → Netlist
   - Select format: EDIF, SPICE, IPC-D-356
   - Export for OrCAD compatibility

2. **Third-Party Converters:**
   - **KiCAD to OrCAD converters** (may exist, verify compatibility)
   - **Manual conversion** (most reliable)

3. **Standard Format Export:**
   - Use IPC-2581 if supported
   - Use ODB++ for manufacturing data

## Recommended Workflow

### Phase 1: Design in KiCAD (Current)

1. ✅ Create schematic in KiCAD
2. ✅ Create custom symbols in KiCAD
3. ✅ Design PCB layout in KiCAD
4. ✅ Export standard netlist (EDIF format)
5. ✅ Export Gerber files for manufacturing
6. ✅ Generate BOM

### Phase 2: Prepare for OrCAD (Future)

1. **Export Netlist:**
   ```bash
   # In KiCAD Schematic Editor
   Tools → Generate Netlist
   Format: EDIF
   Export: esl-dut-dongle-example.edf
   ```

2. **Document Components:**
   - List all custom symbols
   - Document pin assignments
   - Note package types

3. **Export Manufacturing Files:**
   - Gerber files
   - Drill files
   - Pick and place

4. **Create OrCAD Libraries:**
   - Recreate custom symbols in OrCAD
   - Recreate footprints in OrCAD
   - Use documented pin assignments

### Phase 3: Import to OrCAD

1. **Import Netlist:**
   - Open OrCAD Capture
   - File → Import → Netlist
   - Select EDIF file exported from KiCAD

2. **Map Components:**
   - Verify component mapping
   - Assign OrCAD library parts
   - Check for missing components

3. **PCB Layout:**
   - Import netlist to OrCAD PCB Editor
   - Place components
   - Route traces

## File Organization for Cross-Tool Compatibility

### Recommended Structure

```
hardware/examples/pcb-design-investigation/
├── kicad-project/              # KiCAD native files
│   ├── esl-dut-dongle-example.kicad_pro
│   ├── esl-dut-dongle-example.kicad_sch
│   ├── esl-dut-dongle-example.kicad_pcb
│   ├── symbols/                 # KiCAD symbols
│   └── footprints/             # KiCAD footprints
│
├── exports/                     # Standard format exports
│   ├── netlists/               # EDIF, SPICE netlists
│   │   └── esl-dut-dongle-example.edf
│   ├── gerber/                 # Gerber files
│   ├── drill/                  # Drill files
│   └── bom/                    # Bill of materials
│
├── documentation/               # Tool-independent docs
│   ├── component-list.md       # Component list
│   ├── pin-assignments.md      # Pin assignments
│   ├── netlist.md              # Netlist documentation
│   └── design-decisions.md     # Design decisions
│
└── orcad/                      # OrCAD files (future)
    ├── libraries/              # OrCAD libraries
    └── projects/               # OrCAD projects
```

## Export Scripts

### KiCAD Netlist Export

Create script to export netlist in multiple formats:

```bash
#!/bin/bash
# Export KiCAD netlist in multiple formats for OrCAD compatibility

PROJECT="esl-dut-dongle-example"
EXPORT_DIR="exports/netlists"

mkdir -p "$EXPORT_DIR"

# Export EDIF format (best for OrCAD)
kicad-cli sch export netlist \
    --format edif \
    "$PROJECT.kicad_sch" \
    "$EXPORT_DIR/$PROJECT.edf"

# Export SPICE format (alternative)
kicad-cli sch export netlist \
    --format spice \
    "$PROJECT.kicad_sch" \
    "$EXPORT_DIR/$PROJECT.net"

echo "Netlists exported to $EXPORT_DIR/"
```

## Documentation Requirements

### For OrCAD Compatibility

**Must Document:**
1. **Component List:**
   - Part numbers
   - Package types
   - Values (resistors, capacitors)

2. **Pin Assignments:**
   - All custom symbols
   - Pin numbers and names
   - Pin functions

3. **Netlist:**
   - Standard format export
   - Component connections
   - Net names

4. **Design Decisions:**
   - Component selection rationale
   - Pin assignments
   - Design constraints

**Files:**
- `CUSTOM_SYMBOLS_NEEDED.md` - Symbol documentation
- `SCHEMATIC_DESIGN.md` - Pin assignments
- `NETLIST.md` - Connection documentation

## Notes

- **KiCAD files are not directly editable in OrCAD** - conversion required
- **Standard formats (netlist, Gerber) bridge the gap** - use these
- **Documentation is key** - tool-independent docs help conversion
- **Custom symbols need recreation** - document thoroughly
- **Manufacturing files are tool-agnostic** - Gerber works everywhere

## Resources

- **EDIF Format:** Standard netlist format supported by both tools
- **IPC Standards:** IPC-2581, IPC-D-356 for standard formats
- **OrCAD Documentation:** OrCAD Capture netlist import guide
- **KiCAD Export:** KiCAD netlist export documentation

## Summary

**To ensure OrCAD compatibility:**

1. ✅ Export netlists in standard formats (EDIF, SPICE)
2. ✅ Document all custom symbols thoroughly
3. ✅ Use standard component naming
4. ✅ Export manufacturing files (Gerber, drill)
5. ✅ Maintain tool-independent documentation
6. ✅ Create export scripts for repeatability

**The KiCAD example project serves as:**
- Design exploration and learning
- Documentation source for OrCAD recreation
- Reference for component selection and pin assignments
- Source for standard format exports

