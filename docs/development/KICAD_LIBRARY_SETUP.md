# KiCAD Library Setup for ESL DUT Dongle Project

## Overview

This document describes the KiCAD libraries installed and configured for the ESL DUT Dongle example project.

## Installed Libraries

### Official KiCAD Libraries

The following official libraries have been installed from the KiCAD GitLab repository:

1. **kicad-symbols** - Official symbol library
   - Location: `~/.local/share/kicad/6.0/libraries/kicad-symbols`
   - Contains: Standard component symbols, connectors, power symbols, etc.

2. **kicad-footprints** - Official footprint library
   - Location: `~/.local/share/kicad/6.0/libraries/kicad-footprints`
   - Contains: Standard component footprints, connector footprints, etc.

3. **kicad-packages3D** - Official 3D model library
   - Location: `~/.local/share/kicad/6.0/libraries/kicad-packages3D`
   - Contains: 3D models for visualization

## Required Components

### Components Needed for ESL DUT Dongle

#### 1. FTDI FT4232H (USB-to-Quad-UART Bridge)
- **Status:** ⚠️ Custom symbol required
- **Reason:** FT4232H is not in standard libraries
- **Action:** Create custom symbol based on FT4232H datasheet
- **Package:** QFN-56
- **Footprint:** May need custom footprint or use standard QFN-56

#### 2. INA219 (Current Monitor - μA Range)
- **Status:** ⚠️ May need custom symbol
- **Reason:** Not found in standard libraries
- **Action:** Check Sensor_Current library or create custom symbol
- **Package:** MSOP-10
- **Footprint:** Standard MSOP-10 footprint available

#### 3. INA228 (Current Monitor - nA Range)
- **Status:** ⚠️ May need custom symbol
- **Reason:** Not found in standard libraries
- **Action:** Check Sensor_Current library or create custom symbol
- **Package:** MSOP-10
- **Footprint:** Standard MSOP-10 footprint available

#### 4. USB Type-C Connector
- **Status:** ⚠️ Check Connector library
- **Action:** Search for USB-C or Type-C connectors in Connector library
- **Footprint:** Standard USB-C receptacle footprint should be available

#### 5. Standard Components
- **Resistors:** ✅ Available in Device library
- **Capacitors:** ✅ Available in Device library
- **Headers:** ✅ Available in Connector library
- **Crystals:** ✅ Available in Device library
- **LEDs:** ✅ Available in Device library

## Library Configuration

### Current Configuration

Libraries are installed at:
```
~/.local/share/kicad/6.0/libraries/
├── kicad-symbols/
├── kicad-footprints/
└── kicad-packages3D/
```

### Adding Libraries to KiCAD

**Method 1: Via KiCAD GUI (Recommended)**

1. Open KiCAD
2. Go to **Preferences → Manage Symbol Libraries**
3. Click **Add** or **Browse Libraries**
4. Add path: `~/.local/share/kicad/6.0/libraries/kicad-symbols`
5. Go to **Preferences → Manage Footprint Libraries**
6. Add path: `~/.local/share/kicad/6.0/libraries/kicad-footprints`

**Method 2: Edit Library Tables Manually**

Edit the library table files:
- Symbol libraries: `~/.config/kicad/6.0/sym-lib-table`
- Footprint libraries: `~/.config/kicad/6.0/fp-lib-table`

Example entry format:
```
(lib (name "kicad-symbols") (type "KiCad") (uri "${KICAD_SYMBOL_DIR}/kicad-symbols") (options "") (descr "Official KiCAD symbol library"))
```

## Custom Symbols Needed

### 1. FT4232H Symbol

**Create custom symbol:**
1. Open KiCAD Symbol Editor
2. Create new symbol: `FT4232H`
3. Add pins based on FT4232H datasheet:
   - USB interface pins (VBUS, D+, D-, GND)
   - 4 UART channels (A, B, C, D)
   - GPIO pins (via MPSSE)
   - I2C pins (SCL, SDA)
   - Power pins (VCC, VCCIO, GND)
   - Clock pins (OSCI, OSCO)
4. Save to project-specific library or global library

**Reference:** FT4232H datasheet pinout

### 2. INA219 Symbol

**Check first:** Search Sensor_Current library for similar current monitor symbols

**If not found, create custom symbol:**
1. Open KiCAD Symbol Editor
2. Create new symbol: `INA219`
3. Add pins:
   - Power: VCC, GND
   - Current sense: IN+, IN-
   - Power monitoring: V+, V-
   - I2C: SCL, SDA
   - Address: A0, A1
   - Alert: ALERT (optional)
4. Save to project library

**Reference:** INA219 datasheet

### 3. INA228 Symbol

**Check first:** Search Sensor_Current library for similar current monitor symbols

**If not found, create custom symbol:**
1. Similar to INA219 but with INA228 pinout
2. May be able to modify INA219 symbol if found
3. Save to project library

**Reference:** INA228 datasheet

## Library Search Strategy

### Finding Components

1. **Search in KiCAD Symbol Editor:**
   - Tools → Find Symbol
   - Search by part number or function

2. **Search in File System:**
   ```bash
   find ~/.local/share/kicad/6.0/libraries/kicad-symbols -name "*INA*"
   find ~/.local/share/kicad/6.0/libraries/kicad-symbols -name "*USB*"
   find ~/.local/share/kicad/6.0/libraries/kicad-symbols -name "*FT*"
   ```

3. **Check Specific Libraries:**
   - `Sensor_Current/` - Current sensors, shunt monitors
   - `Interface/` - USB bridges, UART interfaces
   - `Connector/` - USB connectors, headers
   - `Package_SO/` - Small outline packages

## Installation Script

The library installation script is located at:
```
scripts/install_kicad_libraries.sh
```

**To reinstall libraries:**
```bash
cd /home/ajlennon/data_drive/esl/esl-dut-dongle
./scripts/install_kicad_libraries.sh
```

## Next Steps

1. ✅ Libraries installed
2. ⏳ Configure libraries in KiCAD GUI
3. ⏳ Search for existing symbols (INA219, INA228, USB-C)
4. ⏳ Create custom symbols for missing components (FT4232H)
5. ⏳ Verify footprints are available
6. ⏳ Test symbol placement in schematic

## Resources

- **KiCAD Official Libraries:** https://gitlab.com/kicad/libraries
- **KiCAD Library Documentation:** https://dev-docs.kicad.org/en/libraries/
- **Creating Custom Symbols:** https://docs.kicad.org/7.0/en/eeschema/eeschema.html#creating_custom_symbols
- **FT4232H Datasheet:** FTDI website
- **INA219 Datasheet:** Texas Instruments website
- **INA228 Datasheet:** Texas Instruments website

