# ESL DUT Dongle

USB dongle for automating development board control, programming, and testing of NXP i.MX8M Mini and i.MX93 boards.

## Project Overview

This project aims to create a USB dongle that provides:
- **2x UART interfaces** for serial communication
- **5x GPIO outputs** (4 for boot mode control, 1 for reset)
- Easy USB control from Linux and Windows without custom driver development

## Requirements

See [PROJECT_REFERENCE.md](PROJECT_REFERENCE.md) for detailed requirements and specifications.

## Research Findings

See [RESEARCH_FINDINGS.md](RESEARCH_FINDINGS.md) for comprehensive research on implementation options.

### Quick Summary

**Primary Recommendation:** FTDI FT2232H or FT4232H
- Excellent Linux support via libftdi
- Well-documented and proven solution
- 2-4 UARTs + GPIOs via MPSSE

**Alternative:** Silicon Labs CP2108
- 4 UARTs + 16 GPIOs
- Meets all requirements
- GPIO control mechanism needs clarification

**Alternative:** CP2105 + USB Hub + I2C GPIO Expander
- Modular approach
- Maximum flexibility
- More complex but uses well-understood components

## Project Status

- **Phase:** Research and evaluation
- **Next Steps:** 
  1. Evaluate GPIO control mechanisms
  2. Obtain evaluation boards
  3. Develop proof-of-concept
  4. Design PCB and control software

## Repository Structure

- `PROJECT_REFERENCE.md` - Project requirements and specifications
- `RESEARCH_FINDINGS.md` - Detailed research on implementation options
- `README.md` - This file

## Contributors

- Alex Lennon
- Michael Hull

