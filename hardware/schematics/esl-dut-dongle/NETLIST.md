# Netlist - ESL DUT Dongle

**Generated:** 2025-11-17  
**Purpose:** Complete connection mapping for automated schematic wiring

## Power Connections

### +5V (USB Power)
- J1.USB-C.VBUS → U1.FT4232H.VBUS
- J1.USB-C.VBUS → C8.10uF (bulk decoupling)
- U1.FT4232H.VBUS → +5V net

### +3V3 (Regulated Power)
- U1.FT4232H.3V3OUT → +3V3 net
- +3V3 → U2.INA219.VS
- +3V3 → U3.INA228.VS
- +3V3 → C1, C2, C3, C4, C5, C6, C7 (decoupling caps)

### GND (Ground)
- J1.USB-C.GND → GND net
- U1.FT4232H.GND → GND net
- U2.INA219.GND → GND net
- U3.INA228.GND → GND net
- C1, C2, C3, C4, C5, C6, C7, C8 → GND net
- R1, R2 → GND net (I2C pull-ups)

### AGND (Analog Ground)
- U2.INA219.GND → AGND (for power monitoring)
- U3.INA228.GND → AGND
- R_SHUNT1, R_SHUNT2 → AGND

## USB Connections

### USB-C to FT4232H
- J1.USB-C.D+ → U1.FT4232H.USBDM
- J1.USB-C.D- → U1.FT4232H.USBDP
- J1.USB-C.VBUS → U1.FT4232H.VBUS
- J1.USB-C.GND → U1.FT4232H.GND

## I2C Bus Connections

### I2C_SCL (Clock)
- U1.FT4232H.ACBUS0 (or MPSSE pin configured as I2C SCL) → I2C_SCL net
- I2C_SCL → U2.INA219.SCL
- I2C_SCL → U3.INA228.SCL
- I2C_SCL → R1.10k (pull-up to +3V3)

### I2C_SDA (Data)
- U1.FT4232H.ACBUS1 (or MPSSE pin configured as I2C SDA) → I2C_SDA net
- I2C_SDA → U2.INA219.SDA
- I2C_SDA → U3.INA228.SDA
- I2C_SDA → R2.10k (pull-up to +3V3)

### I2C Address Selection
- U2.INA219.A0 → GND (address 0x40)
- U2.INA219.A1 → GND (address 0x40)
- U3.INA228.A0 → GND (address 0x40)
- U3.INA228.A1 → +3V3 (address 0x41, different from INA219)

## Power Monitoring Connections

### INA219 (μA Range) - 10Ω Shunt
- VDD_IN → R_SHUNT1.10Ω pin 1
- R_SHUNT1.10Ω pin 2 → VDD_OUT_219
- VDD_OUT_219 → U2.INA219.VIN+
- VDD_IN → U2.INA219.VIN- (before shunt)
- VDD_OUT_219 → Target board power input

### INA228 (nA Range) - 0.01Ω Shunt
- VDD_IN → R_SHUNT2.0.01Ω pin 1
- R_SHUNT2.0.01Ω pin 2 → VDD_OUT_228
- VDD_OUT_228 → U3.INA228.IN+
- VDD_IN → U3.INA228.IN- (before shunt)
- VDD_OUT_228 → VDD_OUT (final output to target)

## UART Connections (4 Channels)

### UART1 (Channel A)
- U1.FT4232H.ADBUS0 → UART1_TX net
- U1.FT4232H.ADBUS1 → UART1_RX net
- UART1_TX → J2.Header pin (TX)
- UART1_RX → J2.Header pin (RX)

### UART2 (Channel B)
- U1.FT4232H.BDBUS0 → UART2_TX net
- U1.FT4232H.BDBUS1 → UART2_RX net
- UART2_TX → J2.Header pin (TX)
- UART2_RX → J2.Header pin (RX)

### UART3 (Channel C)
- U1.FT4232H.CDBUS0 → UART3_TX net
- U1.FT4232H.CDBUS1 → UART3_RX net
- UART3_TX → J2.Header pin (TX)
- UART3_RX → J2.Header pin (RX)

### UART4 (Channel D)
- U1.FT4232H.DDBUS0 → UART4_TX net
- U1.FT4232H.DDBUS1 → UART4_RX net
- UART4_TX → J2.Header pin (TX)
- UART4_RX → J2.Header pin (RX)

## GPIO Connections (Boot Mode + Reset)

### Boot Mode Pins (4 pins)
- U1.FT4232H.ACBUS2 → BOOT_MODE_0 net → J2.Header pin
- U1.FT4232H.ACBUS3 → BOOT_MODE_1 net → J2.Header pin
- U1.FT4232H.ACBUS4 → BOOT_MODE_2 net → J2.Header pin
- U1.FT4232H.ACBUS5 → BOOT_MODE_3 net → J2.Header pin

### Reset Pin
- U1.FT4232H.ACBUS6 → RESET net → J2.Header pin

## Optional Components

### Status LED
- LED1 anode → +3V3 (via R_LED1.1k)
- LED1 cathode → GND
- Can be controlled via GPIO if needed

## Notes

- FT4232H MPSSE pins (ACBUS0-7) can be configured as I2C or GPIO
- I2C address selection: INA219 = 0x40, INA228 = 0x41 (via A1 pin)
- Power monitoring shunts are in series with target board power
- All UARTs support hardware flow control (RTS/CTS) if needed
- GPIO pins support 1.8V-3.3V (level translation may be needed)

