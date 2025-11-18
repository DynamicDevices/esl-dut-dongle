# KiCAD Snap File Access

## Issue
KiCAD installed via Snap has restricted file system access and may not be able to access files outside `/home`.

## Project Location
The project is located at:
```
/data_drive/esl/esl-dut-dongle/hardware/schematics/esl-dut-dongle/
```

## Solutions

### Option 1: Create Symlink (Recommended)
Create a symlink in your home directory:
```bash
ln -s /data_drive/esl/esl-dut-dongle ~/esl-dut-dongle
```

Then open KiCAD:
```bash
kicad ~/esl-dout-dongle/hardware/schematics/esl-dut-dongle/esl-dut-dongle.kicad_pro
```

### Option 2: Open from Project Directory
Navigate to the project directory first:
```bash
cd /home/ajlennon/data_drive/esl/esl-dut-dongle/hardware/schematics/esl-dut-dongle
kicad esl-dut-dongle.kicad_pro
```

### Option 3: Use Helper Script
Run the helper script from the project root:
```bash
cd /home/ajlennon/data_drive/esl/esl-dut-dongle
./open_kicad_project.sh
```

### Option 4: Check Snap Permissions
Verify KiCAD has home directory access:
```bash
snap connections kicad | grep home
```

If `home` interface is not connected, connect it:
```bash
sudo snap connect kicad:home
```

## Opening in KiCAD GUI
1. Launch KiCAD: `kicad` or from applications menu
2. File → Open Project
3. Navigate to: `/home/ajlennon/data_drive/esl/esl-dut-dongle/hardware/schematics/esl-dut-dongle/`
4. Select: `esl-dut-dongle.kicad_pro`

## Troubleshooting
- If files are not visible, check that the path is accessible
- Try opening from terminal to see error messages
- Verify file permissions: `ls -la *.kicad_pro`
