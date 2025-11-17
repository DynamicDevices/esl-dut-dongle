# Example PCB Design - Schematic Design Investigation

## ⚠️ IMPORTANT: This is an EXAMPLE/INVESTIGATION Document

**This document is NOT the actual hardware design.** It is an example created to investigate PCB design capabilities, documentation approaches, and tool integration.

The actual hardware design will be created in `hardware/schematics/` once the design specification questionnaire is completed.

## OrCAD Compatibility Note

**Important:** Michael uses OrCAD for professional PCB design. All materials created in KiCAD should be documented and exported in standard formats (EDIF netlist, Gerber files) to ensure compatibility with OrCAD. See `docs/development/ORCAD_COMPATIBILITY.md` for details.

## Design Overview

This document describes an example schematic design for the ESL DUT dongle based on initial assumptions and partial answers from the design specification questionnaire. It is used to explore PCB design workflows and documentation approaches.

**Current Assumptions (Based on Partial Answers):**

### Confirmed from Questionnaire Answers:
- **Target Boards:** i.MX8M Mini, i.MX93, plus future boards (Q16 - Alex)
- **Use Cases:** All use cases supported - automated flashing, power profiling, debugging (Q25 - Alex)
- **Cost:** Not primary concern - functionality prioritized (Q19 - Alex)
- **Production:** 10-50 units prototype/small batch (Q20 - Alex)
- **Testing:** Basic functional testing (Q23 - Alex)

### Still Pending (Hardware - Michael):
- FTDI FT2232H vs FT4232H (Q1, Q2)
- INA219 vs INA228 (Q3)
- USB connector type (Q6)
- Target board connector type (Q7, Q8)
- Enclosure requirements (Q9)
- Shunt resistor configuration (Q5)

### Still Pending (Third Party):
- Boot mode pin requirements (Q17 - needs NXP datasheet verification)
- Voltage levels (Q18 - needs NXP datasheet verification)

