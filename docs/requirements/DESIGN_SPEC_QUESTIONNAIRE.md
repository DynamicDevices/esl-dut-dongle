# Design Specification Questionnaire

This document contains questions that should be answered before creating the detailed design specification. Each question includes recommended answers based on research and analysis.

## Chip Selection

### Q1: Which USB-to-UART+GPIO chip should we use?

**Options:**
- A) FTDI FT2232H (2 UARTs + GPIO via MPSSE)
- B) FTDI FT4232H (4 UARTs + GPIO via MPSSE)
- C) Silicon Labs CP2108 (4 UARTs + 16 GPIOs)
- D) CP2105 + USB Hub + I2C GPIO Expander

**Recommended Answer:** **A) FTDI FT2232H** or **B) FTDI FT4232H**

**Rationale:**
- Excellent Linux support via libftdi
- Well-documented and proven solution
- Strong open-source community support
- Integration with OpenOCD (proven in Tigard, Bus Pirate)
- Clear GPIO control mechanism
- FT4232H provides future-proofing with 4 UARTs

**Decision Required:** Choose between 2 UARTs (FT2232H) or 4 UARTs (FT4232H) based on future needs.

---

### Q2: Do we need 4 UARTs or is 2 sufficient?

**Options:**
- A) 2 UARTs sufficient (meets current requirements)
- B) 4 UARTs for future expansion

**Recommended Answer:** **A) 2 UARTs sufficient** (unless future expansion is planned)

**Rationale:**
- Current requirement is 2 UARTs
- FT2232H meets requirement at lower cost
- Can upgrade to FT4232H later if needed
- Cost difference: ~$2 per unit

**Decision Required:** Confirm if 4 UARTs are needed for future use cases.

---

## Power Monitoring

### Q3: What is the minimum current measurement requirement?

**Options:**
- A) Microamp level (100 μA minimum) - INA219
- B) Nanoamp level (1-10 nA minimum) - INA228
- C) Both ranges needed - Hybrid approach

**Recommended Answer:** **B) Nanoamp level (INA228)**

**Rationale:**
- Low-power work requires nanoamp measurements
- Sleep mode currents are typically <100 μA
- INA228 provides 20-bit ADC and 2.5 nA input bias
- Cost difference is minimal (~$2 more)
- Better for comprehensive power profiling

**Decision Required:** Confirm if nanoamp measurement is essential or if microamp is sufficient.

---

### Q4: Should we support dual-range power monitoring?

**Options:**
- A) Single range (INA219 for μA or INA228 for nA)
- B) Dual range (both INA219 and INA228)

**Recommended Answer:** **A) Single range (INA228)**

**Rationale:**
- INA228 can measure both ranges with proper shunt selection
- Dual range adds complexity and cost (~$5-6 additional)
- INA228 with 0.1Ω shunt covers active mode
- INA228 with 10Ω shunt covers sleep mode
- Can switch shunts or use single optimized shunt

**Decision Required:** Confirm if single INA228 is sufficient or if dual-range is needed.

---

### Q5: What shunt resistor value should we use?

**Options:**
- A) 0.1Ω (1mA resolution, up to 3.2A)
- B) 1Ω (100μA resolution, up to 320mA)
- C) 10Ω (10nA resolution, up to 32mA)
- D) Dual shunts (switchable)

**Recommended Answer:** **C) 10Ω for nanoamp measurements** or **D) Dual shunts**

**Rationale:**
- For nanoamp measurements, 10Ω shunt is required
- 0.1Ω shunt doesn't provide nanoamp resolution
- Dual shunts allow both active and sleep mode measurement
- Cost difference is minimal (~$0.30 for second shunt)

**Decision Required:** Choose shunt configuration based on measurement priorities.

---

## Connectors and Mechanical

### Q6: What USB connector should we use?

**Options:**
- A) USB Type-C (modern, reversible)
- B) USB Micro-B (common, lower cost)
- C) USB Type-A (host-side, not applicable)

**Recommended Answer:** **A) USB Type-C**

**Rationale:**
- Modern standard, future-proof
- Reversible connector (better UX)
- Slightly higher cost but minimal
- Better for professional tool

**Decision Required:** Confirm USB connector preference.

---

### Q7: How should we connect to target boards?

**Options:**
- A) Header pins (male) - plug into target board
- B) Header sockets (female) - target board plugs into dongle
- C) Cable with connector (flexible)
- D) Combination

**Recommended Answer:** **C) Cable with connector** or **A) Header pins**

**Rationale:**
- Cable provides flexibility and strain relief
- Header pins allow direct connection
- Consider target board connector types
- May need different connectors for different boards

**Decision Required:** Determine connection method based on target board designs.

---

### Q8: What connector type for target board connection?

**Options:**
- A) 2.54mm (0.1") pitch headers (standard)
- B) 2.0mm pitch headers (compact)
- C) JST connectors (secure, locking)
- D) Custom connector

**Recommended Answer:** **A) 2.54mm pitch headers** (with option for cable)

