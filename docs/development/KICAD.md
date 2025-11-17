# KiCAD Workflow

**Last Updated:** 2025-11-17

## Overview

This document covers KiCAD usage for the ESL DUT Dongle hardware design.

**Prerequisites:** KiCAD 9.0+ installed (see `SETUP.md`)

## Command Line Tools

### kicad-cli

**Availability:** KiCAD 7.0+ (included with KiCAD 9.0+)

**PDF Export:**
```bash
export PATH="/snap/bin:$PATH"
kicad-cli sch export pdf <schematic.kicad_sch> -o <output.pdf>
```

**Netlist Export:**
```bash
kicad-cli sch export netlist <schematic.kicad_sch> -o <output.edf> --format edif
```

**Note:** If `kicad-cli` is not found, ensure `/snap/bin` is in your PATH or use `snap run kicad.kicad-cli`.

## Schematic Workflow

1. **Open Project:**
   ```bash
   kicad hardware/schematics/esl-dut-dongle/esl-dut-dongle.kicad_pro
   ```

2. **Edit Schematic:**
   - Add components
   - Wire connections
   - Add net labels
   - Add power symbols

3. **Run ERC:**
   - Tools → Electrical Rules Check
   - Fix any errors

4. **Generate Netlist:**
   - Tools → Generate Netlist
   - Format: EDIF (for OrCAD) or SPICE

## PCB Workflow

1. **Assign Footprints:**
   - Tools → Assign Footprints
   - Select appropriate footprints

2. **Layout PCB:**
   - Place components
   - Route traces
   - Add vias and planes

3. **Run DRC:**
   - Tools → Design Rules Check
   - Fix any violations

4. **Export Gerbers:**
   - File → Plot
   - Select Gerber format
   - Generate drill files

## Export for OrCAD

**PDF Export:**
```bash
export PATH="/snap/bin:$PATH"
kicad-cli sch export pdf <schematic.kicad_sch> -o <output.pdf>
```

**EDIF Netlist:**
- Tools → Generate Netlist → Format: EDIF
- Or use `kicad-cli` command above

**Note:** Custom symbols (FT4232H, INA219) need to be created in OrCAD separately.

## KiCAD MCP Server

For AI-assisted workflow using Cursor:

1. **Install MCP Server:**
   ```bash
   bash scripts/install_kicad_mcp.sh
   ```

2. **Use in Cursor:**
   - MCP server automatically detects KiCAD projects
   - Can read schematics and extract information
   - Useful for automated documentation

See `SETUP.md` for installation details.

## Known Issues

- `kicad --version` may timeout - use `which kicad` or `kicad-cli --version` instead
- System symbols handled automatically by KiCAD 6.0+

## OrCAD Compatibility

- Export EDIF netlist for OrCAD import: `Tools → Generate Netlist → Format: EDIF`
- Gerber files are tool-agnostic (standard format)
- Custom symbols (FT4232H, INA219) need to be recreated in OrCAD
- Pin assignments documented in `docs/requirements/DESIGN_SPEC.md`
