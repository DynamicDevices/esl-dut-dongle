# Development Setup

**Last Updated:** 2025-11-17

## Prerequisites

- **Python:** 3.10+ (for KiCAD MCP)
- **KiCAD:** 9.0+ recommended (includes `kicad-cli`)
- **Git:** For version control

## KiCAD Installation

### Install Latest Stable (KiCAD 9.0.6)

**Required for:** Schematic design, PCB layout, automated PDF export

```bash
sudo snap install kicad
```

**Version:** Snap installs KiCAD 9.0.6 (latest stable as of November 2025)

**Verify installation:**
```bash
export PATH="/snap/bin:$PATH"
kicad-cli --version
# Should show KiCAD 9.0.6
```

**Note:** KiCAD 9.0+ includes `kicad-cli` for command-line automation.

### Accessing KiCAD

**GUI Applications:**
```bash
kicad          # Project manager
eeschema       # Schematic editor
pcbnew         # PCB editor
```

**Command Line Tool:**
```bash
export PATH="/snap/bin:$PATH"
kicad-cli --version
kicad-cli sch export pdf <schematic> -o <output.pdf>
```

### Updating KiCAD

```bash
sudo snap refresh kicad
```

Snap packages auto-update, but you can manually refresh to get the latest version.

## KiCAD MCP Server (Optional)

For AI-assisted KiCAD workflow:

```bash
bash scripts/install_kicad_mcp.sh
```

See `docs/development/KICAD.md` for MCP usage.

## Google Docs Export (Optional)

For design spec collaboration:

```bash
export GOOGLE_DOC_ID='your-document-id'
python3.10 scripts/export_google_doc.py
```

See `scripts/README.md` for details.

## Project Structure

- `hardware/schematics/` - Schematic design (KiCAD)
- `hardware/pcb/` - PCB layout (KiCAD)
- `docs/requirements/` - Design specifications
- `docs/development/` - Development guides
- `scripts/` - Utility scripts