**Rationale:**
- Most common standard
- Compatible with most development boards
- Easy to source and assemble
- Can use adapter cables for other connectors

**Decision Required:** Confirm target board connector requirements.

---

### Q9: Do we need an enclosure?

**Options:**
- A) Yes, 3D printed enclosure
- B) Yes, injection molded enclosure
- C) No, bare PCB acceptable
- D) Optional

**Recommended Answer:** **A) Yes, 3D printed enclosure** (for prototypes)

**Rationale:**
- Protects PCB and components
- Professional appearance
- 3D printing cost-effective for prototypes
- Can upgrade to injection molding for production

**Decision Required:** Confirm enclosure requirements.

---

## Software and Integration

### Q10: What operating systems must be supported?

**Options:**
- A) Linux only
- B) Linux and Windows
- C) Linux, Windows, and macOS

**Recommended Answer:** **B) Linux and Windows**

**Rationale:**
- Primary development is on Linux
- Windows needed for broader team use
- macOS support can be added later if needed
- libftdi supports all three platforms

**Decision Required:** Confirm OS support requirements.

---

### Q11: What programming languages should be supported?

**Options:**
- A) Python only
- B) C/C++ only
- C) Python and C/C++
- D) Python, C/C++, and others

**Recommended Answer:** **C) Python and C/C++**

**Rationale:**
- Python for ease of use and scripting
- C/C++ for performance and integration
- libftdi provides both Python and C bindings
- Covers most use cases

**Decision Required:** Confirm language support requirements.

---

### Q12: Do we need a GUI application?

**Options:**
- A) Yes, graphical user interface
- B) No, command-line only
- C) Optional, web-based interface

**Recommended Answer:** **B) No, command-line only** (initially)

**Rationale:**
- Command-line tools are easier to develop
- Better for automation and scripting
- GUI can be added later if needed
- Focus on core functionality first

**Decision Required:** Confirm if GUI is required or can be added later.

---

### Q13: What level of OpenOCD integration is needed?

**Options:**
- A) Full OpenOCD support (JTAG/SWD debugging)
- B) Basic OpenOCD compatibility
- C) No OpenOCD integration needed

**Recommended Answer:** **A) Full OpenOCD support**

**Rationale:**
- User mentioned OpenOCD integration is very useful
- FTDI MPSSE supports OpenOCD natively
- Proven integration (Tigard, Bus Pirate)
- Enables comprehensive debugging workflow

**Decision Required:** Confirm OpenOCD integration requirements.

---

## Power Monitoring Integration

### Q14: What power monitoring tools should we integrate with?

**Options:**
- A) Custom software only
- B) Integration with existing tools (PowerJoular, etc.)
- C) Both custom and existing tools

**Recommended Answer:** **C) Both custom and existing tools**

**Rationale:**
- Custom software for specific use cases
- Integration with PowerJoular, PowerTOP for broader compatibility
- CSV export for analysis with any tool
- Python library for easy integration

**Decision Required:** Confirm which tools are priority for integration.

---

### Q15: What sampling rate is needed for power monitoring?

**Options:**
- A) Low (<10 Hz) - for average power
- B) Medium (10-100 Hz) - for general profiling
- C) High (>100 Hz) - for transient analysis
- D) Configurable

**Recommended Answer:** **D) Configurable** (up to INA228 maximum)

**Rationale:**
- Different use cases need different rates
- INA228 can support various sampling rates
- Software can adjust based on needs
- Higher rates for transient analysis, lower for average

**Decision Required:** Confirm typical sampling rate requirements.

---

## Target Board Support

### Q16: Which target boards must be supported initially?

**Options:**
- A) i.MX8M Mini only
- B) i.MX93 only
- C) Both i.MX8M Mini and i.MX93
- D) Both plus future boards

**Recommended Answer:** **C) Both i.MX8M Mini and i.MX93**

**Rationale:**
- Both boards mentioned in requirements
- Similar boot mode control requirements
- Design should accommodate both
- Future boards can be added with adapters

**Decision Required:** Confirm initial target board support.

---

### Q17: What are the boot mode pin requirements for target boards?

**Options:**
- A) 4 GPIOs for boot mode (as specified)
- B) More GPIOs needed
- C) Less GPIOs needed
- D) Need to verify with actual boards

**Recommended Answer:** **D) Need to verify with actual boards**

**Rationale:**
- Need to check actual pin requirements
- i.MX8M Mini and i.MX93 may have different requirements
- Verify manufacturing mode vs boot mode pins
- May need additional GPIOs for other functions

**Decision Required:** **CRITICAL** - Verify actual boot mode pin requirements with hardware.

---

### Q18: What voltage levels do target boards use?

**Options:**
- A) 3.3V only
- B) 1.8V only
- C) Multiple voltages (3.3V, 1.8V)
- D) Need to verify

**Recommended Answer:** **D) Need to verify**

