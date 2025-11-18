# SnapEDA Download Links

## Direct Links to Download Symbols

### FT4232H - USB-to-Quad-UART Bridge
**Part Number:** FT4232H-56Q-REEL  
**Package:** QFN-56  
**Link:** https://www.snapeda.com/parts/FT4232H-56Q-REEL/FTDI%20Chip/view-part/

### INA219 - Power Monitor (μA range)
**Part Number:** INA219BIDCNT  
**Package:** MSOP-8  
**Link:** https://www.snapeda.com/parts/INA219BIDCNT/Texas%20Instruments/view-part/

### INA228 - Power Monitor (nA range)
**Part Number:** INA228AIDGSR (or INA228AIDCNT)  
**Package:** MSOP-10  
**Link:** https://www.snapeda.com/parts/INA228AIDGSR/Texas%20Instruments/view-part/

**Alternative:** https://www.snapeda.com/parts/INA228AIDCNT/Texas%20Instruments/view-part/

## Download Instructions

1. **Click each link above** (requires free SnapEDA account)
2. **Click "Download" button** on the part page
3. **Select "KiCad" format** from the download options
4. **Extract the downloaded ZIP file**
5. **Copy files to project:**
   - `.kicad_sym` files → `hardware/schematics/esl-dut-dongle/symbols/`
   - `.kicad_mod` files → `hardware/schematics/esl-dut-dongle/footprints/`

## File Organization

After downloading, organize files as:
```
hardware/schematics/esl-dut-dongle/
├── symbols/
│   ├── FT4232H-56Q-REEL.kicad_sym
│   ├── INA219BIDCNT.kicad_sym
│   └── INA228AIDGSR.kicad_sym
└── footprints/
    ├── FT4232H-56Q-REEL.kicad_mod
    ├── INA219BIDCNT.kicad_mod
    └── INA228AIDGSR.kicad_mod
```

## Notes

- SnapEDA requires a free account (sign up if needed)
- Downloads are free for non-commercial use
- Verify pin assignments match datasheets after import
- Add symbols to project's `sym-lib-table` after copying files

