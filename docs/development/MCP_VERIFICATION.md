# KiCAD MCP Server Verification Guide

## Quick Verification Steps

### 1. Check Configuration File

```bash
cat ~/.config/Cursor/mcp.json
```

Should show the KiCAD MCP server configuration.

### 2. Verify Server Can Start

```bash
cd ~/tools/kicad-mcp
source .venv/bin/activate
python main.py
```

You should see the FastMCP banner. Press Ctrl+C to stop.

### 3. Check Cursor MCP Status

**In Cursor:**
1. Open Cursor Settings (Ctrl+,)
2. Search for "MCP" or "Model Context Protocol"
3. Look for MCP server status indicators
4. Check if "kicad" server is listed and running

**Alternative:** Look for MCP indicators in:
- Status bar (bottom of Cursor window)
- Command palette (Ctrl+Shift+P) → search "MCP"
- Settings → Extensions → MCP

### 4. Test MCP Functionality

Try asking Cursor natural language questions that would use KiCAD MCP:

**Examples:**
- "List KiCAD projects in my workspace"
- "Show me any KiCAD files"
- "Create a new KiCAD schematic for testing"
- "What KiCAD files are in the hardware directory?"

If MCP is working, Cursor should be able to:
- Search for KiCAD files
- Read KiCAD project information
- Potentially create/modify KiCAD files

### 5. Check Cursor Logs

If MCP isn't working, check Cursor logs:

**Linux:**
```bash
# Check Cursor logs
tail -f ~/.config/Cursor/logs/*.log | grep -i mcp
```

Look for:
- MCP server startup messages
- Connection errors
- Configuration errors

### 6. Manual Server Test

Test the server directly:

```bash
cd ~/tools/kicad-mcp
source .venv/bin/activate

# Test Python import
python -c "from kicad_mcp import server; print('✅ Module loads')"

# Test server startup (will wait for connection)
python main.py
```

## Troubleshooting

### MCP Server Not Appearing

**Issue:** MCP resources not showing up in Cursor

**Solutions:**
1. **Verify configuration file location:**
   - Should be: `~/.config/Cursor/mcp.json`
   - Check file exists: `ls -la ~/.config/Cursor/mcp.json`

2. **Check JSON syntax:**
   ```bash
   python3 -m json.tool ~/.config/Cursor/mcp.json
   ```
   Should show valid JSON without errors

3. **Verify paths are absolute:**
   - Python path: `/home/ajlennon/tools/kicad-mcp/.venv/bin/python`
   - Script path: `/home/ajlennon/tools/kicad-mcp/main.py`
   - Both should exist: `ls -la /home/ajlennon/tools/kicad-mcp/.venv/bin/python`

4. **Restart Cursor completely:**
   - Close all Cursor windows
   - Wait a few seconds
   - Reopen Cursor
   - Check MCP status again

### Server Fails to Start

**Check Python version:**
```bash
~/tools/kicad-mcp/.venv/bin/python --version
# Should show: Python 3.10.12
```

**Check dependencies:**
```bash
cd ~/tools/kicad-mcp
source .venv/bin/activate
pip list | grep -E "(mcp|fastmcp|kicad)"
```

**Check for errors:**
```bash
cd ~/tools/kicad-mcp
source .venv/bin/activate
python main.py 2>&1
```

### Cursor Not Recognizing MCP

**Possible causes:**
1. Cursor version doesn't support MCP
2. MCP feature needs to be enabled in settings
3. Configuration file in wrong location
4. Cursor needs full restart (not just reload window)

**Try:**
1. Update Cursor to latest version
2. Check Cursor release notes for MCP support
3. Look for MCP settings in Cursor preferences
4. Try alternative config location: `~/.cursor/mcp.json`

## Expected Behavior

### When MCP is Working:

1. **Cursor can access KiCAD MCP tools:**
   - Can list KiCAD projects
   - Can read KiCAD file information
   - Can interact with KiCAD schematics/PCBs

2. **Natural language queries work:**
   - "Show me KiCAD files" → Lists .kicad_sch, .kicad_pcb files
   - "Create a test schematic" → Can create new KiCAD files
   - "What's in my hardware directory?" → Can analyze KiCAD projects

3. **MCP status visible:**
   - Server shows as "connected" or "running"
   - No error messages in logs

## Next Steps After Verification

Once MCP is confirmed working:

1. **Create a test KiCAD project:**
   - Ask Cursor: "Create a simple test KiCAD schematic"
   - Verify files are created in `hardware/schematics/`

2. **Test KiCAD operations:**
   - Add components
   - Create connections
   - Export schematics

3. **Start actual design work:**
   - Use MCP to help with ESL DUT dongle schematic
   - Integrate with design specification answers

## Additional Resources

- **KiCAD MCP Repository:** https://github.com/lamaalrajih/kicad-mcp
- **MCP Documentation:** https://modelcontextprotocol.io/
- **Cursor MCP Guide:** `docs/development/CURSOR_MCP_CONFIG.md`
- **KiCAD Setup:** `docs/development/KICAD_MCP_SETUP.md`

