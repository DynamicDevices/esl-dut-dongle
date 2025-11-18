# Quick Guide: Opening KiCAD Project

## The Problem
KiCAD file dialog may not show files in `/home/ajlennon/data_drive/` because it's a symlink.

## Solution: Use Terminal (Fastest)

```bash
cd /home/ajlennon/data_drive/esl/esl-dut-dongle/hardware/schematics/esl-dut-dongle
kicad esl-dut-dongle.kicad_pro
```

Or use the helper script:
```bash
cd /home/ajlennon/data_drive/esl/esl-dut-dongle
./open_kicad.sh
```

## Alternative: Navigate in File Dialog

1. **Click "Other Locations"** in the left sidebar
2. **Type path directly**: Press Ctrl+L and type:
   ```
   /home/ajlennon/data_drive/esl/esl-dut-dongle/hardware/schematics/esl-dut-dongle
   ```
3. **Select**: `esl-dut-dongle.kicad_pro`

## Project Location
Full path: `/home/ajlennon/data_drive/esl/esl-dut-dongle/hardware/schematics/esl-dut-dongle/esl-dut-dongle.kicad_pro`
