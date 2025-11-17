# Download KiCAD Symbols from Online Sources

## Overview

This guide provides direct links and instructions for downloading KiCAD symbols and footprints for the required components from online sources.

## Component Sources

### 1. INA219 ⭐ **AVAILABLE ONLINE**

**Option A: SnapEDA (Recommended)**
- **URL:** https://www.snapeda.com/parts/INA219BIDCNT/Texas%20Instruments/view-part/
- **Part:** INA219BIDCNT (MSOP-10 package)
- **Format:** KiCAD symbol and footprint
- **Steps:**
  1. Visit the URL
  2. Click "Download" → Select "KiCad" format
  3. Download symbol (.kicad_sym) and footprint files
  4. Import into KiCAD

**Option B: Usini Sensors GitHub Repository**
- **Repository:** https://github.com/usini/usini_kicad_sensors
- **Contains:** INA219 symbol and footprint
- **Steps:**
  1. Clone repository: `git clone https://github.com/usini/usini_kicad_sensors.git`
  2. Copy symbol file to your project library
  3. Add library to KiCAD

**Option C: KiCAD Analog_ADC Library**
- **Check:** May have INA219AxD variants
- **Location:** Already installed in `~/.local/share/kicad/6.0/libraries/kicad-symbols/Analog_ADC.kicad_sym`
- **Action:** Search for "INA219" in KiCAD Symbol Editor

---

### 2. INA228 ⚠️ **CHECK ONLINE SOURCES**

**Option A: SnapEDA**
- **URL:** https://www.snapeda.com/parts/INA228EVM/Texas%20Instruments/view-part/
- **Note:** This is for INA228EVM (evaluation module), may need to check for INA228AIDCNT
- **Steps:**
  1. Visit SnapEDA
  2. Search for "INA228AIDCNT" or "INA228"
  3. Download KiCAD format if available

**Option B: Texas Instruments**
- **Check:** TI may provide KiCAD symbols on their website
- **Action:** Search TI website for INA228 KiCAD files

**Option C: Modify INA219 Symbol**
- **If INA228 not found:** Create INA228 by modifying INA219 symbol
- **Reason:** Similar pinout, just different part number

---

### 3. FT4232H ⚠️ **MAY NEED CUSTOM OR COMMUNITY LIBRARY**

**Option A: Ultra Librarian**
- **URL:** https://app.ultralibrarian.com/details/6574a67e-a974-11e9-ab3a-0a3560a4cccc/FTDI-Future-Technology-Devices-International-Ltd/FT4232HQ-REEL
- **Note:** This is FT4232HQ-REEL (QFN-64), we need FT4232H-56Q (QFN-56)
- **Action:** Check if QFN-56 variant available, or modify QFN-64 symbol

**Option B: Community Libraries**
- **Alternate KiCad Library:** https://github.com/DawidCislo/Alternate-KiCad-Library
- **CGrassin's KiCad Parts:** https://github.com/CGrassin/kicad_parts
- **Steps:**
  1. Clone repositories
  2. Search for FT4232H or similar FTDI parts
  3. Use if found, or modify similar FTDI symbol

**Option C: Create Custom Symbol**
- **If not found:** Create custom symbol based on FT4232H datasheet
- **Reference:** Pin assignments in `schematics/SCHEMATIC_DESIGN.md`

---

### 4. USB Type-C Connector ✅ **AVAILABLE ONLINE**

**Type-C.pretty GitHub Repository**
- **Repository:** https://github.com/ai03-2725/Type-C.pretty
- **Contains:** Various USB Type-C connector footprints
- **Steps:**
  1. Clone: `git clone https://github.com/ai03-2725/Type-C.pretty.git`
  2. Add footprint library to KiCAD
  3. Search for appropriate USB-C receptacle footprint

---

## Download and Installation Script

Creating a script to automate downloading these libraries:

```bash
#!/bin/bash
# Download KiCAD symbols and footprints from online sources

SYMBOL_DIR="$HOME/.local/share/kicad/6.0/symbols"
FOOTPRINT_DIR="$HOME/.local/share/kicad/6.0/footprints"
PROJECT_DIR="$(pwd)/kicad-project/symbols"

mkdir -p "$SYMBOL_DIR"
mkdir -p "$FOOTPRINT_DIR"
mkdir -p "$PROJECT_DIR"

echo "Downloading KiCAD symbols and footprints..."
echo ""

# Download Usini Sensors library (contains INA219)
echo "1. Downloading Usini Sensors library (INA219)..."
if [ ! -d "usini_kicad_sensors" ]; then
    git clone https://github.com/usini/usini_kicad_sensors.git
    echo "   ✓ Downloaded"
else
    echo "   ✓ Already exists"
fi

# Download Type-C.pretty (USB-C connectors)
echo "2. Downloading Type-C.pretty (USB-C connectors)..."
if [ ! -d "Type-C.pretty" ]; then
    git clone https://github.com/ai03-2725/Type-C.pretty.git
    echo "   ✓ Downloaded"
else
    echo "   ✓ Already exists"
fi

# Download Alternate KiCad Library (may have FT4232H)
echo "3. Downloading Alternate KiCad Library (may have FT4232H)..."
if [ ! -d "Alternate-KiCad-Library" ]; then
    git clone https://github.com/DawidCislo/Alternate-KiCad-Library.git
    echo "   ✓ Downloaded"
else
    echo "   ✓ Already exists"
fi

echo ""
echo "Download complete!"
echo ""
echo "Next steps:"
echo "1. Check SnapEDA for INA219BIDCNT and INA228 symbols"
echo "2. Import symbols into KiCAD"
echo "3. Add footprint libraries to KiCAD"
```

