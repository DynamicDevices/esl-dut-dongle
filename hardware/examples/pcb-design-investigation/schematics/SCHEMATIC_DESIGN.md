# Example PCB Design - Schematic Design Investigation

## ⚠️ IMPORTANT: This is an EXAMPLE/INVESTIGATION Document

**This document is NOT the actual hardware design.** It is an example created to investigate PCB design capabilities, documentation approaches, and tool integration.

The actual hardware design will be created in `hardware/schematics/` once the design specification questionnaire is completed.

## Design Overview

This document describes an example schematic design for the ESL DUT dongle based on initial assumptions. It is used to explore PCB design workflows and documentation approaches.

**Current Assumptions:**
- FTDI FT2232H (2 UARTs + GPIO via MPSSE)
- INA228 power monitoring IC (nanoamp capability)
- USB Type-C connector
- 2.54mm pitch headers for target board connection
- 4-layer PCB (for guarding/shielding of power monitoring)

## Block Diagram

```
┌─────────────────────────────────────────────────────────────┐
│                     ESL DUT Dongle                            │
│                                                               │
│  ┌──────────────┐                                            │
│  │  USB Type-C   │                                            │
│  │   Connector   │                                            │
│  └──────┬───────┘                                            │
│         │                                                     │
│         │ USB 2.0                                            │
│         │                                                     │
│  ┌──────▼──────────────────────────────────────┐            │
│  │         FTDI FT2232H                          │            │
│  │  - Channel A: UART1                          │            │
│  │  - Channel B: UART2                          │            │
│  │  - MPSSE: GPIO (5 pins: 4 boot + 1 reset)   │            │
│  │  - I2C: Power monitor interface              │            │
│  └──────┬──────────────────────────────────────┘            │
│         │                                                     │
│         ├─── UART1 TX/RX ────────────────┐                   │
│         ├─── UART2 TX/RX ────────────────┤                   │
│         ├─── GPIO (5 pins) ──────────────┤                   │
│         └─── I2C (SCL/SDA) ──────────────┤                   │
│                                           │                   │
│                                           ▼                   │
│  ┌──────────────────────────────────────────────────────┐    │
│  │              Target Board Connector                   │    │
│  │  - UART1 TX/RX                                        │    │
│  │  - UART2 TX/RX                                        │    │
│  │  - Boot Mode GPIO (4 pins)                           │    │
│  │  - Reset GPIO (1 pin)                                │    │
│  │  - Power Supply (VDD, GND)                          │    │
│  └──────────────────────────────────────────────────────┘    │
│                                                               │
│  ┌──────────────────────────────────────────────────────┐    │
│  │              Power Monitoring Section                   │    │
│  │                                                         │    │
│  │  Power Supply ──► [Shunt Resistor] ──► Target Board   │    │
│  │                      │                                   │    │
│  │                      ▼                                   │    │
│  │                 INA228                                  │    │
│  │                 (I2C)                                   │    │
│  │                      │                                   │    │
│  │                      └───► FT2232H I2C                  │    │
│  └──────────────────────────────────────────────────────┘    │
│                                                               │
└───────────────────────────────────────────────────────────────┘
```

## Component List

### Main ICs

| Component | Part Number | Function | Package |
|-----------|-------------|----------|---------|
| U1 | FT2232H-56Q | USB-to-Dual-UART + MPSSE | QFN-56 |
| U2 | INA228AIDCNT | Power Monitor IC | MSOP-10 |

### Power Supply

| Component | Part Number | Function | Value |
|-----------|-------------|----------|-------|
| C1-C4 | Decoupling | Power supply decoupling | 0.1μF, 0805 |
| C5-C6 | Bulk decoupling | Power supply filtering | 10μF, 0805 |

### Power Monitoring

| Component | Part Number | Function | Value |
|-----------|-------------|----------|-------|
| R_SHUNT | Shunt resistor | Current sense | 10Ω, 1%, 0.5W |
| R1-R2 | I2C pull-up | I2C bus pull-up | 10kΩ, 0805 |

