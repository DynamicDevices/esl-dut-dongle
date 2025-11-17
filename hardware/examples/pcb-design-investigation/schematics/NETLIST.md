# Example PCB Design - Netlist Investigation

## ⚠️ IMPORTANT: This is an EXAMPLE/INVESTIGATION Document

**This document is NOT the actual hardware netlist.** It is an example created to investigate netlist formats and documentation approaches.

## Overview

This document provides an example text-based netlist describing component connections. This is used to explore netlist documentation formats and can serve as a reference when creating KiCAD schematics.

## Power Nets

- **+3V3**: 3.3V power supply
- **+5V**: 5V power supply (from USB)
- **GND**: Ground reference
- **AGND**: Analog ground (for power monitoring section)

## USB Interface

### USB-C Connector (J1)
- J1.1 (VBUS) → +5V
- J1.2 (D+) → U1.D+
- J1.3 (D-) → U1.D-
- J1.4 (GND) → GND
- J1.5 (CC1) → (USB-C configuration, may need pull-down)
- J1.6 (CC2) → (USB-C configuration, may need pull-down)

## FT2232H (U1) Connections

### Power
- U1.VCC → +3V3
- U1.VCCIO → +3V3
- U1.GND → GND
- U1.VBUS → +5V

### USB
- U1.D+ → J1.D+
- U1.D- → J1.D-
- U1.VBUS → J1.VBUS

### Channel A (UART1)
- U1.ADBUS0 → J2.1 (UART1_TX)
- U1.ADBUS1 → J2.2 (UART1_RX)
- U1.ADBUS2 → J2.3 (UART1_RTS) [optional]
- U1.ADBUS3 → J2.4 (UART1_CTS) [optional]

### Channel B (UART2)
- U1.BDBUS0 → J2.5 (UART2_TX)
- U1.BDBUS1 → J2.6 (UART2_RX)
- U1.BDBUS2 → J2.7 (UART2_RTS) [optional]
- U1.BDBUS3 → J2.8 (UART2_CTS) [optional]

### GPIO (Boot Mode & Reset)
- U1.ADBUS4 → J2.9 (BOOT_MODE_0)
- U1.ADBUS5 → J2.10 (BOOT_MODE_1)
- U1.ADBUS6 → J2.11 (BOOT_MODE_2)
- U1.ADBUS7 → J2.12 (BOOT_MODE_3)
- U1.BDBUS4 → J2.13 (RESET)

### I2C (Power Monitor)
- U1.ADBUS8 → I2C_SCL
- U1.ADBUS9 → I2C_SDA

### Decoupling Capacitors
- U1.VCC → C1.1, C1.2 → GND (0.1μF)
- U1.VCCIO → C2.1, C2.2 → GND (0.1μF)
- U1.VBUS → C3.1, C3.2 → GND (0.1μF)
- +3V3 → C5.1, C5.2 → GND (10μF bulk)
- +5V → C6.1, C6.2 → GND (10μF bulk)

## INA228 (U2) Connections

### Power
- U2.VCC → +3V3
- U2.GND → AGND
- U2.V+ → Power supply input (before shunt)
- U2.V- → Power supply output (after shunt)

### Current Sense
- U2.IN+ → High side of R_SHUNT
- U2.IN- → Low side of R_SHUNT

### I2C
- U2.SCL → I2C_SCL
- U2.SDA → I2C_SDA
- U2.ALERT → (Optional, can connect to GPIO)

### Address Selection
- U2.A0 → GND (I2C address bit 0)
- U2.A1 → GND (I2C address bit 1)
- Default address: 0x40

### Decoupling
- U2.VCC → C4.1, C4.2 → AGND (0.1μF)

## I2C Bus

### Pull-up Resistors
- I2C_SCL → R1.1, R1.2 → +3V3 (10kΩ)
- I2C_SDA → R2.1, R2.2 → +3V3 (10kΩ)

### Connections
- I2C_SCL: U1.ADBUS8, U2.SCL, R1.1
- I2C_SDA: U1.ADBUS9, U2.SDA, R2.1

## Power Monitoring Path

### Shunt Resistor (R_SHUNT)
- R_SHUNT.1 → Power supply input (VDD_IN)
- R_SHUNT.2 → Power supply output (VDD_OUT)
- R_SHUNT.1 → U2.IN+ (Kelvin connection)
- R_SHUNT.2 → U2.IN- (Kelvin connection)

### Power Path
```
+3V3 → [R_SHUNT: 10Ω] → J2.14 (VDD to target board)
         │
         ├─→ U2.IN+
         └─→ U2.IN-
```

## Target Board Connector (J2)

### UART Signals
- J2.1 → UART1_TX (U1.ADBUS0)
- J2.2 → UART1_RX (U1.ADBUS1)
- J2.3 → UART1_RTS (U1.ADBUS2) [optional]
- J2.4 → UART1_CTS (U1.ADBUS3) [optional]
- J2.5 → UART2_TX (U1.BDBUS0)
- J2.6 → UART2_RX (U1.BDBUS1)
- J2.7 → UART2_RTS (U1.BDBUS2) [optional]
- J2.8 → UART2_CTS (U1.BDBUS3) [optional]

### GPIO Signals
- J2.9 → BOOT_MODE_0 (U1.ADBUS4)
- J2.10 → BOOT_MODE_1 (U1.ADBUS5)
- J2.11 → BOOT_MODE_2 (U1.ADBUS6)
- J2.12 → BOOT_MODE_3 (U1.ADBUS7)
- J2.13 → RESET (U1.BDBUS4)

### Power
- J2.14 → VDD (from power monitoring path)
- J2.15 → GND
- J2.16 → GND
- J2.17 → GND
- J2.18 → GND

### Reserved
- J2.19 → NC (Not Connected)
- J2.20 → NC (Not Connected)

## Status LEDs (Optional)

### Power LED (LED1)
- LED1.A → +3V3
- LED1.K → R_LED1.1
- R_LED1.2 → GND (1kΩ)

## Notes

- All GPIO signals may need series resistors for protection (22Ω-100Ω)
- USB-C CC pins may need pull-down resistors for proper detection
- Consider adding ESD protection on USB and connector signals
- Power supply may need LDO regulator if FT2232H requires 3.3V from 5V USB

