# Next Steps - Example PCB Design

## Current Status: ✅ Ready to Start Design

All tools, libraries, and infrastructure are installed and configured. You're ready to begin designing the example schematic!

## Immediate Next Steps

### 1. Open KiCAD and Start Schematic Design

**Open the example project:**
```bash
cd hardware/examples/pcb-design-investigation/kicad-project
kicad esl-dut-dongle-example.kicad_pro
```

**In KiCAD:**
1. Open the schematic editor (click on `esl-dut-dongle-example.kicad_sch`)
2. Start adding components based on the design documentation

### 2. Create Custom Symbols (If Needed)

**Components that may need custom symbols:**
- **FT4232H** (USB-to-Quad-UART bridge) - Custom symbol likely needed
- **INA219** (Current monitor - μA range) - Custom symbol likely needed  
- **INA228** (Current monitor - nA range) - Custom symbol likely needed

**How to create custom symbols:**
1. In KiCAD: **Tools → Symbol Editor**
2. **File → New Symbol**
3. Create symbol based on datasheet pinout
4. Save to project library or global library
5. Reference: `hardware/examples/pcb-design-investigation/schematics/SCHEMATIC_DESIGN.md`

### 3. Add Components to Schematic

**Main components to add:**
- FT4232H (U1) - USB-to-Quad-UART bridge
- INA219 (U2) - Current monitor (μA range)
- INA228 (U3) - Current monitor (nA range)
- USB Type-C connector (J1)
- Target board connector (J2) - 2.54mm pitch header
- Resistors (pull-ups, current limit)
- Capacitors (decoupling, bulk)
- Optional: Status LED

**Reference documents:**
- `hardware/examples/pcb-design-investigation/schematics/SCHEMATIC_DESIGN.md` - Component list and pin assignments
- `hardware/examples/pcb-design-investigation/schematics/NETLIST.md` - Connection details

### 4. Connect Components

**Follow the netlist:**
- Connect UART signals (4 channels: A, B, C, D)
- Connect GPIO signals (boot mode pins, reset)
- Connect I2C bus (shared between INA219 and INA228)
- Connect power supply paths
- Add power symbols (+3V3, +5V, GND)
- Add net labels for clarity

**Netlist reference:** `hardware/examples/pcb-design-investigation/schematics/NETLIST.md`

### 5. Use MCP Tools for Validation

**After creating schematic, use MCP via Cursor:**

**Extract and verify netlist:**
```
"Extract the netlist from esl-dut-dongle-example project"
"Show me all component connections"
```

**Run validation:**
```
"Run a DRC check on esl-dut-dongle-example"
"Validate the project structure"
```

**Generate documentation:**
```
"Generate a BOM for esl-dut-dongle-example"
"Show me the circuit patterns in the schematic"
```

**Analyze design:**
```
"Find all connections for component U1 (FT4232H)"
"Analyze the power supply circuit"
"Identify all I2C connections"
```

## Design Workflow

### Recommended Iterative Process

1. **Design in KiCAD GUI**
   - Add components
   - Draw connections
   - Add net labels
   - Save frequently

2. **Validate with MCP**
   - Extract netlist
   - Run DRC checks
   - Verify connections

3. **Make Corrections**
   - Fix issues in KiCAD GUI
   - Re-validate with MCP
   - Iterate until design is correct

4. **Document**
   - Generate BOM via MCP
   - Extract netlist for documentation
   - Document design decisions

## Key Design Decisions (Provisional)

Based on `DESIGN_DECISIONS.md`, the example design uses:

- **FTDI FT4232H** (4 UARTs + GPIO via MPSSE)
- **Dual-Range Power Monitoring:** Both INA219 (μA) and INA228 (nA)
- **USB Type-C connector**
- **2.54mm pitch headers** for target board connection
- **4-layer PCB** (for guarding/shielding of power monitoring)

**Note:** These are provisional assumptions for the example project. The actual design will be finalized once all questionnaire answers are received.

## Resources

### Documentation
- `hardware/examples/pcb-design-investigation/schematics/SCHEMATIC_DESIGN.md` - Detailed schematic design
- `hardware/examples/pcb-design-investigation/schematics/NETLIST.md` - Component connections
- `hardware/examples/pcb-design-investigation/DESIGN_DECISIONS.md` - Design decisions
- `docs/development/KICAD_WORKFLOW.md` - KiCAD workflow guide
- `docs/development/MCP_SCHEMATIC_WORKFLOW.md` - MCP usage guide
- `docs/development/KICAD_LIBRARIES_INSTALLED.md` - Library information

### Tools
- KiCAD GUI - For schematic creation
- MCP tools via Cursor - For analysis and validation
- Custom symbol editor - For creating missing symbols

## Tips

1. **Start Simple:** Begin with main components (FT4232H, connectors)
2. **Add Power First:** Set up power symbols and power paths early
3. **Use Net Labels:** Makes schematics clearer and easier to verify
4. **Save Often:** Commit to git regularly
5. **Validate Frequently:** Use MCP tools to check your work
6. **Reference Datasheets:** For pin assignments and connections

## Questions?

- Check `docs/development/KICAD_WORKFLOW.md` for detailed workflow
- Check `docs/development/MCP_SCHEMATIC_WORKFLOW.md` for MCP usage
- Check `docs/development/KICAD_KNOWN_ISSUES.md` for known issues

## Summary

**You're ready to start!**

1. ✅ All tools installed
2. ✅ Libraries available
3. ✅ Project created
4. ✅ Documentation ready

**Next action:** Open KiCAD and start designing the schematic!

```bash
cd hardware/examples/pcb-design-investigation/kicad-project
kicad esl-dut-dongle-example.kicad_pro
```

