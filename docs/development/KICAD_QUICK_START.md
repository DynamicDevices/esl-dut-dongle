# KiCAD Quick Start Checklist

A practical checklist for getting started with KiCAD PCB design.

## Pre-Design Phase

### 1. Install KiCAD
- [ ] Install KiCAD 7.0 or later
- [ ] Verify installation works
- [ ] Open KiCAD and explore interface

### 2. Set Up Libraries
- [ ] Install standard component libraries
- [ ] Install Texas Instruments library (for INA228)
- [ ] Install connector libraries (USB-C, headers)
- [ ] Verify libraries are accessible

### 3. Configure KiCAD
- [ ] Set up symbol library paths
- [ ] Set up footprint library paths
- [ ] Configure default design rules
- [ ] Set up grid preferences

### 4. Prepare Design Documents
- [ ] Review schematic design document
- [ ] Review netlist
- [ ] Understand component requirements
- [ ] Note any custom symbols needed

## Schematic Design Phase

### 5. Create Project
- [ ] Create new KiCAD project
- [ ] Name: `esl-dut-dongle`
- [ ] Location: `hardware/schematics/esl-dut-dongle/`
- [ ] Set up project properties

### 6. Create Custom Symbols (if needed)
- [ ] Create FT2232H symbol (if not in library)
- [ ] Create any other custom symbols
- [ ] Add symbols to project library
- [ ] Verify symbol pin assignments match datasheet

### 7. Draw Schematic
- [ ] Add main components (FT2232H, INA228)
- [ ] Add passive components (resistors, capacitors)
- [ ] Add connectors (USB-C, target board header)
- [ ] Connect components with wires
- [ ] Add net labels for clarity
- [ ] Add power symbols (+3V3, +5V, GND)

### 8. Assign Footprints
- [ ] Assign footprint to each component
- [ ] Verify footprints match component packages
- [ ] Check footprint availability

### 9. Validate Schematic
- [ ] Run Electrical Rules Check (ERC)
- [ ] Fix all errors
- [ ] Review warnings
- [ ] Generate netlist
- [ ] Verify netlist is correct

## PCB Layout Phase

### 10. Set Up PCB
- [ ] Open PCB editor
- [ ] Draw board outline (Edge.Cuts layer)
- [ ] Set board dimensions
- [ ] Set origin point

### 11. Configure Stackup
- [ ] Set up 4-layer stackup (Top, GND, Power, Bottom)
- [ ] Configure layer thickness
- [ ] Set copper weight (1oz)
- [ ] Document stackup

### 12. Configure Design Rules
- [ ] Create net classes (Default, Power, USB, I2C)
- [ ] Set minimum track width (0.1mm)
- [ ] Set minimum clearance (0.1mm)
- [ ] Set via sizes
- [ ] Configure differential pair rules (USB)

### 13. Place Components
- [ ] Place main ICs (FT2232H, INA228)
- [ ] Place connectors
- [ ] Place passive components
- [ ] Group related components
- [ ] Optimize placement for routing

### 14. Route Power and Ground
- [ ] Create power planes (+3V3, +5V)
- [ ] Create ground plane
- [ ] Route power traces
- [ ] Connect all GND pads to ground plane
- [ ] Verify power distribution

### 15. Route Signals
- [ ] Route USB differential pair (90Ω impedance)
- [ ] Route I2C signals (SCL, SDA)
- [ ] Route UART signals
- [ ] Route GPIO signals
- [ ] Add guard rings for power monitoring section

### 16. Add Features
- [ ] Add test points
- [ ] Add silkscreen labels
- [ ] Add version number
- [ ] Add component designators
- [ ] Add pin numbers on connectors

### 17. Validate PCB
- [ ] Run Design Rules Check (DRC)
- [ ] Fix all errors
- [ ] Review warnings
- [ ] Check 3D view
- [ ] Verify component placement
- [ ] Verify routing completeness

## Manufacturing Preparation Phase

### 18. Generate Manufacturing Files
- [ ] Generate Gerber files (all layers)
- [ ] Generate drill files
- [ ] Generate pick and place file
- [ ] Generate Bill of Materials (BOM)
- [ ] Verify all files are correct

### 19. Create Manufacturing Package
- [ ] Organize files in `hardware/pcb/manufacturing/`
- [ ] Create README with manufacturing notes
- [ ] Include stackup information
- [ ] Include design rules
- [ ] Include assembly notes

### 20. Review and Verify
- [ ] View Gerber files in viewer
- [ ] Verify all layers are correct
- [ ] Check drill file
- [ ] Review BOM for accuracy
- [ ] Get colleague review (if using professional tools)

## Collaboration Phase

### 21. Export for Professional Tools
- [ ] Export Gerber files (universal format)
- [ ] Export STEP file (3D model)
- [ ] Export netlist (if needed)
- [ ] Document any manual conversions

### 22. Share with Team
- [ ] Share Gerber files with colleagues
- [ ] Share schematic PDF
- [ ] Share PCB layout PDF
- [ ] Share 3D model
- [ ] Document design decisions

## Post-Design Phase

### 23. Order Prototypes
- [ ] Choose manufacturer (JLCPCB, PCBWay, etc.)
- [ ] Upload Gerber files
- [ ] Configure manufacturing options
- [ ] Order PCBs

### 24. Order Components
- [ ] Review BOM
- [ ] Check component availability
- [ ] Order components from suppliers
- [ ] Verify part numbers

### 25. Prepare for Assembly
- [ ] Review assembly requirements
- [ ] Prepare assembly notes
- [ ] Order assembly service (if needed)
- [ ] Prepare test procedures

## Tips for Success

1. **Start Small**: Begin with a simple section, then expand
2. **Iterate**: Expect to go back and forth between schematic and PCB
3. **Test Early**: Test small sections before completing full design
4. **Document**: Keep notes on design decisions
5. **Review**: Get feedback from colleagues early
6. **Version Control**: Commit design files to Git regularly
7. **Backup**: Keep backups of working designs

## Common Pitfalls to Avoid

- ❌ Not running ERC/DRC before manufacturing
- ❌ Incorrect footprint assignments
- ❌ Missing power/ground connections
- ❌ Incorrect net classes for signals
- ❌ Not checking manufacturer capabilities
- ❌ Forgetting test points
- ❌ Poor component placement
- ❌ Not considering assembly

## Getting Help

- KiCAD Documentation: https://docs.kicad.org/
- KiCAD Forum: https://forum.kicad.info/
- Design Guidelines: `docs/development/DESIGN_GUIDELINES.md`
- Full Workflow: `docs/development/KICAD_WORKFLOW.md`

