#!/bin/bash
# KiCAD MCP Server Installation Script
# This script installs the KiCAD MCP server for use with Cursor

set -e

echo "KiCAD MCP Server Installation"
echo "=============================="
echo ""

# Check for Python 3.10 (preferred) or fall back to python3
if command -v python3.10 &> /dev/null; then
    PYTHON_CMD="python3.10"
    PYTHON_VERSION=$(python3.10 --version 2>&1 | awk '{print $2}')
    echo "✅ Found Python 3.10: $PYTHON_VERSION"
elif command -v python3 &> /dev/null; then
    PYTHON_CMD="python3"
    PYTHON_VERSION=$(python3 --version 2>&1 | awk '{print $2}' | cut -d. -f1,2)
    PYTHON_MAJOR=$(echo $PYTHON_VERSION | cut -d. -f1)
    PYTHON_MINOR=$(echo $PYTHON_VERSION | cut -d. -f2)
    
    if [ "$PYTHON_MAJOR" -lt 3 ] || ([ "$PYTHON_MAJOR" -eq 3 ] && [ "$PYTHON_MINOR" -lt 10 ]); then
        echo "⚠️  WARNING: Python 3.10+ required, but found Python $PYTHON_VERSION"
        echo "   Trying to use python3.10 explicitly..."
        if command -v python3.10 &> /dev/null; then
            PYTHON_CMD="python3.10"
            PYTHON_VERSION=$(python3.10 --version 2>&1 | awk '{print $2}')
            echo "✅ Using Python 3.10: $PYTHON_VERSION"
        else
            echo "❌ Python 3.10 not found. Please install it first:"
            echo "   sudo apt-get install python3.10 python3.10-venv python3.10-dev"
            exit 1
        fi
    else
        echo "✅ Python version: $PYTHON_VERSION"
    fi
else
    echo "❌ Python not found!"
    exit 1
fi

# Check for make
if command -v make &> /dev/null; then
    echo "✅ make is available"
else
    echo "❌ make not found. Install with: sudo apt-get install build-essential"
    exit 1
fi

# Install uv if not present
if command -v uv &> /dev/null; then
    echo "✅ uv is already installed"
    UV_VERSION=$(uv --version)
    echo "   Version: $UV_VERSION"
else
    echo "Installing uv..."
    pipx install uv || pip install uv
    if command -v uv &> /dev/null; then
        echo "✅ uv installed successfully"
    else
        echo "❌ Failed to install uv"
        echo "   Try manually: pipx install uv or pip install uv"
        exit 1
    fi
fi

# Determine installation directory
INSTALL_DIR="${HOME}/tools/kicad-mcp"
if [ -n "$1" ]; then
    INSTALL_DIR="$1"
fi

echo ""
echo "Installation directory: $INSTALL_DIR"
read -p "Continue with installation? (y/n) " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    exit 1
fi

# Create directory if it doesn't exist
mkdir -p "$(dirname "$INSTALL_DIR")"

# Clone repository
if [ -d "$INSTALL_DIR" ]; then
    echo "Directory exists. Updating..."
    cd "$INSTALL_DIR"
    git pull || echo "Warning: Could not update repository"
else
    echo "Cloning KiCAD MCP repository..."
    git clone https://github.com/lamaalrajih/kicad-mcp.git "$INSTALL_DIR"
fi

cd "$INSTALL_DIR"

# Install dependencies
echo ""
echo "Installing dependencies using $PYTHON_CMD..."
if command -v make &> /dev/null; then
    # Try to use Python 3.10 for make install
    PYTHON=$PYTHON_CMD make install || {
        echo "make install failed, trying manual installation with $PYTHON_CMD..."
        $PYTHON_CMD -m venv .venv || uv venv
        source .venv/bin/activate
        pip install -r requirements.txt || uv pip install -r requirements.txt
    }
else
    echo "Using manual installation (make not available)..."
    $PYTHON_CMD -m venv .venv || uv venv
    source .venv/bin/activate
    pip install -r requirements.txt || uv pip install -r requirements.txt
fi

# Create .env file
if [ ! -f .env ]; then
    echo ""
    echo "Creating .env file..."
    if [ -f .env.example ]; then
        cp .env.example .env
    else
        cat > .env << EOF
# KiCAD Project Search Paths (comma-separated)
KICAD_SEARCH_PATHS=${HOME}/data_drive/esl/esl-dut-dongle/hardware/schematics,${HOME}/data_drive/esl/esl-dut-dongle/hardware/examples
EOF
    fi
    
    echo ""
    echo "📝 Edit .env file to add your KiCAD project paths:"
    echo "   nano $INSTALL_DIR/.env"
    echo ""
    echo "   Add paths like:"
    echo "   KICAD_SEARCH_PATHS=/path/to/project1,/path/to/project2"
fi

# Get absolute path
INSTALL_DIR_ABS=$(cd "$INSTALL_DIR" && pwd)
PYTHON_PATH="$INSTALL_DIR_ABS/.venv/bin/python"
MAIN_PATH="$INSTALL_DIR_ABS/main.py"

# Verify Python version in venv
if [ -f "$PYTHON_PATH" ]; then
    VENV_PYTHON_VERSION=$($PYTHON_PATH --version 2>&1 | awk '{print $2}')
    echo "✅ Virtual environment Python version: $VENV_PYTHON_VERSION"
fi

echo ""
echo "✅ Installation complete!"
echo ""
echo "Next steps:"
echo "==========="
echo ""
echo "1. Edit .env file to add your project paths:"
echo "   nano $INSTALL_DIR_ABS/.env"
echo ""
echo "2. Configure Cursor MCP (create/edit ~/.config/Cursor/mcp.json):"
echo ""
cat << EOF
{
  "mcpServers": {
    "kicad": {
      "command": "$PYTHON_PATH",
      "args": [
        "$MAIN_PATH"
      ],
      "env": {
        "KICAD_SEARCH_PATHS": "${HOME}/data_drive/esl/esl-dut-dongle/hardware/schematics,${HOME}/data_drive/esl/esl-dut-dongle/hardware/examples"
      }
    }
  }
}
EOF
echo ""
echo "3. Restart Cursor to load the MCP server"
echo ""
echo "4. Test the server:"
echo "   cd $INSTALL_DIR_ABS"
echo "   source .venv/bin/activate"
echo "   python main.py"
echo ""

