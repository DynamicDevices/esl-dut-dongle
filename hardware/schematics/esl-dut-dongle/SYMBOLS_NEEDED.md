# Custom Symbols Required

## Symbols Needed

1. **FT4232H** - USB-to-Quad-UART Bridge
   - Package: QFN-56
   - Source: SnapEDA (https://www.snapeda.com/)
   - Search: "FT4232H-56Q"

2. **INA219** - Power Monitor (μA range)
   - Package: MSOP-8 or similar
   - Source: SnapEDA or community library
   - Search: "INA219BIDCNT"

3. **INA228** - Power Monitor (nA range)
   - Package: MSOP-10 or similar
   - Source: SnapEDA
   - Search: "INA228AIDGSR" or "INA228AIDCNT"

## Download Instructions

### From SnapEDA:
1. Visit https://www.snapeda.com/
2. Search for each part number
3. Download → Select "KiCad" format
4. Extract symbol (.kicad_sym) and footprint (.kicad_mod) files
5. Copy to project symbols directory

### Symbol Library Setup:
1. Create `symbols/` directory in project
2. Copy downloaded symbols there
3. Add to project's `sym-lib-table`

## Alternative: Create in KiCAD
- Open KiCAD Symbol Editor
- Create new symbol based on datasheet pinout
- Save to project library
