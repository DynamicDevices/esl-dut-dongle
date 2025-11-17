# ESL DUT Dongle - Research Findings

## Executive Summary

After researching multiple solutions for a USB dongle providing 2 UARTs and 5 GPIO outputs, several viable options have been identified. The **CP2108** appears to meet the requirements, but there are concerns about GPIO control complexity. **FTDI FT2232H/FT4232H** offers excellent Linux support via libftdi, while the **USB Hub + CP2105 + I2C GPIO Expander** approach provides maximum flexibility.

## Requirements Recap

- **2x UART interfaces** for communication
- **5x GPIO outputs** (4 for boot mode, 1 for reset)
- **USB interface** for host connection
- **Easy control** from Linux and Windows without custom driver development
- **Target boards:** NXP i.MX8M Mini and i.MX93

## Solution 1: Silicon Labs CP2108

### Specifications
- **UARTs:** 4 independent UART interfaces (exceeds requirement)
- **GPIOs:** 16 configurable digital I/O pins (exceeds requirement)
- **Package:** QFN64 (9x9 mm)
- **USB:** USB 2.0 full-speed compliant
- **Baud Rates:** 300 bps to 2 Mbps
- **Drivers:** Royalty-free VCP drivers for Windows, Mac, Linux

### Advantages
- ✅ Meets and exceeds all requirements (4 UARTs, 16 GPIOs)
- ✅ Integrated USB transceiver, clock, and voltage regulator (minimal external components)
- ✅ Royalty-free drivers available
- ✅ Evaluation kit available (CP2108EK)

### Concerns & Unknowns
- ⚠️ **GPIO Control Complexity:** Michael's note: "I've been trying to work out how to create a new programming dongle that gives us a USB/UART bridge and some gpio. Silicon labs seem to have this under control, but for the life of me, I can't understand it. So much info that is just not correct or misleading"
- ⚠️ **GPIO Control Method:** Unclear how GPIOs are controlled:
  - Via UART commands?
  - Separate USB interface?
  - Vendor-specific API?
  - Linux kernel GPIO subsystem?
- ⚠️ **Simultaneous Use:** Need to verify that GPIOs can be used simultaneously with UARTs
- ⚠️ **Linux GPIO Support:** Found mention of Linux kernel patches for CP2108 GPIO support, but status unclear

