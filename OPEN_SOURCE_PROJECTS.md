# Open Source Hardware Projects - Starting Points

## Overview

This document catalogs open-source hardware projects that could serve as starting points for the ESL DUT dongle design. These projects demonstrate real-world implementations of USB-to-UART+GPIO solutions using various chips.

## FTDI-Based Projects (Recommended)

### 1. Tigard ⭐ **BEST MATCH**

**Chip:** FT2232H  
**GitHub:** https://github.com/tigard-tools/tigard  
**Crowd Supply:** https://www.crowdsupply.com/securinghw/tigard

**Description:**
- Open-source, FT2232H-based multi-protocol tool
- Designed for hardware hacking and debugging
- Supports JTAG, SWD, SPI, and I²C interfaces
- Operates across multiple voltage levels (1.8V to 5.5V)
- Compatible with OpenOCD and FlashROM

**Why It's Useful:**
- ✅ Uses FT2232H (2 UARTs + GPIO via MPSSE)
- ✅ Complete hardware design files available
- ✅ Comprehensive documentation
- ✅ Demonstrates GPIO control via MPSSE
- ✅ Active project with community support
- ✅ KiCad design files likely available

**Relevance to Our Project:**
- Shows how to use FT2232H for both UART and GPIO
- Demonstrates voltage level translation
- Provides reference for PCB design
- Software examples for GPIO control

---

### 2. Bus Pirate

**Chip:** FT232RL (older version) / Various FTDI chips  
**Website:** http://dangerousprototypes.com/docs/Bus_Pirate  
**Status:** Mature open-source project

**Description:**
- Universal bus interface device
- Designed for programming, debugging, and analyzing microcontrollers
- Supports SPI, I²C, 1-Wire, UART, and more
- Open-source hardware and firmware
- Widely adopted in hardware hacking community

**Why It's Useful:**
- ✅ Comprehensive protocol support
- ✅ Well-documented design
- ✅ Active community
- ✅ Firmware examples
- ✅ Demonstrates multi-protocol interface design

**Relevance to Our Project:**
- Shows how to design a versatile USB interface device
- Demonstrates firmware architecture
- Provides examples of protocol handling
- Community resources and documentation

**Note:** Uses older FT232RL chip, but design principles apply to newer FTDI chips.

---

### 3. Open JTAG

**Chip:** FT245 (USB FIFO) + CPLD  
**Website:** OpenCores  
**Status:** Open-source reference design

**Description:**
- Complete hardware and software JTAG reference design
- Uses FTDI FT245 USB front-end
- Altera EPM570 MAX II CPLD for signal processing
- Capable of 24MHz TCK signals
- USB-based alternative to parallel port JTAG

**Why It's Useful:**
- ✅ Complete reference design
- ✅ Shows USB FIFO usage
- ✅ Demonstrates CPLD integration
- ✅ High-speed operation example

**Relevance to Our Project:**
- Less directly relevant (uses FIFO mode, not UART)
- Shows USB interface design principles
- Demonstrates high-speed USB communication

---

### 4. FTDI-based JTAG Programmer for FPGAs

**Chip:** FTDI (various)  
**GitHub:** https://github.com/anthony-bernaert/ftdi-jtag-programmer

**Description:**
- JTAG programmer circuit for FPGAs
- Design files in KiCad
- Includes bill of materials
- Optional 3D-printable enclosure

**Why It's Useful:**
- ✅ KiCad design files available
- ✅ Complete PCB design
- ✅ BOM included
- ✅ Enclosure design

**Relevance to Our Project:**
- Provides PCB layout reference
- Shows component placement
- Demonstrates enclosure design
- Good starting point for PCB design

---

### 5. OpenVizsla

**Chip:** FT2232H (High-Speed USB FIFO)  
**Website:** https://3mdeb.com/open-source-hardware/

**Description:**
- Open-source USB 2.0 sniffer and analyzer
- Uses FT2232H High-Speed USB FIFO
- Captures and inspects USB traffic
- Hardware and software open-source

**Why It's Useful:**
- ✅ Uses FT2232H (same chip as Tigard)
- ✅ Demonstrates high-speed USB usage
- ✅ Complete hardware design
- ✅ Shows advanced USB applications

**Relevance to Our Project:**
- Uses same chip (FT2232H) we're considering
- Shows FT2232H capabilities
- Demonstrates USB interface design
- More complex than our needs, but good reference

---

### 6. FTDI Reference Designs (Official)

**Source:** FTDI Chip  
**Website:** https://ftdichip.com/technical-support/reference-designs/

**Description:**
FTDI provides official reference designs including:

1. **USB Power Meter**
   - Uses FT232H as USB-to-I²C bridge
   - Current and voltage sensing
   - Complete schematics and code

2. **Win10 IoT Colour Meter**
   - Uses FT4232H USB bridge
   - Controls peripherals and reads sensors
   - Demonstrates FT4232H usage

3. **FT230X GPS Dongle**
   - Uses FT230X chip
   - Interfaces USB host with GPS module
   - Simple reference design

**Why It's Useful:**
- ✅ Official reference designs
- ✅ Complete documentation
- ✅ Schematics and code provided
- ✅ FT4232H example (4 UARTs)

**Relevance to Our Project:**
- **Win10 IoT Colour Meter** uses FT4232H (4 UARTs)
- Shows GPIO control examples
- Official support and documentation
- Reliable reference designs

---

## Other Chip Projects

### CP2105 Projects

**Status:** Limited open-source projects found

**Note:** CP2105 is commonly used but most projects are commercial or proprietary. The CP2108EK evaluation kit remains the best reference for CP210x series.

---

### MCP2221A Projects

