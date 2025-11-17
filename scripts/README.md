# Scripts

Utility scripts for the ESL DUT Dongle project.

## PDF Export

**`export_pdf.sh`** - Export KiCAD schematic to PDF

```bash
bash scripts/export_pdf.sh
```

Requires KiCAD 9.0+ with `kicad-cli`.

## Schematic Generation

**`generate_schematic_actual.py`** - Generate KiCAD schematic from design decisions

```bash
python3 scripts/generate_schematic_actual.py
```

Generates schematic based on confirmed design decisions in `docs/requirements/DESIGN_SPEC.md`.