**Rationale:**
- GPIO voltage levels must match target boards
- May need level translation
- i.MX8M Mini and i.MX93 may differ
- Critical for proper operation

**Decision Required:** **CRITICAL** - Verify voltage levels for all target boards.

---

## Cost and Production

### Q19: What is the target cost per unit?

**Options:**
- A) <$15
- B) $15-20
- C) $20-25
- D) Cost is not primary concern

**Recommended Answer:** **B) $15-20** (without enclosure)

**Rationale:**
- Based on BOM analysis
- FT2232H + INA228 configuration: ~$17.64
- Reasonable for development tool
- Can optimize if cost is critical

**Decision Required:** Confirm target cost per unit.

---

### Q20: What is the initial production quantity?

**Options:**
- A) 10-50 units (prototype/small batch)
- B) 50-100 units (initial production)
- C) 100+ units (larger production)
- D) TBD

**Recommended Answer:** **A) 10-50 units** (initially)

**Rationale:**
- Start with small batch for testing
- Validate design before larger production
- Can scale up based on demand
- Lower risk approach

**Decision Required:** Confirm initial production quantity.

---

### Q21: Who will assemble the boards?

**Options:**
- A) JLCPCB assembly service
- B) Local assembly house
- C) In-house assembly
- D) TBD

**Recommended Answer:** **A) JLCPCB assembly service** (for prototypes)

**Rationale:**
- Low cost ($3-5 per board)
- Good quality
- Fast turnaround
- Can switch to local assembly for production

**Decision Required:** Confirm assembly approach.

---

## Testing and Validation

### Q22: What test equipment is available?

**Options:**
- A) Basic (multimeter, oscilloscope)
- B) Comprehensive (including power analyzers)
- C) Limited (need to acquire)
- D) TBD

**Recommended Answer:** **B) Comprehensive** (assumed)

**Rationale:**
- Need reference power meter for calibration
- Oscilloscope for signal verification
- Multimeter for basic checks
- May need to acquire specific equipment

**Decision Required:** Confirm available test equipment.

---

### Q23: What is the testing and validation plan?

**Options:**
- A) Basic functional testing
- B) Comprehensive testing including reliability
- C) Minimal testing
- D) TBD

**Recommended Answer:** **B) Comprehensive testing**

**Rationale:**
- Critical for development tool reliability
- Power monitoring accuracy is important
- Long-term reliability testing needed
- User acceptance testing required

**Decision Required:** Define testing requirements and procedures.

---

## Documentation

### Q24: What documentation is required?

**Options:**
- A) Basic user manual
- B) Comprehensive documentation (user manual, API docs, examples)
- C) Minimal documentation
- D) TBD

**Recommended Answer:** **B) Comprehensive documentation**

**Rationale:**
- Development tool needs good documentation
- API documentation for software integration
- Examples for common use cases
- Troubleshooting guide

**Decision Required:** Confirm documentation requirements.

---

## Use Cases and Workflows

### Q25: What is the primary use case?

**Options:**
- A) Automated board flashing
- B) Power profiling and optimization
- C) General development and debugging
- D) All of the above

**Recommended Answer:** **D) All of the above**

**Rationale:**
- Multiple use cases mentioned
- Tool should support all workflows
- Flexibility is important
- Can prioritize features based on use case

**Decision Required:** Confirm primary use cases and priorities.

---

### Q26: How will the dongle be used in automation?

**Options:**
- A) Standalone scripts
- B) CI/CD integration
- C) Both
- D) TBD

**Recommended Answer:** **C) Both**

**Rationale:**
- Automation is a key requirement
- CI/CD integration mentioned
- Command-line tools enable both
- API/library for programmatic access

**Decision Required:** Confirm automation requirements.

---

## Critical Decisions Required

### Must Answer Before Design:

1. **Chip Selection:** FT2232H (2 UARTs) or FT4232H (4 UARTs)?
2. **Power Monitoring:** INA219 (μA) or INA228 (nA)?
3. **Shunt Resistor:** Single or dual range?
4. **Target Board Pins:** Verify actual boot mode pin requirements
5. **Voltage Levels:** Verify target board voltage requirements
6. **Connector Type:** Verify target board connector types
7. **Cost Target:** Confirm acceptable cost per unit
8. **Production Quantity:** Initial batch size

### Should Answer Before Design:

9. USB connector type (Type-C recommended)
10. Enclosure requirements
11. OS support (Linux + Windows recommended)
12. Programming language support
13. OpenOCD integration level
14. Power monitoring tool integration
15. Documentation requirements

---

## Next Steps

1. **Answer all critical questions** - Required before design specification
2. **Answer should-answer questions** - Recommended for complete specification
3. **Verify hardware requirements** - Check actual target board specifications
4. **Create design specification** - Based on answers to these questions
5. **Review and approve** - Before starting hardware design

---

## Notes

- Some questions require hardware verification (boot mode pins, voltage levels)
- Cost and production decisions affect component selection
- Software requirements affect firmware development approach
- Use cases determine feature priorities

