# Project Structure

This document describes the organization of the ESL DUT dongle project following hardware development best practices.

## Directory Structure

```
esl-dut-dongle/
├── README.md                      # Main project README
├── PROJECT_STRUCTURE.md           # This file
├── .gitignore                     # Git ignore rules for hardware files
│
├── docs/                         # Documentation
│   ├── README.md                # Documentation index
│   ├── requirements/            # Project requirements
│   │   └── PROJECT_REFERENCE.md
│   ├── research/                # Research documents
│   │   ├── RESEARCH_FINDINGS.md
│   │   ├── CP2108_DEEP_DIVE.md
│   │   └── OPEN_SOURCE_PROJECTS.md
│   ├── power-monitoring/        # Power monitoring analysis
│   │   └── POWER_MONITORING.md
│   └── bom/                     # Bill of materials
│       ├── BOM_AND_COSTS.md
│       └── SUPPLIER_AVAILABILITY.md
│
├── hardware/                     # Hardware design files
│   ├── README.md
│   ├── schematics/              # Schematic design files
│   ├── pcb/                     # PCB layout files
│   └── 3d-models/               # 3D models and mechanical drawings
│
└── firmware/                     # Firmware and software
    ├── README.md
    ├── drivers/                 # Device drivers
    └── tools/                   # Command-line tools and utilities
```

## Organization Principles

### Documentation (`docs/`)
- **Requirements** - Project specifications and requirements
- **Research** - Investigation documents, chip evaluations, open-source project analysis
- **Power Monitoring** - Power monitoring integration analysis
- **BOM** - Bill of materials, cost analysis, supplier information

### Hardware (`hardware/`)
- **Schematics** - Circuit schematic files (KiCad, Altium, etc.)
- **PCB** - PCB layout files and manufacturing outputs
- **3D Models** - Mechanical designs and enclosure files

### Firmware (`firmware/`)
- **Drivers** - Low-level device drivers
- **Tools** - Command-line utilities and user-facing software

## File Naming Conventions

- **Documentation:** UPPERCASE_WITH_UNDERSCORES.md
- **Code:** lowercase_with_underscores (Python, C/C++)
- **Hardware Files:** Follow tool conventions (KiCad, Altium, etc.)

## Best Practices

1. **Keep README.md at root** - Main entry point for the project
2. **Organize by function** - Group related files together
3. **Document structure** - README files in each major directory
4. **Version control** - Use .gitignore for generated files
5. **Clear navigation** - Update README.md with links to all documentation

## Future Additions

As the project progresses, additional directories may be added:
- `tests/` - Test files and test fixtures
- `scripts/` - Build and utility scripts
- `examples/` - Example code and usage
- `LICENSE` - License file