### Provisional Design Assumptions (for investigation - pending Michael's confirmation):
- **FTDI FT4232H** (4 UARTs + GPIO via MPSSE) - Provisional
- **Dual-Range Power Monitoring:** Both INA219 (μA range) and INA228 (nA range) - Provisional
- USB Type-C connector
- 2.54mm pitch headers for target board connection
- 4-layer PCB (for guarding/shielding of power monitoring)
- Dual shunt resistors (0.1Ω for active mode, 10Ω for sleep mode)

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
│  │         FTDI FT4232H                          │            │
│  │  - Channel A: UART1                          │            │
│  │  - Channel B: UART2                          │            │
│  │  - Channel C: UART3                          │            │
│  │  - Channel D: UART4                          │            │
│  │  - MPSSE: GPIO (5 pins: 4 boot + 1 reset)   │            │
│  │  - I2C: Power monitor interface              │            │
│  └──────┬──────────────────────────────────────┘            │
│         │                                                     │
│         ├─── UART1 TX/RX ────────────────┐                   │
│         ├─── UART2 TX/RX ────────────────┤                   │
│         ├─── UART3 TX/RX ────────────────┤                   │
│         ├─── UART4 TX/RX ────────────────┤                   │
│         ├─── GPIO (5 pins) ──────────────┤                   │
│         └─── I2C (SCL/SDA) ──────────────┤                   │
│                                           │                   │
│                                           ▼                   │
│  ┌──────────────────────────────────────────────────────┐    │
│  │              Target Board Connector                   │    │
│  │  - UART1 TX/RX                                        │    │
│  │  - UART2 TX/RX                                        │    │
│  │  - UART3 TX/RX                                        │    │
│  │  - UART4 TX/RX                                        │    │
│  │  - Boot Mode GPIO (4 pins)                           │    │
│  │  - Reset GPIO (1 pin)                                │    │
│  │  - Power Supply (VDD, GND)                          │    │
│  └──────────────────────────────────────────────────────┘    │
│                                                               │
│  ┌──────────────────────────────────────────────────────┐    │
│  │              Power Monitoring Section                   │    │
│  │              (Dual-Range: INA219 + INA228)             │    │
│  │                                                         │    │
│  │  Power Supply ──► [Shunt Switch] ──► Target Board      │    │
│  │                      │                                   │    │
│  │                      ├───► [0.1Ω Shunt] ──► INA219     │    │
│  │                      │      (Active Mode, μA range)    │    │
│  │                      │                                   │    │
│  │                      └───► [10Ω Shunt] ──► INA228      │    │
│  │                             (Sleep Mode, nA range)    │    │
│  │                                                         │    │
│  │                      I2C Bus ──► FT4232H I2C            │    │
│  └──────────────────────────────────────────────────────┘    │
│                                                               │
└───────────────────────────────────────────────────────────────┘
```

## Component List

### Main ICs

| Component | Part Number | Function | Package |
|-----------|-------------|----------|---------|
| U1 | FT4232H-56Q | USB-to-Quad-UART + MPSSE | QFN-56 |
| U2 | INA219BIDCNT | Power Monitor IC (μA range) | MSOP-10 |
| U3 | INA228AIDCNT | Power Monitor IC (nA range) | MSOP-10 |
| U4 | (Optional) | Shunt Switch/MUX (for dual-range) | TBD |

### Power Supply

| Component | Part Number | Function | Value |
|-----------|-------------|----------|-------|
| C1-C4 | Decoupling | Power supply decoupling | 0.1μF, 0805 |
| C5-C6 | Bulk decoupling | Power supply filtering | 10μF, 0805 |

### Power Monitoring

| Component | Part Number | Function | Value |
|-----------|-------------|----------|-------|
| R_SHUNT_ACTIVE | Shunt resistor | Current sense (active mode) | 0.1Ω, 1%, 1W |
| R_SHUNT_SLEEP | Shunt resistor | Current sense (sleep mode) | 10Ω, 1%, 0.5W |
| R1-R2 | I2C pull-up | I2C bus pull-up | 10kΩ, 0805 |
| (Optional) | Shunt switch/MUX | Switch between shunts | TBD |

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

### FT4232H (U1) Pin Connections

**Note:** FT4232H has 4 UART channels (A, B, C, D) compared to FT2232H's 2 channels (A, B).

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

#### Channel C (UART3)
- **CDBUS0/TXD** → J2 Pin 9 (UART3 TX)
- **CDBUS1/RXD** → J2 Pin 10 (UART3 RX)
- **CDBUS2/RTS#** → J2 Pin 11 (UART3 RTS, optional)
- **CDBUS3/CTS#** → J2 Pin 12 (UART3 CTS, optional)

#### Channel D (UART4)
- **DDBUS0/TXD** → J2 Pin 13 (UART4 TX)
- **DDBUS1/RXD** → J2 Pin 14 (UART4 RX)
- **DDBUS2/RTS#** → J2 Pin 15 (UART4 RTS, optional)
- **DDBUS3/CTS#** → J2 Pin 16 (UART4 CTS, optional)

#### GPIO (via MPSSE)
- **ADBUS4** → J2 Pin 17 (BOOT_MODE_0)
- **ADBUS5** → J2 Pin 18 (BOOT_MODE_1)
- **ADBUS6** → J2 Pin 19 (BOOT_MODE_2)
- **ADBUS7** → J2 Pin 20 (BOOT_MODE_3)
- **BDBUS4** → J2 Pin 21 (RESET)

#### I2C Interface (for Power Monitors)
- **ADBUS8/SCL** → I2C_SCL (shared bus for INA219 and INA228, via R1 pull-up)
- **ADBUS9/SDA** → I2C_SDA (shared bus for INA219 and INA228, via R2 pull-up)

#### Other
- **OSCI/OSCO** → 12MHz crystal (if external clock needed)
- **RESET#** → Pull-up resistor, optional reset button

### INA219 (U2) Pin Connections - Active Mode (μA Range)

#### Power Supply
- **V+** → Power supply input (before 0.1Ω shunt)
- **V-** → Power supply output (after 0.1Ω shunt)
- **VCC** → 3.3V
- **GND** → Power GND

#### Current Sense
- **IN+** → High side of 0.1Ω shunt resistor
- **IN-** → Low side of 0.1Ω shunt resistor

#### I2C Interface
- **SCL** → I2C_SCL (via R1 pull-up to 3.3V)
- **SDA** → I2C_SDA (via R2 pull-up to 3.3V)
- **ALERT** → Optional interrupt pin

#### Configuration
- **A0, A1** → I2C address selection (GND or VCC)
- Default address: 0x40 (A0=A1=GND)

### INA228 (U3) Pin Connections - Sleep Mode (nA Range)

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
| 1 | UART1_TX | UART1 Transmit | From FT4232H Channel A |
| 2 | UART1_RX | UART1 Receive | To FT4232H Channel A |
| 3 | UART1_RTS | UART1 RTS (optional) | From FT4232H Channel A |
| 4 | UART1_CTS | UART1 CTS (optional) | To FT4232H Channel A |
| 5 | UART2_TX | UART2 Transmit | From FT4232H Channel B |
| 6 | UART2_RX | UART2 Receive | To FT4232H Channel B |
| 7 | UART2_RTS | UART2 RTS (optional) | From FT4232H Channel B |
| 8 | UART2_CTS | UART2 CTS (optional) | To FT4232H Channel B |
| 9 | UART3_TX | UART3 Transmit | From FT4232H Channel C |
| 10 | UART3_RX | UART3 Receive | To FT4232H Channel C |
| 11 | UART3_RTS | UART3 RTS (optional) | From FT4232H Channel C |
| 12 | UART3_CTS | UART3 CTS (optional) | To FT4232H Channel C |
| 13 | UART4_TX | UART4 Transmit | From FT4232H Channel D |
| 14 | UART4_RX | UART4 Receive | To FT4232H Channel D |
| 15 | UART4_RTS | UART4 RTS (optional) | From FT4232H Channel D |
| 16 | UART4_CTS | UART4 CTS (optional) | To FT4232H Channel D |
| 17 | BOOT_MODE_0 | Boot Mode GPIO 0 | FT4232H ADBUS4 |
| 18 | BOOT_MODE_1 | Boot Mode GPIO 1 | FT4232H ADBUS5 |
| 19 | BOOT_MODE_2 | Boot Mode GPIO 2 | FT4232H ADBUS6 |
| 20 | BOOT_MODE_3 | Boot Mode GPIO 3 | FT4232H ADBUS7 |
| 21 | RESET | Reset GPIO | FT4232H BDBUS4 |
| 22 | VDD | Power Supply | 3.3V or 5V (TBD) |
| 23 | GND | Ground | Power GND |
| 24 | GND | Ground | Power GND |
| 25 | GND | Ground | Power GND |
| 26 | GND | Ground | Power GND |
| 27 | NC | Not Connected | Reserved |
| 28 | NC | Not Connected | Reserved |

## Power Supply Design

### USB Power
- USB Type-C provides 5V VBUS
- May need 3.3V LDO regulator if FT4232H requires 3.3V
- Check FT4232H datasheet for VCCIO requirements

### Power Monitoring Path (Dual-Range)
```
USB VBUS (5V) → [Optional LDO] → VDD (3.3V) → [Shunt Switch/MUX] → Target Board VDD
                                                      │
                                                      ├───► [0.1Ω Shunt] ──► INA219 (Active Mode, μA)
                                                      │
                                                      └───► [10Ω Shunt] ──► INA228 (Sleep Mode, nA)
