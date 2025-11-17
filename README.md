# ESL DUT Dongle

USB dongle for automating development board control, programming, and testing of NXP i.MX8M Mini and i.MX93 boards.

## Project Overview

This project aims to create a USB dongle that provides:
- **2x UART interfaces** for serial communication
- **5x GPIO outputs** (4 for boot mode control, 1 for reset)
- **Power monitoring** (down to microamp or nanoamp levels)
- Easy USB control from Linux and Windows without custom driver development

## Quick Start

- **Requirements:** See [docs/requirements/PROJECT_REFERENCE.md](docs/requirements/PROJECT_REFERENCE.md)
- **Research Findings:** See [docs/research/RESEARCH_FINDINGS.md](docs/research/RESEARCH_FINDINGS.md)
- **BOM and Costs:** See [docs/bom/BOM_AND_COSTS.md](docs/bom/BOM_AND_COSTS.md)

## Project Status

- **Phase:** Research and evaluation
- **Status:** Active development
- **Last Updated:** November 2024

## Documentation

### Requirements and Specifications
- [Project Reference](docs/requirements/PROJECT_REFERENCE.md) - Requirements and specifications

### Research
- [Research Findings](docs/research/RESEARCH_FINDINGS.md) - Comprehensive research on implementation options
- [CP2108 Deep Dive](docs/research/CP2108_DEEP_DIVE.md) - CP2108 investigation and open-source hardware research
- [Open Source Projects](docs/research/OPEN_SOURCE_PROJECTS.md) - Starting point projects (Tigard, Bus Pirate, etc.)

### Power Monitoring
- [Power Monitoring Integration](docs/power-monitoring/POWER_MONITORING.md) - Power monitoring analysis (INA219, INA228, nanoamp measurement)

### Bill of Materials
- [BOM and Costs](docs/bom/BOM_AND_COSTS.md) - Detailed bill of materials and cost analysis
- [Supplier Availability](docs/bom/SUPPLIER_AVAILABILITY.md) - Supplier research and availability

## Key Recommendations

**Primary Solution:** FTDI FT2232H or FT4232H
- Excellent Linux support via libftdi
- Well-documented and proven solution
- Strong open-source community support
- Integration with OpenOCD for debugging

**Power Monitoring:** INA219 (μA) or INA228 (nA)
- Low cost (<$3-4 additional)
- I2C interface via FTDI MPSSE
- Good accuracy for development work

**Starting Point:** Tigard project
- Uses FT2232H (perfect match)
- Complete open-source hardware and software
- Active project with community support

## Integration with Development Tools

### OpenOCD Support
- FTDI FT2232H/FT4232H supports OpenOCD via MPSSE
- Enables JTAG/SWD debugging
- Console I/O via UART interfaces
- Proven integration (used in Tigard, Bus Pirate)

### Power Monitoring Tools
- Integration with open-source power monitoring tools
- Python/C++ libraries for INA219/INA228
- CSV export for analysis
- Real-time monitoring capabilities

## Repository Structure

```
esl-dut-dongle/
├── README.md                 # This file
├── docs/                     # Documentation
│   ├── requirements/         # Project requirements
│   ├── research/             # Research documents
│   ├── power-monitoring/     # Power monitoring analysis
│   └── bom/                  # Bill of materials
├── hardware/                 # Hardware design files (future)
│   ├── schematics/
│   ├── pcb/
│   └── 3d-models/
├── firmware/                 # Firmware/software (future)
│   ├── drivers/
│   └── tools/
└── LICENSE                   # License file (future)
```

## Contributors

- Alex Lennon
- Michael Hull

## Development

- [Development Roadmap](docs/development/ROADMAP.md) - Project milestones and timeline
- [Setup Instructions](docs/development/SETUP.md) - Development environment setup
- [Design Guidelines](docs/development/DESIGN_GUIDELINES.md) - Hardware design best practices
- [Testing Guidelines](docs/development/TESTING.md) - Testing procedures and requirements

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines on contributing to this project.

## License

This project is proprietary software. All rights reserved. See the [LICENSE](LICENSE) file for details.
