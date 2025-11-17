# ESL DUT Dongle

USB dongle for automating development board control, programming, and testing of NXP i.MX8M Mini and i.MX93 boards.

## Overview

The ESL DUT Dongle provides:
- **4 UART Channels** - Full-duplex serial communication
- **GPIO Control** - Boot mode and reset control
- **Power Monitoring** - Current and voltage measurement via I2C
- **USB-C Interface** - Host connection

## Design Specification

**Complete design decisions:** `docs/requirements/DESIGN_SPEC.md`

### Key Components

- **USB Bridge:** FTDI FT4232H (4 UARTs + GPIO)
- **Power Monitor:** INA219 (1μA minimum measurement)
- **Shunt Resistor:** 0.01Ω (10mΩ)
- **Connector:** USB Type-C
- **Target Interface:** 2.54mm pitch headers

## Project Structure

```
esl-dut-dongle/
├── docs/
│   ├── requirements/
│   │   └── DESIGN_SPEC.md      # Complete design specification
│   └── development/
│       ├── SETUP.md            # Development setup
│       └── KICAD.md            # KiCAD workflow
├── hardware/
│   ├── schematics/             # Schematic design
│   ├── pcb/                    # PCB layout
│   ├── bom/                    # Bill of Materials
│   └── archive/                # Archived projects
└── scripts/                     # Utility scripts
```

## Quick Start

### For Hardware Engineers

1. **Review Design Specification:**
   ```bash
   cat docs/requirements/DESIGN_SPEC.md
   ```

2. **Setup Development Environment:**
   ```bash
   # Install KiCAD 9.0+
   sudo snap install kicad
   
   # See docs/development/SETUP.md for details
   ```

3. **Open Schematic:**
   ```bash
   cd hardware/schematics/esl-dut-dongle
   kicad esl-dut-dongle.kicad_pro
   ```

### For Software Engineers

See firmware documentation (when available).

## Documentation

- **Design Specification:** `docs/requirements/DESIGN_SPEC.md` - Complete design decisions
- **Development Setup:** `docs/development/SETUP.md` - KiCAD installation and setup
- **KiCAD Workflow:** `docs/development/KICAD.md` - Schematic and PCB workflow
- **Bill of Materials:** `docs/bom/BOM_AND_COSTS.md` - Component costs

## Status

**Current:** Design specification complete, ready for schematic design

**Next:** Install KiCAD 9.0+, create schematic, PCB layout, prototype build

## License

Proprietary - All rights reserved by Active Edge Solutions
