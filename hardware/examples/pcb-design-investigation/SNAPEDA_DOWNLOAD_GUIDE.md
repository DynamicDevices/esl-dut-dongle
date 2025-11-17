# SnapEDA Download Guide - Complete Symbol Set

## Overview

This guide provides step-by-step instructions for downloading all required KiCAD symbols and footprints from SnapEDA.

## Required Components

1. **INA219BIDCNT** - Current monitor (μA range)
2. **INA228AIDCNT** - Current monitor (nA range)  
3. **FT4232H-56Q** - USB-to-Quad-UART bridge

## SnapEDA Account Setup

### Step 1: Create Free Account

1. Visit: https://www.snapeda.com/
2. Click "Sign Up" (top right)
3. Create free account (email required)
4. Verify email if needed

### Step 2: Access Download Pages

## Component Downloads

### 1. INA219BIDCNT

**Direct Link:** https://www.snapeda.com/parts/INA219BIDCNT/Texas%20Instruments/view-part/

**Steps:**
1. Visit the URL above
2. Click "Download" button
3. Select format: **KiCad**
4. Download files:
   - Symbol file (.kicad_sym or .lib)
   - Footprint file (.kicad_mod)
   - 3D model (optional, .step file)

**Save to:** `hardware/examples/pcb-design-investigation/symbol-sources/snapeda/INA219/`

---

### 2. INA228AIDCNT

**Search Link:** https://www.snapeda.com/

**Steps:**
1. Visit SnapEDA
2. Search for: "INA228AIDCNT" or "INA228"
3. Select the correct part (INA228AIDCNT, MSOP-10 package)
4. Click "Download"
5. Select format: **KiCad**
6. Download files:
   - Symbol file (.kicad_sym or .lib)
   - Footprint file (.kicad_mod)
   - 3D model (optional)

**Save to:** `hardware/examples/pcb-design-investigation/symbol-sources/snapeda/INA228/`

**Note:** If INA228AIDCNT not found, try:
- INA228AIDGSR (different package variant)
- INA228 (generic search)

---

### 3. FT4232H-56Q

**Search Link:** https://www.snapeda.com/

**Steps:**
1. Visit SnapEDA
2. Search for: "FT4232H-56Q" or "FT4232H"
3. Select the correct part (FT4232H-56Q, QFN-56 package)
4. Click "Download"
5. Select format: **KiCad**
6. Download files:
   - Symbol file (.kicad_sym or .lib)
   - Footprint file (.kicad_mod)
   - 3D model (optional)

**Save to:** `hardware/examples/pcb-design-investigation/symbol-sources/snapeda/FT4232H/`

**Alternative:** If FT4232H-56Q not found:
- Try "FT4232HQ" (QFN-64 variant, may need modification)
- Check Ultra Librarian: https://app.ultralibrarian.com/
- Search for "FT4232H" on Ultra Librarian

---

## Download Organization

### Directory Structure

After downloading, organize files as follows:

```
symbol-sources/
├── snapeda/
│   ├── INA219/
│   │   ├── INA219BIDCNT.kicad_sym (or .lib)
│   │   ├── INA219BIDCNT.kicad_mod
│   │   └── INA219BIDCNT.step (optional)
│   ├── INA228/
│   │   ├── INA228AIDCNT.kicad_sym (or .lib)
│   │   ├── INA228AIDCNT.kicad_mod
│   │   └── INA228AIDCNT.step (optional)
│   └── FT4232H/
│       ├── FT4232H-56Q.kicad_sym (or .lib)
│       ├── FT4232H-56Q.kicad_mod
│       └── FT4232H-56Q.step (optional)
```

---

## File Format Notes

### KiCAD Symbol Files

SnapEDA may provide symbols in different formats:
- **`.kicad_sym`** - KiCAD 6.0+ format (preferred)
- **`.lib`** - Legacy KiCAD format (still works)

**If you get `.lib` format:**
- Can be imported into KiCAD Symbol Editor
- KiCAD will convert to `.kicad_sym` format

### KiCAD Footprint Files

- **`.kicad_mod`** - KiCAD footprint format
- Should work directly in KiCAD

---

## Verification Checklist

After downloading, verify:

- [ ] INA219BIDCNT symbol file downloaded
- [ ] INA219BIDCNT footprint file downloaded
- [ ] INA228AIDCNT symbol file downloaded
- [ ] INA228AIDCNT footprint file downloaded
- [ ] FT4232H-56Q symbol file downloaded
- [ ] FT4232H-56Q footprint file downloaded
- [ ] All files saved to correct directories
- [ ] File formats are correct (.kicad_sym or .lib, .kicad_mod)

---

## Importing into KiCAD

### Step 1: Copy Files to Project

```bash
cd hardware/examples/pcb-design-investigation/kicad-project
mkdir -p symbols footprints

# Copy INA219
cp ../symbol-sources/snapeda/INA219/*.kicad_sym symbols/ 2>/dev/null || \
cp ../symbol-sources/snapeda/INA219/*.lib symbols/
cp ../symbol-sources/snapeda/INA219/*.kicad_mod footprints/

# Copy INA228
cp ../symbol-sources/snapeda/INA228/*.kicad_sym symbols/ 2>/dev/null || \
cp ../symbol-sources/snapeda/INA228/*.lib symbols/
cp ../symbol-sources/snapeda/INA228/*.kicad_mod footprints/

# Copy FT4232H
cp ../symbol-sources/snapeda/FT4232H/*.kicad_sym symbols/ 2>/dev/null || \
cp ../symbol-sources/snapeda/FT4232H/*.lib symbols/
cp ../symbol-sources/snapeda/FT4232H/*.kicad_mod footprints/
```

### Step 2: Import into KiCAD

**For Symbols:**

1. Open KiCAD Symbol Editor
2. **File → Import Symbol** (for .lib files)
   OR
   **File → Open Library** (for .kicad_sym files)
3. Select downloaded symbol file
4. Save to project library

**For Footprints:**

1. Open KiCAD Footprint Editor
2. **File → Import Footprint**
3. Select downloaded footprint file
4. Save to project footprint library

### Step 3: Add Libraries to Project

1. In Schematic Editor: **Preferences → Manage Symbol Libraries**
2. Add project symbol library: `kicad-project/symbols/`
3. In PCB Editor: **Preferences → Manage Footprint Libraries**
4. Add project footprint library: `kicad-project/footprints/`

---

## Troubleshooting

### Issue: Symbol file format not recognized

**Solution:**
- If `.lib` format, use "Import Symbol" in Symbol Editor
- If `.kicad_sym` format, use "Open Library" in Symbol Editor
- KiCAD will handle conversion automatically

### Issue: Footprint doesn't match package

**Solution:**
- Verify package type matches (MSOP-10, QFN-56)
- Check footprint name matches component
- May need to modify footprint or find alternative

### Issue: Pin assignments don't match datasheet

**Solution:**
- Verify symbol pin numbers match datasheet
- Check pin names are correct
- May need to edit symbol in Symbol Editor

### Issue: Component not found on SnapEDA

**Solution:**
- Try alternative part numbers (e.g., INA228AIDGSR)
- Check Ultra Librarian
- Search manufacturer website for KiCAD files
- Create custom symbol as last resort

---

## Alternative Sources

If SnapEDA doesn't have a component:

### Ultra Librarian
- URL: https://app.ultralibrarian.com/
- Search for component
- Download KiCAD format
- Free account required

### Manufacturer Websites
- Texas Instruments: Check product page for CAD files
- FTDI: Check product page for CAD files

### Community Libraries
- GitHub repositories (already downloaded)
- KiCAD community forums

---

## Quick Reference

| Component | SnapEDA Search | Direct Link |
|-----------|---------------|-------------|
| INA219BIDCNT | "INA219BIDCNT" | https://www.snapeda.com/parts/INA219BIDCNT/Texas%20Instruments/view-part/ |
| INA228AIDCNT | "INA228AIDCNT" | Search SnapEDA |
| FT4232H-56Q | "FT4232H-56Q" | Search SnapEDA |

---

## Next Steps After Download

1. ✅ Download all components from SnapEDA
2. ✅ Organize files in `symbol-sources/snapeda/`
3. ✅ Copy to project directories
4. ✅ Import into KiCAD
5. ✅ Verify pin assignments match datasheets
6. ✅ Test symbols in schematic
7. ✅ Proceed with schematic design

---

## Notes

- SnapEDA requires free account registration
- Downloads are free for basic use
- Some components may require premium account (unlikely for these parts)
- Always verify pin assignments against datasheets
- Keep downloaded files organized for future projects

