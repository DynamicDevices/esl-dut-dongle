# Hardware Design Guidelines

## Schematic Design

### Component Selection
- Use components from approved supplier list (Future Electronics, Mouser, DigiKey)
- Prefer components with good availability and multiple sources
- Document component selection rationale
- Consider lifecycle and obsolescence

### Power Supply Design
- Proper decoupling capacitors near ICs
- Power supply sequencing if required
- Voltage level translation for 3.3V/5V interfaces
- Current capacity planning

### Signal Integrity
- Proper termination for high-speed signals
- Trace impedance control where needed
- Ground plane design
- EMI considerations

## PCB Layout

### Layer Stackup
- 2-layer for simple designs
- 4-layer recommended for power monitoring (guarding, shielding)
- Document stackup in design files

### Component Placement
- Group related components together
- Minimize trace lengths
- Consider thermal management
- Assembly-friendly placement

### Routing Guidelines
- Use appropriate trace widths for current
- Maintain spacing for voltage isolation
- Guard rings for sensitive analog signals (nanoamp measurements)
- Proper via usage

### Design Rules
- Run DRC (Design Rule Check) before release
- Verify against manufacturer capabilities
- Check for manufacturability
- Review assembly considerations

## Power Monitoring Specific

### For Nanoamp Measurements
- Guard rings around sensitive traces
- Low-leakage PCB materials
- Proper shielding
- Clean power supplies
- Careful component selection

### Shunt Resistor Placement
- 4-wire (Kelvin) connection if possible
- Minimize trace resistance
- Proper power rating
- Temperature coefficient consideration

## Design Review Checklist

Before committing hardware design:
- [ ] Schematic reviewed for correctness
- [ ] DRC passed
- [ ] Component availability verified
- [ ] BOM updated
- [ ] Assembly notes added
- [ ] Test points included
- [ ] Documentation updated

