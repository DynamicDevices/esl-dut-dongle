# SnapEDA Quick Start Guide

## Quick Download Checklist

### Step 1: Create SnapEDA Account (if needed)
- Visit: https://www.snapeda.com/
- Sign up for free account
- Verify email

### Step 2: Download Components

#### INA219BIDCNT
1. Visit: https://www.snapeda.com/parts/INA219BIDCNT/Texas%20Instruments/view-part/
2. Click "Download"
3. Select "KiCad" format
4. Save files to: `symbol-sources/snapeda/INA219/`

#### INA228AIDCNT
1. Visit: https://www.snapeda.com/
2. Search: "INA228AIDCNT"
3. Click "Download" → Select "KiCad"
4. Save files to: `symbol-sources/snapeda/INA228/`

#### FT4232H-56Q
1. Visit: https://www.snapeda.com/
2. Search: "FT4232H-56Q"
3. Click "Download" → Select "KiCad"
4. Save files to: `symbol-sources/snapeda/FT4232H/`

### Step 3: Organize Downloads

Run the organization script:
```bash
cd /home/ajlennon/data_drive/esl/esl-dut-dongle
./scripts/organize_snapeda_downloads.sh
```

This will:
- Check for downloaded files
- Copy symbols to project
- Copy footprints to project
- Show what's missing

### Step 4: Import into KiCAD

1. Open KiCAD Symbol Editor
2. Import symbols from `kicad-project/symbols/`
3. Open KiCAD Footprint Editor
4. Import footprints from `kicad-project/footprints/`
5. Add libraries to project

## Direct Links

| Component | SnapEDA Link |
|-----------|-------------|
| INA219BIDCNT | https://www.snapeda.com/parts/INA219BIDCNT/Texas%20Instruments/view-part/ |
| INA228AIDCNT | Search: "INA228AIDCNT" |
| FT4232H-56Q | Search: "FT4232H-56Q" |

## File Locations

**Download to:**
```
symbol-sources/snapeda/
├── INA219/
├── INA228/
└── FT4232H/
```

**After organization:**
```
kicad-project/
├── symbols/
│   ├── INA219BIDCNT.kicad_sym
│   ├── INA228AIDCNT.kicad_sym
│   └── FT4232H-56Q.kicad_sym
└── footprints/
    ├── INA219BIDCNT.kicad_mod
    ├── INA228AIDCNT.kicad_mod
    └── FT4232H-56Q.kicad_mod
```

## Troubleshooting

**Can't find component?**
- Try alternative part numbers
- Check Ultra Librarian: https://app.ultralibrarian.com/
- Search manufacturer website

**File format issues?**
- `.lib` files: Use "Import Symbol" in KiCAD
- `.kicad_sym` files: Use "Open Library" in KiCAD
- `.kicad_mod` files: Use "Import Footprint" in KiCAD

## Next Steps

After downloading and organizing:
1. ✅ Verify all 3 components downloaded
2. ✅ Run organization script
3. ✅ Import into KiCAD
4. ✅ Verify pin assignments
5. ✅ Start schematic design