```

**Note:** Shunt switching can be implemented via:
- Manual jumper/switch
- Analog MUX IC
- Relay (for isolation)
- Software-controlled switch (if GPIO available)

### Decoupling
- 0.1μF ceramic capacitors near each IC power pin
- 10μF bulk capacitors for power supply filtering
- Additional decoupling for INA228 analog section

## I2C Bus Design

### Pull-up Resistors
- 10kΩ pull-up resistors on SCL and SDA lines
- Pull-up to 3.3V
- Standard I2C bus configuration

### I2C Addresses
- **INA219 (U2):** Default address 0x40 (A0=A1=GND)
- **INA228 (U3):** Must use different address (e.g., 0x41 by setting A0=VCC, A1=GND)
- Both devices share same I2C bus (SCL/SDA)
- Can be changed by connecting A0/A1 to VCC/GND

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

### Provisional Assumptions Made (Pending Michael's Confirmation)
1. **FT4232H** selected (4 UARTs) - Provisional
2. **Dual-range power monitoring:** Both INA219 and INA228 - Provisional
3. **Dual shunts:** 0.1Ω for active mode, 10Ω for sleep mode - Provisional
4. **USB Type-C** connector (may change to USB Micro-B)
5. **3.3V GPIO** levels (need to verify target board requirements)
6. **28-pin connector** (increased from 20-pin due to 4 UARTs)

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