### Connectors

| Component | Part Number | Function | Notes |
|-----------|-------------|----------|-------|
| J1 | USB-C | USB connector | USB Type-C receptacle |
| J2 | Header | Target board connector | 2.54mm pitch, 20-pin |

### Status Indicators (Optional)

| Component | Part Number | Function | Value |
|-----------|-------------|----------|-------|
| LED1 | Status LED | Power indicator | Red/Green, 0805 |
| R_LED1 | Current limit | LED current limit | 1kΩ, 0805 |

## Pin Assignments

### FT2232H (U1) Pin Connections

#### USB Interface
- **VBUS** → USB-C VBUS
- **D+** → USB-C D+
- **D-** → USB-C D-
- **GND** → USB-C GND, Power GND

#### Power Supply
- **VCCIO** → 3.3V (from USB or LDO)
- **VCC** → 3.3V
- **GND** → Power GND

#### Channel A (UART1)
- **ADBUS0/TXD** → J2 Pin 1 (UART1 TX)
- **ADBUS1/RXD** → J2 Pin 2 (UART1 RX)
- **ADBUS2/RTS#** → J2 Pin 3 (UART1 RTS, optional)
- **ADBUS3/CTS#** → J2 Pin 4 (UART1 CTS, optional)

#### Channel B (UART2)
- **BDBUS0/TXD** → J2 Pin 5 (UART2 TX)
- **BDBUS1/RXD** → J2 Pin 6 (UART2 RX)
- **BDBUS2/RTS#** → J2 Pin 7 (UART2 RTS, optional)
- **BDBUS3/CTS#** → J2 Pin 8 (UART2 CTS, optional)

#### GPIO (via MPSSE)
- **ADBUS4** → J2 Pin 9 (Boot Mode GPIO 0)
- **ADBUS5** → J2 Pin 10 (Boot Mode GPIO 1)
- **ADBUS6** → J2 Pin 11 (Boot Mode GPIO 2)
- **ADBUS7** → J2 Pin 12 (Boot Mode GPIO 3)
- **BDBUS4** → J2 Pin 13 (Reset GPIO)

#### I2C Interface (for Power Monitor)
- **ADBUS8/SCL** → INA228 SCL (via R1 pull-up)
- **ADBUS9/SDA** → INA228 SDA (via R2 pull-up)

#### Other
- **OSCI/OSCO** → 12MHz crystal (if external clock needed)
- **RESET#** → Pull-up resistor, optional reset button

### INA228 (U2) Pin Connections

#### Power Supply
- **V+** → Power supply input (before shunt)
- **V-** → Power supply output (after shunt)
- **VCC** → 3.3V
- **GND** → Power GND

#### Current Sense
- **IN+** → High side of shunt resistor
- **IN-** → Low side of shunt resistor

#### I2C Interface
- **SCL** → FT2232H ADBUS8/SCL (via R1 pull-up to 3.3V)
- **SDA** → FT2232H ADBUS9/SDA (via R2 pull-up to 3.3V)
- **ALERT** → Optional interrupt pin (can connect to FT2232H GPIO)

#### Configuration
- **A0, A1** → I2C address selection (GND or VCC)

### Target Board Connector (J2) Pinout

