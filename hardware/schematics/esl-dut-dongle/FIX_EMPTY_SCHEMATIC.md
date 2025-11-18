# Fix Empty Schematic Issue

## Problem
Schematic appears empty in KiCAD even though components are defined in the file.

## Root Cause
KiCAD may not be able to:
1. Resolve `${KIPRJMOD}` path variable
2. Load symbol libraries (custom or standard)
3. Display symbols due to view/zoom issues

## Solutions to Try

### 1. Verify Symbol Libraries Load
- Open: **Preferences → Manage Symbol Libraries**
- Check **Project Specific Libraries** tab
- Verify FT4232H, INA219, INA228 are listed
- If missing, add them manually

### 2. Check Standard Libraries
- Go to: **Preferences → Manage Symbol Libraries → Global Libraries**
- Verify these are available:
  - `Device` (for R, C, LED)
  - `Connector` (for connectors)
  - `power` (for power symbols)
- If missing, add them from system libraries

### 3. Reload Libraries
- **Preferences → Manage Symbol Libraries → Reload**
- Or restart KiCAD

### 4. Check View
- Click **"Fit Page"** button (or Ctrl+Home)
- Components are at coordinates like X=1000, Y=1000

### 5. Verify Path Resolution
- Check if `${KIPRJMOD}` resolves correctly
- In KiCAD: **Preferences → Configure Paths**
- Verify `${KIPRJMOD}` is set to project directory

### 6. Check for Errors
- Look for red error messages in KiCAD
- Check if symbols show as "?" (library not found)
- Check Messages panel for library loading errors

## Quick Test
Try placing a component manually:
1. Click **Place Symbol**
2. Search for "R" (resistor from Device library)
3. If this works, standard libraries are OK
4. If not, standard libraries need configuration

## Alternative: Use Absolute Paths
If `${KIPRJMOD}` doesn't work, edit `sym-lib-table` to use absolute paths:
```
(uri "/data_drive/esl/esl-dut-dongle/hardware/schematics/esl-dut-dongle/symbols/FT4232H-56Q-REEL.kicad_sym")
```
