# KiCAD Known Issues

This document tracks known issues and workarounds for KiCAD on this system.

## Command Line Issues

### `kicad --version` Doesn't Work

**Issue:** The `kicad --version` command times out or hangs when executed.

**Symptoms:**
- Command hangs indefinitely
- No output returned
- Process must be killed

**Workaround:**
- Use `which kicad` to verify KiCAD is installed and in PATH
- Try opening KiCAD GUI: `kicad` (without arguments)
- Check KiCAD version through GUI: Help → About KiCAD

**Status:** Known issue - KiCAD GUI works fine, only command-line version check fails.

**Date Noted:** 2025-11-17

## Verification Methods

### Verify KiCAD Installation

**Working Methods:**
```bash
# Check if KiCAD is in PATH
which kicad

# Try opening KiCAD GUI (will show if installed)
kicad

# Check KiCAD config directory
ls ~/.config/kicad/
```

**Non-Working Methods:**
```bash
# This times out - don't use
kicad --version  # ❌ Doesn't work
```

## Related Documentation

- `KICAD_MCP_SETUP.md` - Installation guide (includes this note)
- `SETUP.md` - Development setup guide (includes this note)

