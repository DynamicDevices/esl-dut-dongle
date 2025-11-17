# Schematic Design

**Status:** Ready to begin

## Design Overview

- **USB Bridge:** FTDI FT4232H (4 UARTs + GPIO)
- **Power Monitor:** INA219 (1μA minimum)
- **Shunt Resistor:** 0.01Ω (10mΩ)
- **Connector:** USB Type-C
- **Target Interface:** 2.54mm pitch headers

See `docs/requirements/DESIGN_SPEC.md` for complete design decisions.

## Next Steps

1. Install KiCAD 9.0+ (`docs/development/SETUP.md`)
2. Create KiCAD project in this directory
3. Generate schematic with confirmed components
