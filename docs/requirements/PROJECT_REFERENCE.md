# ESL DUT Dongle - Project Reference

## Project Overview
A USB dongle for automating development board control, programming, and testing without manual intervention. The dongle will interface with NXP i.MX8M Mini and i.MX93 development boards to control boot modes and reset functionality.

## Target Applications
- Automated board restarting
- Automated firmware flashing
- Automated testing and validation
- Remote hardware control for development and production testing

## Hardware Requirements

### Core Requirements
1. **2x UART interfaces** - For communication with target boards
2. **5x GPIO outputs** - For control signals:
   - 4x GPIO for boot mode control (manufacturing mode and boot mode pins)
   - 1x GPIO for board reset control
3. **USB interface** - Host connection (USB 2.0 or higher)
4. **Easy software control** - Must be controllable from Linux and Windows without custom driver development

### Target Boards
- NXP i.MX8M Mini
- NXP i.MX93

### Boot Mode Control
The dongle needs to control:
- Manufacturing mode pin(s)
- Boot mode selection pin(s)
- Reset pin

## Software Requirements

### Operating System Support
- Linux (primary development environment)
- Windows (for broader team use)

### Control Interface
- Must be controllable via standard USB interfaces (no custom driver development)
- Prefer existing drivers or standard protocols (USB CDC, HID, etc.)
- Command-line interface preferred for automation scripts

## Proposed Solutions

### Option 1: CP2108 (Silicon Labs)
**Status:** Under evaluation
- USB-to-Quad-UART Bridge
- 16 digital I/O pins available
- Royalty-free drivers
- Package: QFN64 (9x9 mm)

**Evaluation Points:**
- Can it provide 2 UARTs + 5 GPIOs simultaneously?
- Driver availability and ease of use on Linux/Windows
- GPIO control mechanism (via UART commands, separate interface, etc.)

### Option 2: CP2105 + USB Hub + USB/I2C Bridge
**Status:** Alternative approach
- CP2105: Dual USB/UART bridge
- USB Hub: Multiple USB device support
- USB/I2C Bridge: Control I2C GPIO expander
- I2C GPIO Expander: Provides additional GPIOs

**Evaluation Points:**
- Complexity of setup
- Driver availability for USB/I2C bridge on Linux/Windows
- Cost and PCB complexity

### Option 3: Other USB-to-UART+GPIO Solutions
**Status:** To be researched
- FTDI chips (FT2232H, FT4232H, etc.)
- Other Silicon Labs solutions
- Microchip solutions

## Key Questions to Answer

1. **CP2108 Evaluation:**
   - How are the 16 GPIO pins controlled? (UART commands, separate USB interface, etc.)
   - Can 2 UARTs and 5 GPIOs be used simultaneously?
   - What drivers are available and how easy are they to use?
   - Is there existing software/library support?

2. **Alternative Solutions:**
   - What other chips provide UART + GPIO in a single device?
   - What's the complexity of the USB hub + I2C expander approach?
   - Cost comparison between solutions

3. **Software Control:**
   - How to control GPIOs from command line on Linux/Windows?
   - Are there existing libraries/tools?
   - What's the programming interface?

## Project Status
- **Phase:** Research and evaluation
- **Next Steps:** 
  1. Evaluate CP2108 capabilities
  2. Research alternative solutions
  3. Compare options and make recommendation
  4. Prototype development (if CP2108 or alternative is viable)

## Notes
- Michael Hull: "I've been trying to work out how to create a new programming dongle that gives us a USB/UART bridge and some gpio. Silicon labs seem to have this under control, but for the life of me, I can't understand it. So much info that is just not correct or misleading"
- Goal: Close the loop on remote hardware control for automated flashing and testing
- Future: Move into product testing and validation

