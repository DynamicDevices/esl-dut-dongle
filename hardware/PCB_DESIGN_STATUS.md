# PCB Design Status

## Current Status: **Design Phase - Initial Schematic**

This document tracks the progress of PCB design for the ESL DUT dongle.

## Design Documents Created

- ✅ **Schematic Design Document** (`schematics/SCHEMATIC_DESIGN.md`)
  - Block diagram
  - Component list
  - Pin assignments
  - Power supply design
  - PCB layout considerations

- ✅ **Netlist** (`schematics/NETLIST.md`)
  - Text-based netlist
  - All component connections
  - Power nets
  - Signal routing

## Next Steps

### 1. Complete Design Specification Questionnaire
**Status:** Waiting for answers
**Blocking:** Critical design decisions

**Questions that affect PCB design:**
- Q1: Chip selection (FT2232H vs FT4232H)
- Q3: Power monitoring IC (INA219 vs INA228)
- Q5: Shunt resistor configuration
- Q6: USB connector type
- Q7-Q8: Target board connector type
- Q17-Q18: Target board pin requirements and voltage levels

### 2. Create KiCAD Schematic
**Status:** Not started
**Dependencies:** Design specification answers

**Tasks:**
- [ ] Install KiCAD (if not already installed)
- [ ] Create KiCAD project file
- [ ] Add component libraries
- [ ] Create schematic symbols for:
  - FT2232H
  - INA228
  - USB Type-C connector
  - Target board connector
- [ ] Draw schematic based on design document
- [ ] Assign footprints
- [ ] Run ERC (Electrical Rule Check)

### 3. Design PCB Layout
**Status:** Not started
**Dependencies:** Schematic complete

**Tasks:**
- [ ] Define PCB dimensions
- [ ] Place components
- [ ] Route power and ground planes
- [ ] Route signal traces
- [ ] Add guard rings for power monitoring
- [ ] Add test points
- [ ] Run DRC (Design Rule Check)
- [ ] Generate manufacturing files (Gerber, drill files)

### 4. Design Review
**Status:** Not started
**Dependencies:** PCB layout complete

**Tasks:**
- [ ] Schematic review
- [ ] Layout review
- [ ] Component availability check
- [ ] BOM verification
- [ ] Assembly review

## Design Assumptions (Subject to Change)

Based on initial research, the current design assumes:

1. **FTDI FT2232H** - 2 UARTs + GPIO
2. **INA228** - Nanoamp power monitoring
3. **USB Type-C** connector
4. **10Ω shunt resistor** for nanoamp measurements
5. **4-layer PCB** for guarding/shielding
6. **20-pin connector** for target board connection
7. **3.3V GPIO levels** (needs verification)

## Design Tools

### Recommended Tools
- **KiCAD** - Open-source EDA suite (free)
  - Schematic editor
  - PCB layout editor
  - 3D viewer
  - Gerber file generation

### Alternative Tools
- **Altium Designer** - Professional EDA (commercial)
- **Eagle** - Autodesk EDA (commercial)
- **OrCAD** - Cadence EDA (commercial)

## Component Libraries

### KiCAD Libraries Needed
- FTDI component library (may need to create custom symbol)
- Texas Instruments library (for INA228)
- Connector libraries (USB-C, headers)
- Standard passive components (resistors, capacitors)

### Custom Symbols May Be Needed
- FT2232H (complex IC, may need custom symbol)
- INA228 (may be in TI library)
- Target board connector (custom)

## PCB Manufacturing

### Recommended Manufacturers
- **JLCPCB** - Low cost, good quality
- **PCBWay** - Similar to JLCPCB
- **OSH Park** - US-based, good for prototypes

### PCB Specifications (Initial)
- **Size:** ~50mm x 30mm (TBD)
- **Layers:** 4-layer (recommended for power monitoring)
- **Thickness:** 1.6mm (standard)
- **Copper Weight:** 1oz (standard)
- **Surface Finish:** HASL or ENIG (TBD)
- **Solder Mask:** Green (standard)
- **Silkscreen:** White (standard)

## Assembly

### Assembly Options
- **JLCPCB Assembly** - Low cost, good for prototypes
- **Local Assembly House** - Better for production
- **In-House Assembly** - If equipment available

### Assembly Considerations
- Component placement orientation
- Solder paste stencil
- Reflow profile
- Inspection requirements

## Testing

### Test Points to Include
- Power supply voltages (+3V3, +5V)
- USB signals (D+, D-)
- I2C signals (SCL, SDA)
- GPIO signals (for debugging)
- Shunt resistor connections (for calibration)

### Test Procedures
- Power-on test
- USB enumeration test
- UART functionality test
- GPIO control test
- Power monitoring accuracy test

## Documentation Needed

- [ ] Schematic PDF
- [ ] PCB layout PDF
- [ ] 3D renderings
- [ ] Assembly drawings
- [ ] BOM with part numbers
- [ ] Test procedures
- [ ] User manual

## Timeline Estimate

- **Schematic Design:** 1-2 weeks (after questionnaire answers)
- **PCB Layout:** 1-2 weeks (after schematic)
- **Design Review:** 1 week
- **PCB Order:** 1-2 weeks (manufacturing time)
- **Assembly:** 1 week
- **Testing:** 1-2 weeks

**Total:** ~6-10 weeks from questionnaire completion

## Notes

- Design will be refined based on questionnaire answers
- Component selection may change based on availability
- PCB dimensions may change based on connector selection
- Power supply design may need adjustment based on requirements

