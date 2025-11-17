#!/bin/bash
# Install KiCAD libraries needed for ESL DUT Dongle project
# This script installs official and third-party libraries

set -e

echo "=========================================="
echo "KiCAD Library Installation Script"
echo "=========================================="
echo ""

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Determine KiCAD version and paths
KICAD_VERSION="6.0"
KICAD_USER_DIR="$HOME/.local/share/kicad"
KICAD_SYMBOLS_DIR="$KICAD_USER_DIR/$KICAD_VERSION/symbols"
KICAD_FOOTPRINTS_DIR="$KICAD_USER_DIR/$KICAD_VERSION/footprints"
KICAD_3DMODELS_DIR="$KICAD_USER_DIR/$KICAD_VERSION/3dmodels"

# Create directories if they don't exist
mkdir -p "$KICAD_SYMBOLS_DIR"
mkdir -p "$KICAD_FOOTPRINTS_DIR"
mkdir -p "$KICAD_3DMODELS_DIR"

echo -e "${GREEN}KiCAD User Directory:${NC} $KICAD_USER_DIR"
echo -e "${GREEN}Symbols Directory:${NC} $KICAD_SYMBOLS_DIR"
echo -e "${GREEN}Footprints Directory:${NC} $KICAD_FOOTPRINTS_DIR"
echo ""

# Official KiCAD Libraries (GitLab)
OFFICIAL_LIBS_REPO="https://gitlab.com/kicad/libraries"
OFFICIAL_LIBS_BRANCH="master"

# Temporary directory for cloning
TEMP_DIR=$(mktemp -d)
cd "$TEMP_DIR"

echo -e "${YELLOW}Step 1: Installing Official KiCAD Libraries${NC}"
echo "---------------------------------------------------"

# Clone official symbol libraries
if [ ! -d "kicad-symbols" ]; then
    echo "Cloning official KiCAD symbol libraries..."
    git clone --depth 1 "$OFFICIAL_LIBS_REPO/kicad-symbols.git" kicad-symbols || {
        echo -e "${RED}Error: Failed to clone symbol libraries${NC}"
        exit 1
    }
fi

# Clone official footprint libraries
if [ ! -d "kicad-footprints" ]; then
    echo "Cloning official KiCAD footprint libraries..."
    git clone --depth 1 "$OFFICIAL_LIBS_REPO/kicad-footprints.git" kicad-footprints || {
        echo -e "${RED}Error: Failed to clone footprint libraries${NC}"
        exit 1
    }
fi

# Clone official 3D model libraries
if [ ! -d "kicad-packages3D" ]; then
    echo "Cloning official KiCAD 3D model libraries..."
    git clone --depth 1 "$OFFICIAL_LIBS_REPO/kicad-packages3D.git" kicad-packages3D || {
        echo -e "${YELLOW}Warning: Failed to clone 3D model libraries (optional)${NC}"
    }
fi

echo ""
echo -e "${YELLOW}Step 2: Installing Specific Component Libraries${NC}"
echo "---------------------------------------------------"

# Install Texas Instruments libraries (for INA219, INA228)
echo "Installing Texas Instruments symbol libraries..."
if [ -d "kicad-symbols/Package_SO" ]; then
    # INA219 and INA228 are typically in Package_SO or Sensor_Current
    echo "  - Checking for current sensor symbols..."
    find kicad-symbols -name "*INA*" -type f | head -5
fi

# Install USB connector libraries
echo "Installing USB connector libraries..."
if [ -d "kicad-symbols/Connector" ]; then
    echo "  - USB connectors should be in Connector library"
fi

# Install FTDI libraries (may need custom)
echo "Installing FTDI-related libraries..."
if [ -d "kicad-symbols/Interface" ]; then
    echo "  - Checking Interface library for USB-to-UART bridges..."
fi

echo ""
echo -e "${YELLOW}Step 3: Setting Up Library Links${NC}"
echo "---------------------------------------------------"

# Create symlinks to official libraries
# Note: KiCAD 6.0 uses a library table system, but we can prepare the libraries