### Development Resources
- **Evaluation Kit:** CP2108EK available from Silicon Labs
- **Datasheet:** Available on Silicon Labs website
- **Documentation:** Comprehensive but potentially confusing (per Michael's feedback)

### Recommendation Status
**UNDER EVALUATION** - Requires clarification on GPIO control mechanism and software support

---

## Solution 2: FTDI FT2232H or FT4232H

### FT2232H Specifications
- **UARTs:** 2 independent UART interfaces (meets requirement)
- **GPIOs:** Multiple GPIOs via MPSSE (Multi-Protocol Synchronous Serial Engine)
- **Additional:** JTAG, SPI, I2C support via MPSSE
- **Package:** Various (LQFP, QFN)
- **USB:** USB 2.0 high-speed
- **Drivers:** FTDI VCP drivers + libftdi library

### FT4232H Specifications
- **UARTs:** 4 independent UART interfaces (exceeds requirement)
- **GPIOs:** Multiple GPIOs via MPSSE
- **Additional:** JTAG, SPI, I2C support via MPSSE
- **Package:** Various
- **USB:** USB 2.0 high-speed
- **Drivers:** FTDI VCP drivers + libftdi library

### Advantages
- ✅ **Excellent Linux Support:** libftdi library provides easy GPIO control
- ✅ **Well-Documented:** Extensive documentation and examples
- ✅ **Command-Line Tools:** ftdi_eeprom, ftdi_bitbang, etc.
- ✅ **Python Bindings:** pyftdi library available
- ✅ **Proven Solution:** Widely used in embedded development
- ✅ **Simultaneous Use:** UARTs and GPIOs can be used simultaneously

### Disadvantages
- ⚠️ **GPIO via MPSSE:** GPIO control may require understanding MPSSE protocol
- ⚠️ **Cost:** Typically more expensive than CP2108
- ⚠️ **Complexity:** MPSSE adds complexity but also provides flexibility

### Development Resources
- **libftdi:** Open-source library for Linux/Windows/Mac
- **pyftdi:** Python bindings for libftdi
- **FTDI Application Notes:** Extensive documentation
- **Community Support:** Large user base

### Recommendation Status
**STRONG CANDIDATE** - Excellent software support, well-documented, proven solution

---

## Solution 3: USB Hub + CP2105 + USB/I2C Bridge + I2C GPIO Expander

### Architecture
```
USB Host
  └── USB Hub
      ├── CP2105 (Dual UART)
      └── USB/I2C Bridge
          └── I2C GPIO Expander (e.g., MCP23017, PCA9555)
```

### Components

#### CP2105
- **UARTs:** 2 independent UART interfaces (meets requirement)
- **GPIOs:** Limited (not primary function)
- **Package:** QFN28
- **Drivers:** Silicon Labs VCP drivers

#### USB/I2C Bridge Options
1. **FT232H** (FTDI) - Can be configured as I2C master
2. **CH341** - Low-cost USB-to-I2C bridge
3. **MCP2221A** (Microchip) - USB-to-UART/I2C with GPIO

#### I2C GPIO Expander Options
- **MCP23017** (Microchip) - 16 GPIOs, I2C interface
- **PCA9555** (NXP) - 16 GPIOs, I2C interface
- **PCF8574** (NXP) - 8 GPIOs, I2C interface

### Advantages
- ✅ **Modular:** Each component has specific, well-understood function
- ✅ **Flexibility:** Can add more GPIOs easily (multiple expanders)
- ✅ **Standard Interfaces:** I2C is well-supported on Linux
- ✅ **CP2105:** Well-understood dual UART solution

### Disadvantages
- ⚠️ **Complexity:** Multiple components, more PCB complexity
- ⚠️ **USB/I2C Bridge:** Driver availability unclear for Linux/Windows
- ⚠️ **Cost:** Multiple components may be more expensive
- ⚠️ **Power:** USB hub adds power consumption
- ⚠️ **Reliability:** More components = more failure points

### Linux I2C GPIO Control
- **Standard Linux I2C:** `/dev/i2c-*` devices
- **GPIO Sysfs:** `/sys/class/gpio/` (if using GPIO expander with kernel driver)
- **i2c-tools:** Command-line tools (`i2cset`, `i2cget`)
- **libgpiod:** Modern GPIO control library

### Recommendation Status
**VIABLE ALTERNATIVE** - More complex but provides maximum flexibility and uses well-understood components

---

## Solution 4: Other USB-to-UART+GPIO Chips

### Prolific PL2303TB
- **UARTs:** 1 (does not meet requirement)
- **GPIOs:** 12
- **Status:** ❌ Insufficient UARTs

### Prolific PL2303GC
- **UARTs:** 1 (does not meet requirement)
- **GPIOs:** Limited
- **Status:** ❌ Insufficient UARTs

### FTDI FT260
- **UARTs:** 1 (does not meet requirement)
- **GPIOs:** 14
- **I2C:** Master controller
- **Status:** ❌ Insufficient UARTs (but could be used in dual-device setup)

### Microchip MCP2221A
- **UARTs:** 1 (does not meet requirement)
- **GPIOs:** 4 (insufficient)
- **I2C:** Master controller
- **Status:** ❌ Insufficient UARTs and GPIOs

---

## Comparison Matrix

| Solution | UARTs | GPIOs | Linux Support | Windows Support | Complexity | Cost | Status |
|----------|-------|-------|---------------|-----------------|------------|------|--------|
| **CP2108** | 4 | 16 | ⚠️ Unclear | ✅ VCP drivers | ⚠️ Medium-High | Medium | Under Evaluation |
| **FT2232H** | 2 | Multiple | ✅ Excellent (libftdi) | ✅ Good | Medium | Medium-High | **Strong Candidate** |
| **FT4232H** | 4 | Multiple | ✅ Excellent (libftdi) | ✅ Good | Medium | High | **Strong Candidate** |
| **CP2105 + Hub + I2C** | 2 | 16+ | ✅ Good (i2c-tools) | ⚠️ Unclear | High | Medium-High | Viable Alternative |

---

## Key Questions to Answer

### For CP2108:
1. **How are GPIOs controlled?**
   - Is there a vendor API/library?
   - Can they be controlled via standard Linux GPIO subsystem?
   - Are there command-line tools?
   - What's the Windows equivalent?

2. **Can GPIOs and UARTs be used simultaneously?**
   - Are GPIOs shared with UART pins?
   - Is there pin multiplexing?

3. **What's the software interface?**
   - Example code?
   - Documentation clarity?
   - Community support?

### For FTDI Solutions:
1. **GPIO control complexity?**
   - How easy is libftdi to use?
   - Are there simple examples for GPIO control?
   - Command-line tools available?

2. **Cost comparison?**
   - FT2232H vs CP2108 pricing
   - Development board availability

### For USB/I2C Bridge Approach:
1. **USB/I2C bridge driver availability?**
   - Linux support?
   - Windows support?
   - Which chip is best?

2. **Overall system complexity?**
   - PCB design complexity
   - Power requirements
   - Reliability concerns

---

## Recommendations

### Primary Recommendation: **FTDI FT2232H or FT4232H**

**Rationale:**
1. **Proven Solution:** Widely used in embedded development
2. **Excellent Software Support:** libftdi provides easy GPIO control on Linux
3. **Well-Documented:** Extensive documentation and examples
4. **Command-Line Tools:** Available for quick testing
5. **Python Support:** pyftdi for scripting
6. **Simultaneous Use:** UARTs and GPIOs work independently

**Next Steps:**
- Obtain FT2232H or FT4232H evaluation board
- Test GPIO control with libftdi
- Verify UART + GPIO simultaneous operation
- Develop prototype control software

### Secondary Recommendation: **CP2108 (if GPIO control is clarified)**

**Rationale:**
- Meets all requirements
- Potentially lower cost
- Integrated solution

**Next Steps:**
- Contact Silicon Labs support for GPIO control clarification
- Obtain CP2108EK evaluation kit
- Test GPIO control mechanism
- Evaluate documentation clarity

### Alternative: **CP2105 + USB Hub + I2C GPIO Expander**

**Rationale:**
- Uses well-understood components
- Maximum flexibility
- Standard I2C interface

**Next Steps:**
- Research USB/I2C bridge options
- Evaluate driver availability
- Design system architecture
- Cost/benefit analysis

---

## Action Items

1. **Immediate:**
   - [ ] Contact Silicon Labs support about CP2108 GPIO control
   - [ ] Research libftdi GPIO control examples
   - [ ] Compare FT2232H vs FT4232H pricing

2. **Short-term:**
   - [ ] Obtain evaluation board (FTDI or CP2108)
   - [ ] Develop proof-of-concept GPIO control
   - [ ] Test UART + GPIO simultaneous operation

3. **Medium-term:**
   - [ ] Design PCB layout
   - [ ] Develop control software/library
   - [ ] Test with i.MX8M Mini and i.MX93 boards

---

## References

- [CP2108 Datasheet](https://www.silabs.com/documents/public/data-sheets/cp2108-datasheet.pdf)
- [CP2108 Product Page](https://www.silabs.com/interface/usb-bridges/classic/device.cp2108)
- [FTDI libftdi](https://www.intra2net.com/en/developer/libftdi/)
- [FTDI FT2232H Datasheet](https://ftdichip.com/products/ft2232h/)
- [FTDI FT4232H Datasheet](https://ftdichip.com/products/ft4232h/)

---

## Notes

- Michael's concern about CP2108 documentation clarity is a significant factor
- Linux kernel GPIO support for CP2108 may be in development (patches mentioned)
- FTDI solutions have proven track record in similar applications
- USB/I2C bridge approach provides maximum flexibility but adds complexity