---

## Manual Download Steps

### For SnapEDA Components:

1. **INA219BIDCNT:**
   - Visit: https://www.snapeda.com/parts/INA219BIDCNT/Texas%20Instruments/view-part/
   - Click "Download"
   - Select "KiCad" format
   - Download symbol (.kicad_sym) and footprint files
   - Save to project library

2. **INA228:**
   - Visit SnapEDA: https://www.snapeda.com/
   - Search for "INA228AIDCNT" or "INA228"
   - Download KiCAD format if available

### For GitHub Repositories:

1. **Clone repositories:**
   ```bash
   git clone https://github.com/usini/usini_kicad_sensors.git
   git clone https://github.com/ai03-2725/Type-C.pretty.git
   git clone https://github.com/DawidCislo/Alternate-KiCad-Library.git
   ```

2. **Search for components:**
   ```bash
   # Search for INA219
   find usini_kicad_sensors -name "*INA219*"
   
   # Search for FT4232H or similar FTDI parts
   find Alternate-KiCad-Library -name "*FT*" -o -name "*4232*"
   
   # List USB-C footprints
   ls Type-C.pretty/
   ```

3. **Copy to project library:**
   ```bash
   # Copy INA219 symbol (if found)
   cp usini_kicad_sensors/INA219.kicad_sym kicad-project/symbols/
   
   # Copy USB-C footprints
   cp -r Type-C.pretty kicad-project/footprints/
   ```

---

## Importing into KiCAD

### For Symbols:

1. **Open KiCAD Symbol Editor:**
   - Tools → Symbol Editor

2. **Create or Select Library:**
   - File → New Library (or select existing)
   - Save to: `kicad-project/symbols/`

3. **Import Symbol:**
   - File → Import Symbol
   - Select downloaded .kicad_sym file
   - Save to library

4. **Add Library to Project:**
   - In Schematic Editor: Preferences → Manage Symbol Libraries
   - Add library: `kicad-project/symbols/`

### For Footprints:

1. **Open KiCAD Footprint Editor:**
   - Tools → Footprint Editor

2. **Import Footprint:**
   - File → Import Footprint
   - Select downloaded .kicad_mod file
   - Save to library

3. **Add Footprint Library:**
   - Preferences → Manage Footprint Libraries
   - Add library path

---

## Verification Checklist

After downloading and importing:

- [ ] INA219 symbol available in KiCAD Symbol Editor
- [ ] INA219 footprint available (MSOP-10)
- [ ] INA228 symbol available (or INA219 modified)
- [ ] INA228 footprint available (MSOP-10)
- [ ] FT4232H symbol available (or custom created)
- [ ] FT4232H footprint available (QFN-56)
- [ ] USB Type-C connector footprint available
- [ ] All symbols have correct pin assignments
- [ ] All footprints match component packages

---

## Quick Links Summary

| Component | Source | URL |
|-----------|--------|-----|
| INA219 | SnapEDA | https://www.snapeda.com/parts/INA219BIDCNT/Texas%20Instruments/view-part/ |
| INA219 | GitHub | https://github.com/usini/usini_kicad_sensors |
| INA228 | SnapEDA | Search for "INA228AIDCNT" |
| FT4232H | Ultra Librarian | https://app.ultralibrarian.com/details/6574a67e-a974-11e9-ab3a-0a3560a4cccc/FTDI-Future-Technology-Devices-International-Ltd/FT4232HQ-REEL |
| FT4232H | GitHub | https://github.com/DawidCislo/Alternate-KiCad-Library |
| USB-C | GitHub | https://github.com/ai03-2725/Type-C.pretty |

---

## Next Steps

1. **Download symbols** from SnapEDA (INA219, INA228)
2. **Clone GitHub repositories** (Usini Sensors, Type-C.pretty, Alternate Library)
3. **Search for FT4232H** in community libraries
4. **Import into KiCAD** project library
5. **Verify pin assignments** match datasheets
6. **Test in schematic** before proceeding

---

## Notes

- **SnapEDA:** Requires free account registration for downloads
- **GitHub repositories:** Free, open source
- **Ultra Librarian:** May require account registration
- **Always verify:** Check pin assignments against datasheets before using
- **Package variants:** Ensure package matches (QFN-56 vs QFN-64, MSOP-10, etc.)

