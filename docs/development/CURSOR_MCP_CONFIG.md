# Cursor MCP Configuration for KiCAD

## KiCAD MCP Server Installation Complete ✅

The KiCAD MCP server has been installed at:
- **Location:** `~/tools/kicad-mcp/`
- **Python:** Python 3.10.12 (in virtual environment)
- **Status:** Ready to configure

## Cursor MCP Configuration

### Configuration File Location

**Linux:**
```
~/.cursor/mcp.json
```

**Important:** Cursor uses `~/.cursor/mcp.json`, NOT `~/.config/Cursor/mcp.json`

### Configuration File

The MCP configuration file is located at:
```bash
~/.cursor/mcp.json
```

### Current Configuration

The KiCAD MCP server has been added to your existing Cursor MCP configuration:

```json
{
  "mcpServers": {
    "GitKraken": { ... },
    "lab-testing": { ... },
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

### Verify Configuration

**Check configuration file:**
```bash
cat ~/.cursor/mcp.json | python3 -m json.tool
```

**Verify paths:**
```bash
ls -la ~/tools/kicad-mcp/.venv/bin/python ~/tools/kicad-mcp/main.py
```

## After Configuration

1. **Restart Cursor** completely (close and reopen)
2. **Check MCP Status** in Cursor (look for MCP indicators in status bar or settings)
3. **Test MCP Functions** by asking Cursor to interact with KiCAD

## Testing MCP Server

### Manual Test

```bash
cd ~/tools/kicad-mcp
source .venv/bin/activate
python main.py
```

The server should start and wait for MCP client connections.

### Test with Cursor

After configuring and restarting Cursor, try:
- "List KiCAD projects in my workspace"
- "Show me KiCAD files in the hardware directory"
- "Create a new KiCAD schematic"

## Troubleshooting

### MCP Server Not Appearing

1. **Check configuration file syntax:**
   ```bash
   python3 -m json.tool ~/.cursor/mcp.json
   ```

2. **Verify paths are absolute:**
   - Use full paths, not relative paths
   - Check that Python and script paths exist

3. **Check Cursor logs:**
   - Look for MCP-related errors in Cursor's logs
   - Check Cursor's developer console (if available)

### Server Won't Start

1. **Test Python path:**
   ```bash
   ~/tools/kicad-mcp/.venv/bin/python --version
   # Should show Python 3.10.12
   ```

2. **Test script directly:**
   ```bash
   cd ~/tools/kicad-mcp
   source .venv/bin/activate
   python main.py
   ```

3. **Check environment variables:**
   ```bash
   cd ~/tools/kicad-mcp
   cat .env
   ```

### Permission Issues

```bash
# Make sure Python is executable
chmod +x ~/tools/kicad-mcp/.venv/bin/python

# Make sure script is readable
chmod +r ~/tools/kicad-mcp/main.py
```

### Configuration File Location

**Important:** Cursor uses `~/.cursor/mcp.json` on Linux, not `~/.config/Cursor/mcp.json`

If you created a config in the wrong location, move it:
```bash
# If you created ~/.config/Cursor/mcp.json, merge it with ~/.cursor/mcp.json
# The correct location is ~/.cursor/mcp.json
```

## Alternative Configuration Methods

### Using Environment Variables

If Cursor supports environment variables in config:

```json
{
  "mcpServers": {
    "kicad": {
      "command": "/home/ajlennon/tools/kicad-mcp/.venv/bin/python",
      "args": [
        "/home/ajlennon/tools/kicad-mcp/main.py"
      ]
    }
  }
}
```

And set `KICAD_SEARCH_PATHS` in your shell environment or Cursor's environment.

### Using .env File

The server will also read from `~/tools/kicad-mcp/.env` if environment variables aren't set in Cursor config.

## Next Steps

1. ✅ KiCAD MCP server installed
2. ✅ Dependencies installed
3. ✅ .env file configured
4. ✅ **Cursor MCP configured** (added to `~/.cursor/mcp.json`)
5. **Restart Cursor** (required!)
6. **Test MCP functionality**

## Resources

- **KiCAD MCP Repository:** https://github.com/lamaalrajih/kicad-mcp
- **Installation Guide:** `docs/development/KICAD_MCP_SETUP.md`
- **MCP Documentation:** https://modelcontextprotocol.io/
