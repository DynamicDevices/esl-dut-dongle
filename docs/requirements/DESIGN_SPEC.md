# Design Specification

**Status:** Complete - All critical answers received (Q21 pending procurement)  
**Last Updated:** 2025-11-17

## Questions & Answers

### Hardware Requirements (Michael - Complete)

**Q1: USB-to-UART+GPIO chip** → FT4232H (4 UARTs)  
**Q2: UART count** → 4 UARTs (confirmed by Q1)  
**Q3: Current measurement** → 1μA minimum (INA219 sufficient)  
**Q4: Dual-range power monitoring** → Single range (INA219) - Confirmed by Q3  
**Q5: Shunt resistor** → 0.01Ω (10mΩ)  
**Q6: USB connector** → USB Type-C  
**Q7: Connection method** → Cable with connector or header pins  
**Q8: Target connector** → 2.54mm pitch headers  
**Q9: Enclosure** → Yes, 3D printed enclosure (for prototypes)  
**Q15: Sampling rate** → Configurable (up to INA219 maximum)

### Software Requirements (Alex - Complete)

**Q10: OS Support** → Linux, Windows, Mac (if no major issues)  
**Q11: Languages** → Python, C/C++, Rust (CLI critical)  
**Q12: GUI** → CLI critical, GUI for power graphs, Jupyter integration  
**Q13: OpenOCD** → Full support preferred  
**Q14: Power Tools** → Both custom and existing  
**Q16: Target Boards** → Both i.MX8M Mini/i.MX93 plus future boards  
**Q19: Cost** → Not primary concern  
**Q20: Quantity** → Prototype/small batch (10-50 units)  
**Q22: Test Equipment** → Comprehensive  
**Q23: Testing** → Basic/minimal (internal tool)  
**Q24: Documentation** → A to B, AI-generated with oversight  
**Q25: Use Case** → All of the above  
**Q26: Automation** → Both standalone and CI/CD

### Third Party Verification (Complete)

**Q17: Boot mode pins** → 4 boot pins required  
**Q18: Voltage levels** → 1.8V to 3.3V (to be provided from target hardware)  
**Q21: Board assembly** → Pending (procurement)

## Design Decisions

### Main Components

- **USB Bridge:** FT4232H (4 UARTs + GPIO via MPSSE)
- **Power Monitoring:** INA219 (1μA minimum measurement)
- **Shunt Resistor:** 0.01Ω (10mΩ)
- **USB Connector:** Type-C
- **Target Connector:** 2.54mm headers (with cable option)
- **Enclosure:** 3D printed (prototypes)
- **Boot Mode Pins:** 4 GPIOs required
- **Voltage Levels:** 1.8V to 3.3V (level translation needed)

### Key Requirements

- **Cross-platform CLI tools critical**
- **Cost not primary concern** (internal debugging tool)
- **Jupyter integration** for power monitoring
- **Full OpenOCD support** preferred
- **Future-proofing** - support current and future boards
- **4 UARTs** for flexibility
- **1μA measurement** sufficient (INA219)

## Critical Decisions Remaining

1. **Q21:** Board assembly - Procurement decision

## Next Steps

1. **Finalize Q21** - Confirm assembly approach (recommended: JLCPCB for prototypes)
2. **Create actual design** in `hardware/schematics/` based on complete specification
3. **Design GPIO circuit** - 4 boot mode pins, voltage level translation (1.8V-3.3V)