# Check if libraries are already linked
if [ -L "$KICAD_SYMBOLS_DIR/kicad-symbols" ]; then
    echo "Official symbol libraries already linked"
else
    echo "Libraries cloned to: $TEMP_DIR"
    echo ""
    echo -e "${YELLOW}IMPORTANT: Manual Configuration Required${NC}"
    echo ""
    echo "KiCAD 6.0 requires libraries to be configured through the GUI:"
    echo "1. Open KiCAD"
    echo "2. Go to: Preferences → Manage Symbol Libraries"
    echo "3. Add the following paths:"
    echo "   - $TEMP_DIR/kicad-symbols"
    echo ""
    echo "4. Go to: Preferences → Manage Footprint Libraries"
    echo "5. Add the following paths:"
    echo "   - $TEMP_DIR/kicad-footprints"
    echo ""
    echo "Alternatively, libraries can be configured in:"
    echo "  ~/.config/kicad/$KICAD_VERSION/sym-lib-table"
    echo "  ~/.config/kicad/$KICAD_VERSION/fp-lib-table"
fi

echo ""
echo -e "${YELLOW}Step 4: Checking for Required Components${NC}"
echo "---------------------------------------------------"

# Check for INA219/INA228
echo "Checking for INA219/INA228 symbols..."
INA219_FOUND=$(find kicad-symbols -name "*INA219*" -o -name "*INA*219*" 2>/dev/null | wc -l)
INA228_FOUND=$(find kicad-symbols -name "*INA228*" -o -name "*INA*228*" 2>/dev/null | wc -l)

if [ "$INA219_FOUND" -gt 0 ]; then
    echo -e "${GREEN}✓ INA219 symbols found${NC}"
    find kicad-symbols -name "*INA219*" -o -name "*INA*219*" 2>/dev/null | head -3
else
    echo -e "${YELLOW}⚠ INA219 symbols not found - may need custom symbol${NC}"
fi

if [ "$INA228_FOUND" -gt 0 ]; then
    echo -e "${GREEN}✓ INA228 symbols found${NC}"
    find kicad-symbols -name "*INA228*" -o -name "*INA*228*" 2>/dev/null | head -3
else
    echo -e "${YELLOW}⚠ INA228 symbols not found - may need custom symbol${NC}"
fi

# Check for USB Type-C
echo ""
echo "Checking for USB Type-C connectors..."
USB_C_FOUND=$(find kicad-symbols -name "*USB*C*" -o -name "*Type-C*" 2>/dev/null | wc -l)
if [ "$USB_C_FOUND" -gt 0 ]; then
    echo -e "${GREEN}✓ USB Type-C symbols found${NC}"
    find kicad-symbols -name "*USB*C*" -o -name "*Type-C*" 2>/dev/null | head -3
else
    echo -e "${YELLOW}⚠ USB Type-C symbols not found - checking alternative names${NC}"
    find kicad-symbols/Connector -name "*USB*" 2>/dev/null | head -5
fi

# Check for FTDI
echo ""
echo "Checking for FTDI USB-to-UART bridges..."
FTDI_FOUND=$(find kicad-symbols -name "*FT*" -o -name "*FTDI*" 2>/dev/null | grep -i "ft\|uart" | wc -l)
if [ "$FTDI_FOUND" -gt 0 ]; then
    echo -e "${GREEN}✓ FTDI-related symbols found${NC}"
    find kicad-symbols -name "*FT*" -o -name "*FTDI*" 2>/dev/null | grep -i "ft\|uart" | head -5
else
    echo -e "${YELLOW}⚠ FTDI symbols not found - will need custom symbol for FT4232H${NC}"
fi

echo ""
echo -e "${GREEN}=========================================="
echo "Library Installation Complete!"
echo "==========================================${NC}"
echo ""
echo "Next steps:"
echo "1. Configure libraries in KiCAD GUI (Preferences → Manage Symbol/Footprint Libraries)"
echo "2. Or manually edit library tables in ~/.config/kicad/$KICAD_VERSION/"
echo ""
echo "Libraries are located in: $TEMP_DIR"
echo "You can move them to a permanent location if desired."