**Status:** Limited open-source projects found

**Note:** Microchip MCP2221A is a simpler chip (1 UART, 4 GPIOs) but doesn't meet our dual UART requirement. Few open-source projects found.

---

## Comparison of Open-Source Projects

| Project | Chip | UARTs | GPIO | Hardware Files | Software | Status | Best For |
|---------|------|-------|------|---------------|----------|--------|----------|
| **Tigard** | FT2232H | 2 | Yes (MPSSE) | ✅ GitHub | ✅ | Active | **Best overall match** |
| **Bus Pirate** | FT232RL | 1 | Yes | ✅ | ✅ | Mature | Protocol examples |
| **FTDI JTAG Programmer** | FTDI | N/A | Yes | ✅ KiCad | Partial | Active | PCB design reference |
| **OpenVizsla** | FT2232H | N/A | Yes | ✅ | ✅ | Active | FT2232H reference |
| **FTDI Win10 IoT** | FT4232H | 4 | Yes | ✅ | ✅ | Official | FT4232H reference |
| **CP2108 Projects** | CP2108 | 4 | Yes | ❌ Limited | ❌ | Limited | Not recommended |

---

## Recommended Starting Points

### Primary Recommendation: **Tigard**

**Why:**
1. **Perfect Chip Match:** Uses FT2232H (2 UARTs + GPIO)
2. **Complete Design:** Hardware files, software, documentation
3. **Active Project:** Ongoing development and support
4. **Proven Design:** Crowd-funded and produced
5. **GPIO Examples:** Demonstrates MPSSE GPIO control
6. **Voltage Translation:** Shows level shifting (useful for 3.3V/5V)

**What to Extract:**
- PCB layout and component placement
- FT2232H configuration
- GPIO control software examples
- Voltage level translation circuit
- Enclosure design (if available)

**GitHub Repository:** https://github.com/tigard-tools/tigard

---

### Secondary Recommendation: **FTDI Win10 IoT Colour Meter**

**Why:**
1. **Uses FT4232H:** 4 UARTs (exceeds requirement)
2. **Official Design:** FTDI reference design
3. **GPIO Examples:** Shows GPIO control
4. **Complete Documentation:** Schematics and code

**What to Extract:**
- FT4232H configuration
- GPIO control examples
- Official design patterns

**Website:** https://ftdichip.com/technical-support/reference-designs/

---

### Tertiary Recommendation: **FTDI JTAG Programmer**

**Why:**
1. **KiCad Files:** Complete PCB design
2. **Simple Design:** Good for learning
3. **BOM Included:** Component selection reference

**What to Extract:**
- PCB layout techniques
- Component placement
- Enclosure design

**GitHub Repository:** https://github.com/anthony-bernaert/ftdi-jtag-programmer

---

## Implementation Strategy

### Phase 1: Study Tigard Design
1. Clone Tigard repository
2. Review schematics and PCB layout
3. Study GPIO control software
4. Understand FT2232H configuration

### Phase 2: Adapt for Our Needs
1. Simplify design (remove JTAG/SWD/SPI complexity)
2. Keep 2 UARTs + GPIO functionality
3. Adapt voltage translation if needed
4. Design connector for i.MX8M Mini/i.MX93

### Phase 3: Develop Control Software
1. Use libftdi (as demonstrated in Tigard)
2. Implement GPIO control for boot mode
3. Implement reset control
4. Create command-line interface

### Phase 4: Test and Validate
1. Build prototype
2. Test with i.MX8M Mini
3. Test with i.MX93
4. Validate automation scripts

---

## Key Takeaways

1. **FTDI Solutions Have Strong Open-Source Support:**
   - Multiple projects available
   - Active communities
   - Complete design files

2. **Tigard is the Best Match:**
   - Uses FT2232H (our primary candidate)
   - Complete open-source design
   - Active project with support

3. **CP2108 Has Limited Open-Source Support:**
   - Very few open-source projects
   - Confirms earlier findings
   - Evaluation kit is best resource

4. **Official FTDI Reference Designs:**
   - FT4232H example available
   - Official support
   - Complete documentation

---

## Next Steps

1. **Clone Tigard Repository:**
   ```bash
   git clone https://github.com/tigard-tools/tigard.git
   ```

2. **Review Hardware Design:**
   - Study schematics
   - Review PCB layout
   - Understand component selection

3. **Study Software:**
   - Review GPIO control code
   - Understand libftdi usage
   - Adapt for our use case

4. **Contact Tigard Maintainers:**
   - Ask questions about design decisions
   - Request clarification on GPIO control
   - Understand any design limitations

5. **Compare with FTDI Reference Designs:**
   - Review FT4232H reference design
   - Compare with Tigard approach
   - Decide on final chip selection

---

## References

- [Tigard GitHub](https://github.com/tigard-tools/tigard)
- [Tigard Crowd Supply](https://www.crowdsupply.com/securinghw/tigard)
- [Bus Pirate](http://dangerousprototypes.com/docs/Bus_Pirate)
- [FTDI Reference Designs](https://ftdichip.com/technical-support/reference-designs/)
- [FTDI JTAG Programmer](https://github.com/anthony-bernaert/ftdi-jtag-programmer)
- [OpenVizsla](https://3mdeb.com/open-source-hardware/)

---

## Conclusion

**Tigard is the clear winner** as a starting point for this project. It uses the FT2232H chip we're considering, has complete open-source hardware and software, and demonstrates exactly the kind of functionality we need (UART + GPIO control). The project is active, well-documented, and has a supportive community.

Combined with FTDI's official reference designs (especially the FT4232H Win10 IoT example), we have excellent resources to build upon for the ESL DUT dongle.

