#!/bin/bash
# Direct script to open KiCAD project - bypasses file dialog

PROJECT_DIR="/home/ajlennon/data_drive/esl/esl-dut-dongle/hardware/schematics/esl-dut-dongle"
PROJECT_FILE="$PROJECT_DIR/esl-dut-dongle.kicad_pro"

echo "Opening KiCAD project..."
echo "Project: $PROJECT_FILE"

# Change to project directory first
cd "$PROJECT_DIR"

# Open KiCAD with the project file
kicad "$PROJECT_FILE" 2>&1 &
