#!/bin/bash
# Copy project to home directory for snap access

HOME_PROJECT_DIR="$HOME/kicad-projects/esl-dut-dongle"
SOURCE_DIR="/home/ajlennon/data_drive/esl/esl-dut-dongle"

echo "Copying project to home directory for snap access..."
echo "Source: $SOURCE_DIR"
echo "Destination: $HOME_PROJECT_DIR"

mkdir -p "$HOME_PROJECT_DIR"

# Copy hardware directory
cp -r "$SOURCE_DIR/hardware" "$HOME_PROJECT_DIR/"

echo ""
echo "✅ Project copied!"
echo ""
echo "Now open in KiCAD:"
echo "  cd $HOME_PROJECT_DIR/hardware/schematics/esl-dut-dongle"
echo "  kicad esl-dut-dongle.kicad_pro"
echo ""
echo "Or navigate in KiCAD to:"
echo "  $HOME_PROJECT_DIR/hardware/schematics/esl-dut-dongle"
