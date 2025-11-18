#!/bin/bash
# Quick script to open KiCAD project

PROJECT_DIR="/home/ajlennon/data_drive/esl/esl-dut-dongle/hardware/schematics/esl-dut-dongle"
PROJECT_FILE="$PROJECT_DIR/esl-dut-dongle.kicad_pro"

echo "Opening KiCAD project..."
echo "Project: $PROJECT_FILE"

cd "$PROJECT_DIR"
kicad esl-dut-dongle.kicad_pro
