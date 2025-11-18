# Design Review Package for Michael

**Date:** 2025-11-18  
**Status:** Ready for Hardware Review  
**Version:** 0.2.0

## Executive Summary

The ESL DUT Dongle design is complete and ready for hardware engineering review. All design decisions have been finalized, the schematic has been generated, and all components have been selected.

## Design Status

### ✅ Completed
- **Design Specification:** Complete - All 26 questions answered
- **Component Selection:** Finalized (FT4232H, INA219, INA228)
- **Schematic Generation:** Automated schematic created with all components
- **Symbol Libraries:** Custom symbols downloaded and configured
- **BOM:** Complete with cost analysis
- **Netlist:** Complete connection mapping

### ⚠️ Pending Review
- **Schematic Verification:** Components may need library configuration in KiCAD
- **PCB Layout:** Not started (awaiting schematic approval)
- **Component Footprints:** Assigned but need verification
- **Design Rules:** Need to be defined for PCB layout

## Key Design Decisions

### Main Components
- **USB Bridge:** FTDI FT4232H-56Q-REEL
  - 4 UART channels
  - GPIO control via MPSSE
  - I2C interface for power monitoring

- **Power Monitoring:** Dual Range
  - **INA219BIDCNT:** Microamp range (μA) - 10Ω shunt resistor
  - **INA228AIDGSR:** Nanoamp range (nA) - 0.01Ω shunt resistor
  - Both on I2C bus (INA219 @ 0x40, INA228 @ 0x41)

- **Shunt Resistors:**
  - R_SHUNT1: 10Ω (for INA219)
  - R_SHUNT2: 0.01Ω (for INA228)

### Connectors
- **USB-C:** Type-C receptacle (host connection)
- **Target Interface:** 2.54mm pitch headers (30-pin)

### Power Distribution
- **+5V:** From USB-C VBUS
- **+3V3:** Regulated from FT4232H
- **GND:** Common ground
- **AGND:** Analog ground for power monitoring

## Schematic Overview

### Components (19 total)
- **Main ICs:** U1 (FT4232H), U2 (INA219), U3 (INA228)
- **Shunt Resistors:** R_SHUNT1 (10Ω), R_SHUNT2 (0.01Ω)
- **Connectors:** J1 (USB-C), J2 (30-pin header)
- **Decoupling Capacitors:** C1-C8 (0.1μF + 10μF bulk)
- **I2C Pull-ups:** R1, R2 (10kΩ)
- **Optional LED:** LED1, R_LED1

### Connections
- **93 wire connections** (automated)
- **30 net labels** (power, UART, GPIO, I2C)
- **4 power symbols** (+3V3, +5V, GND, AGND)

### Features
- **4 UART Channels:** UART1-4 (TX/RX pairs)
- **GPIO Control:** 4 boot mode pins + 1 reset pin
- **I2C Bus:** SCL/SDA with pull-ups
- **Power Monitoring:** Dual range with separate shunts

## Files for Review

### Design Documents
1. **`docs/requirements/DESIGN_SPEC.md`**
   - Complete design specification
   - All 26 questions answered
   - Design decisions documented

2. **`docs/bom/BOM_AND_COSTS.md`**
   - Bill of Materials
   - Cost analysis (4 configurations)
   - Supplier information (Future Electronics, Mouser, DigiKey)

3. **`hardware/schematics/esl-dut-dongle/NETLIST.md`**
   - Complete connection mapping
   - Power, I2C, UART, GPIO connections
   - Pin assignments

### KiCAD Project
- **Project File:** `hardware/schematics/esl-dut-dongle/esl-dut-dongle.kicad_pro`
- **Schematic:** `hardware/schematics/esl-dut-dongle/esl-dut-dongle.kicad_sch`
- **PCB:** `hardware/schematics/esl-dut-dongle/esl-dut-dongle.kicad_pcb` (empty, ready for layout)

### Symbol Libraries
- **Custom Symbols:** `hardware/schematics/esl-dut-dongle/symbols/`
  - FT4232H-56Q-REEL.kicad_sym
  - INA219BIDCNT.kicad_sym
  - INA228AIDGSR.kicad_sym

- **Footprints:** `hardware/schematics/esl-dut-dongle/footprints/`
  - QFN50P800X800X100-57N.kicad_mod (FT4232H)
  - SOT65P280X145-8N.kicad_mod (INA219)
  - SOP50P490X110-10N.kicad_mod (INA228)

## Review Checklist

### Schematic Review
- [ ] Verify all components are correct
- [ ] Check power connections (+5V, +3V3, GND, AGND)
- [ ] Verify I2C connections (SCL, SDA, pull-ups)
- [ ] Check UART connections (4 channels)
- [ ] Verify GPIO connections (boot mode, reset)
- [ ] Review power monitoring shunt connections
- [ ] Check decoupling capacitor placement
- [ ] Verify I2C address selection (INA219 @ 0x40, INA228 @ 0x41)

### Component Review
- [ ] FT4232H pin assignments correct
- [ ] INA219 pin assignments correct
- [ ] INA228 pin assignments correct
- [ ] Shunt resistor values correct (10Ω, 0.01Ω)
- [ ] Connector pinouts correct
- [ ] Footprint assignments verified

### Design Review
- [ ] Power monitoring range adequate (μA + nA)
- [ ] UART count sufficient (4 channels)
- [ ] GPIO count sufficient (4 boot + 1 reset)
- [ ] Component costs acceptable
- [ ] Supplier availability confirmed

## Known Issues

### Schematic Display
- **Issue:** Schematic may appear empty in KiCAD
- **Cause:** Symbol libraries may need configuration
- **Solution:** See `hardware/schematics/esl-dut-dongle/FIX_EMPTY_SCHEMATIC.md`
- **Status:** Needs verification in KiCAD

### Library Configuration
- **Issue:** Standard libraries (Device, Connector, power) may not be configured
- **Solution:** Configure in Preferences → Manage Symbol Libraries
- **Status:** Needs verification

## Next Steps (After Review)

1. **Schematic Approval**
   - Review and approve schematic
   - Fix any issues identified
   - Run ERC (Electrical Rules Check)

2. **PCB Layout**
   - Assign design rules
   - Place components
   - Route traces
   - Add power planes
   - Run DRC (Design Rules Check)

3. **Prototype Build**
   - Order components
   - Order PCB
   - Assemble prototype
   - Test functionality

4. **Firmware Development**
   - Develop USB drivers
   - Implement I2C communication
   - Create control software
   - Test power monitoring

## Questions for Review

1. **Schematic:**
   - Are all connections correct?
   - Are component values appropriate?
   - Are there any missing components?

2. **Power Monitoring:**
   - Is dual-range approach acceptable?
   - Are shunt resistor values correct?
   - Is I2C address selection correct?

3. **Connectors:**
   - Is 30-pin header sufficient?
   - Are pin assignments correct?
   - Is USB-C connector appropriate?

4. **PCB Design:**
   - What layer count is recommended?
   - Are there any special routing requirements?
   - What design rules should be used?

## Contact

For questions or feedback, please review the design documents and provide feedback via:
- Design specification: `docs/requirements/DESIGN_SPEC.md`
- Schematic: `hardware/schematics/esl-dut-dongle/esl-dut-dongle.kicad_sch`
- BOM: `docs/bom/BOM_AND_COSTS.md`

---

**Review Status:** Ready for Hardware Engineering Review  
**Reviewer:** Michael  
**Date:** 2025-11-18