| Pin | Signal | Description | Notes |
|-----|--------|------------|-------|
| 1 | UART1_TX | UART1 Transmit | From FT2232H Channel A |
| 2 | UART1_RX | UART1 Receive | To FT2232H Channel A |
| 3 | UART1_RTS | UART1 RTS (optional) | From FT2232H Channel A |
| 4 | UART1_CTS | UART1 CTS (optional) | To FT2232H Channel A |
| 5 | UART2_TX | UART2 Transmit | From FT2232H Channel B |
| 6 | UART2_RX | UART2 Receive | To FT2232H Channel B |
| 7 | UART2_RTS | UART2 RTS (optional) | From FT2232H Channel B |
| 8 | UART2_CTS | UART2 CTS (optional) | To FT2232H Channel B |
| 9 | BOOT_MODE_0 | Boot Mode GPIO 0 | FT2232H ADBUS4 |
| 10 | BOOT_MODE_1 | Boot Mode GPIO 1 | FT2232H ADBUS5 |
| 11 | BOOT_MODE_2 | Boot Mode GPIO 2 | FT2232H ADBUS6 |
| 12 | BOOT_MODE_3 | Boot Mode GPIO 3 | FT2232H ADBUS7 |
| 13 | RESET | Reset GPIO | FT2232H BDBUS4 |
| 14 | VDD | Power Supply | 3.3V or 5V (TBD) |
| 15 | GND | Ground | Power GND |
| 16 | GND | Ground | Power GND |
| 17 | GND | Ground | Power GND |
| 18 | GND | Ground | Power GND |
| 19 | NC | Not Connected | Reserved |
| 20 | NC | Not Connected | Reserved |

## Power Supply Design

### USB Power
- USB Type-C provides 5V VBUS
- May need 3.3V LDO regulator if FT2232H requires 3.3V
- Check FT2232H datasheet for VCCIO requirements

### Power Monitoring Path
```
USB VBUS (5V) → [Optional LDO] → VDD (3.3V) → [Shunt Resistor] → Target Board VDD
                                                      │
                                                      ▼
                                                  INA228
```

### Decoupling
- 0.1μF ceramic capacitors near each IC power pin
- 10μF bulk capacitors for power supply filtering
- Additional decoupling for INA228 analog section

## I2C Bus Design

### Pull-up Resistors
- 10kΩ pull-up resistors on SCL and SDA lines
- Pull-up to 3.3V
- Standard I2C bus configuration

### I2C Address
- INA228 default address: 0x40 (A0=A1=GND)
- Can be changed by connecting A0/A1 to VCC

## PCB Layout Considerations

### Layer Stackup (4-layer recommended)
1. **Top Layer:** Signal routing, component placement
2. **Ground Plane:** Solid ground plane
3. **Power Plane:** Power distribution (3.3V, 5V)
4. **Bottom Layer:** Signal routing, component placement

### Critical Routing
- **Power Monitoring:**
  - Guard rings around INA228 and shunt resistor
  - Separate analog ground plane
  - Minimize trace length to shunt resistor
  - 4-wire (Kelvin) connection to shunt if possible

- **USB Signals:**
  - Differential pair routing (90Ω impedance)
  - Keep D+ and D- traces matched length
  - Route away from noisy signals

- **I2C Signals:**
  - Keep SCL and SDA traces together
  - Route away from high-speed signals
  - Short traces preferred

- **GPIO Signals:**
  - Standard routing, no special requirements
  - Consider series resistors for protection

## Design Notes

### Assumptions Made
1. **FT2232H** selected (may change to FT4232H)
2. **INA228** selected (may change to INA219)
3. **USB Type-C** connector (may change to USB Micro-B)
4. **10Ω shunt** for nanoamp measurements (may need dual shunts)
5. **3.3V GPIO** levels (need to verify target board requirements)
6. **20-pin connector** (may need more pins)

### Items Requiring Verification
- [ ] Target board voltage levels (3.3V vs 1.8V)
- [ ] Actual boot mode pin requirements
- [ ] Power supply requirements (LDO needed?)
- [ ] Connector type and pin count
- [ ] Shunt resistor value (single vs dual)
- [ ] PCB layer count (2 vs 4 layer)

## Next Steps

1. **Complete Design Specification Questionnaire** - Get answers to critical questions
2. **Verify Component Availability** - Check Future Electronics, Mouser, DigiKey
3. **Create KiCAD Schematic** - Based on this design document
4. **Design PCB Layout** - Following layout considerations
5. **Design Review** - Review schematic and layout before ordering

## References

- FT2232H Datasheet: FTDI website
- INA228 Datasheet: Texas Instruments website
- Design Guidelines: `docs/development/DESIGN_GUIDELINES.md`
- BOM: `docs/bom/BOM_AND_COSTS.md`

