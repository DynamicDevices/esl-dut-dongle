# KiCAD MCP Server Installation Guide

This guide explains how to install and configure the KiCAD Model Context Protocol (MCP) server for use with Cursor.

## Overview

The KiCAD MCP server allows AI assistants to interact with KiCAD projects through natural language commands. This enables:
- Creating and managing KiCAD schematics
- Adding components and connections
- Exporting schematics
- Managing projects

## Prerequisites

- **Operating System:** Linux, macOS, or Windows
- **Python:** Version 3.10 or higher ⚠️ **Note:** Your system has Python 3.8.5 - may need upgrade
- **KiCAD:** Version 6.0+ ✅ (you have 6.0.2 installed)
- **`uv`:** Version 0.8.0 or higher (Python package installer) ⚠️ **Not installed yet**
- **`make`:** ✅ Available on your system
- **Git:** For cloning the repository
- **Cursor:** With MCP support enabled

## Installation Steps

### Step 1: Install `uv` (Python Package Manager)

**Linux (Ubuntu/Debian):**
```bash
# Install uv using pipx (recommended)
pipx install uv

# Or install using pip
pip install uv
```

**macOS:**
```bash
brew install uv
```

**Windows:**
```bash
pip install uv
```

**Verify Installation:**
```bash
uv --version
# Should show version 0.8.0 or higher
```

### Step 2: Clone the KiCAD MCP Repository

```bash
# Navigate to a suitable location (e.g., ~/tools or ~/projects)
cd ~/tools  # or your preferred location

# Clone the repository
git clone https://github.com/lamaalrajih/kicad-mcp.git
cd kicad-mcp
```

### Step 3: Install Dependencies

```bash
# Install dependencies - this creates a .venv/ folder automatically
make install

# If make is not available, you can use uv directly:
uv venv
source .venv/bin/activate  # On Windows: .venv\Scripts\activate
uv pip install -r requirements.txt
```

**Note:** The `make install` command will:
- Create a virtual environment (`.venv/`)
- Install all necessary dependencies
- Set up the MCP server

### Step 4: Configure Environment

Create a `.env` file to specify where KiCAD should look for projects:

```bash
# Copy the example environment file
cp .env.example .env

# Edit the .env file
nano .env  # or use your preferred editor
```

**Edit `.env` file:**
```bash
# Add paths to your KiCAD projects (comma-separated)
KICAD_SEARCH_PATHS=/home/ajlennon/data_drive/esl/esl-dut-dongle/hardware/schematics,/home/ajlennon/data_drive/esl/esl-dut-dongle/hardware/examples
```

**For your project, add:**
```
KICAD_SEARCH_PATHS=/home/ajlennon/data_drive/esl/esl-dut-dongle/hardware/schematics,/home/ajlennon/data_drive/esl/esl-dut-dongle/hardware/examples/pcb-design-investigation
```

### Step 5: Test the MCP Server

```bash
# Activate the virtual environment
source .venv/bin/activate  # On Windows: .venv\Scripts\activate

# Run the server
python main.py
```

If it runs without errors, the server is working correctly. Press `Ctrl+C` to stop it.

### Step 6: Configure Cursor for MCP

Cursor uses MCP servers through its configuration. The configuration location depends on your system:

**Linux:**
```bash
# Cursor MCP configuration file location
~/.config/Cursor/mcp.json
# or
~/.cursor/mcp.json
```

**macOS:**
```bash
~/Library/Application Support/Cursor/mcp.json
```

**Windows:**
```
%APPDATA%\Cursor\mcp.json
```

**Create or edit the MCP configuration file:**

```json
{
  "mcpServers": {
    "kicad": {
      "command": "/home/ajlennon/tools/kicad-mcp/.venv/bin/python",
      "args": [
        "/home/ajlennon/tools/kicad-mcp/main.py"
      ],
      "env": {
        "KICAD_SEARCH_PATHS": "/home/ajlennon/data_drive/esl/esl-dut-dongle/hardware/schematics,/home/ajlennon/data_drive/esl/esl-dut-dongle/hardware/examples"
      }
    }
  }
}
```

**Important:** Replace `/home/ajlennon/tools/kicad-mcp` with the actual path where you cloned the repository.

### Step 7: Restart Cursor

1. Close Cursor completely
2. Reopen Cursor
3. The MCP server should now be available

## Verification

To verify the MCP server is working:

1. **Check Cursor MCP Status:**
   - Look for MCP server status in Cursor's settings or status bar
   - Check if KiCAD MCP appears in available MCP servers

2. **Test MCP Functions:**
   - Try asking Cursor to interact with KiCAD projects
   - Test commands like "list KiCAD projects" or "create KiCAD schematic"

## Troubleshooting

### Issue: `make` command not found

**Solution:**
```bash
# Install make on Ubuntu/Debian
sudo apt-get install build-essential

# Or use uv directly instead of make
uv venv
source .venv/bin/activate
uv pip install -r requirements.txt
```

### Issue: Python version too old

**Solution:**
```bash
# Check Python version
python3 --version

# Install Python 3.10+ if needed
# Ubuntu/Debian:
sudo apt-get install python3.10 python3.10-venv

# Use specific Python version
python3.10 -m venv .venv
```

### Issue: KiCAD not found

**Solution:**
- Ensure KiCAD is installed and in PATH
- Verify: `which kicad` or `kicad --version`
- The MCP server may need KiCAD's Python libraries

### Issue: MCP server not appearing in Cursor

**Solutions:**
1. Check configuration file path and syntax
2. Ensure paths are absolute (not relative)
3. Verify Python path in configuration
4. Check Cursor logs for MCP errors
5. Restart Cursor completely

### Issue: Permission errors

**Solution:**
```bash
# Make scripts executable
chmod +x .venv/bin/python
chmod +x main.py
```

## Alternative: Manual Installation (if `make` doesn't work)

```bash
# Clone repository
git clone https://github.com/lamaalrajih/kicad-mcp.git
cd kicad-mcp

# Create virtual environment
python3 -m venv .venv
source .venv/bin/activate  # On Windows: .venv\Scripts\activate

# Install dependencies
pip install -r requirements.txt

# Or use uv
uv venv
source .venv/bin/activate
uv pip install -r requirements.txt
```

## Usage

Once installed and configured, you can use the KiCAD MCP server through Cursor:

**Example Commands:**
- "List all KiCAD projects in my workspace"
- "Create a new KiCAD schematic for the ESL DUT dongle"
- "Add FT4232H component to the schematic"
- "Export the schematic to PDF"

## Additional Resources

- **KiCAD MCP Repository:** https://github.com/lamaalrajih/kicad-mcp
- **MCP Documentation:** https://modelcontextprotocol.io/
- **Cursor MCP Documentation:** Check Cursor's documentation for MCP integration

## Notes

- The MCP server requires KiCAD to be installed and accessible
- Project paths in `.env` should be absolute paths
- The virtual environment must be activated or the full path used in Cursor config
- Some KiCAD operations may require KiCAD to be running

## Next Steps

After installation:
1. Verify MCP server is working in Cursor
2. Test basic KiCAD operations
3. Try creating a simple schematic
4. Explore MCP capabilities for your project

