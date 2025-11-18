# Granting KiCAD Snap Access to /data_drive

## Problem
KiCAD installed via Snap cannot directly access `/data_drive` because it's at the root level, outside of `/home`.

## Solution: Bind Mount

Create a bind mount in your home directory so snap can access `/data_drive` through the home interface.

## Quick Setup

Run this command:
```bash
sudo /home/ajlennon/data_drive/esl/esl-dut-dongle/grant_snap_access_to_datadrive.sh
```

## What It Does

1. Creates `/home/ajlennon/data_drive_bind` directory
2. Binds `/data_drive` to `/home/ajlennon/data_drive_bind`
3. Adds entry to `/etc/fstab` to make it permanent
4. Sets proper permissions

## After Setup

**In KiCAD file dialog:**
- Navigate to: `/home/ajlennon/data_drive_bind/esl/esl-dut-dongle/hardware/schematics/esl-dut-dongle`
- Or browse: `ajlennon` → `data_drive_bind` → `esl` → `esl-dut-dongle` → `hardware` → `schematics` → `esl-dut-dongle`

**From terminal:**
```bash
cd /home/ajlennon/data_drive_bind/esl/esl-dut-dongle/hardware/schematics/esl-dut-dongle
kicad esl-dut-dongle.kicad_pro
```

## Verify It Works

```bash
ls /home/ajlennon/data_drive_bind/esl/esl-dut-dongle/
```

You should see your project files.
