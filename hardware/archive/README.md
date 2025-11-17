# Archived Projects

This directory contains archived example and investigation projects.

## Example Project Archive

**Date:** 2025-11-17  
**Project:** `pcb-design-investigation`  
**Purpose:** Investigation into KiCAD capabilities and design workflow  
**Status:** Complete - Critical design questions answered

### Contents

- KiCAD example project with schematic
- Design decisions documentation
- NETLIST and SCHEMATIC_DESIGN documentation
- Export files for review
- Custom symbols (FT4232H, INA219, INA228)

### Key Outcomes

✅ Verified KiCAD MCP server functionality  
✅ Created automated schematic generation scripts  
✅ Confirmed design decisions (FT4232H, INA219, 0.01Ω shunt)  
✅ Established workflow for PDF/OrCAD exports  
✅ Documented KiCAD library management  

### Archive Files

- `example-project-YYYYMMDD.tar.gz` - Complete archive of example project

### Restoration

To restore the example project:

```bash
cd hardware
tar -xzf archive/example-project-YYYYMMDD.tar.gz
```

## Notes

- Example project served its purpose - investigating capabilities
- Real project will be created in `hardware/schematics/` and `hardware/pcb/`
- All learnings documented in `docs/development/KICAD.md`

