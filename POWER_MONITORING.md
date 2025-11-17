# Power Monitoring Integration - Analysis

## Overview

Adding accurate, low-cost power monitoring to the ESL DUT dongle is **highly feasible** and would significantly enhance the device's capabilities for low-power development work. This document analyzes the options, costs, and implementation complexity.

## Requirements

- **Low Power Measurement:** Down to microamp levels (μA)
- **Accuracy:** Sufficient for low-power optimization work
- **Low Cost:** Minimal additional BOM cost
- **Integration:** Works with USB dongle design (FTDI or CP2108)
- **Non-Intrusive:** Minimal impact on measured device

## Recommended Solution: I2C Power Monitoring ICs

### Primary Recommendation: **INA219** (Texas Instruments)

**Why INA219:**
- ✅ **Low Cost:** ~$1-2 per unit in small quantities
- ✅ **I2C Interface:** Easy integration with FTDI MPSSE or CP2108
- ✅ **High Accuracy:** 0.5% typical accuracy
- ✅ **Wide Range:** Measures current from microamps to amps
- ✅ **Integrated:** Measures voltage, current, and calculates power
- ✅ **Low Power:** <1mA typical supply current
- ✅ **Proven:** Widely used in open-source projects

**Specifications:**
- **Voltage Measurement:** 0-26V (bus voltage)
- **Current Measurement:** Depends on shunt resistor (see below)
- **Resolution:** 12-bit ADC
- **Accuracy:** ±0.5% (typical)
- **Interface:** I2C (addressable, up to 16 devices)
- **Package:** SOT23-8 (small, easy to place)
- **Cost:** ~$1.50 in small quantities

**Current Range Calculation:**
- Current range depends on shunt resistor value
- For low power: Use 0.1Ω shunt → measures up to ±3.2A with 1mA resolution
- For very low power: Use 1Ω shunt → measures up to ±320mA with 100μA resolution
- Resolution: 1mA (with 0.1Ω) or 100μA (with 1Ω)

**Integration Complexity:** ⭐⭐ (Low-Medium)
- Simple I2C interface
- Requires shunt resistor
- Minimal external components (2-3 capacitors)

---

### Alternative: **INA226** (Higher Accuracy)

**Advantages over INA219:**
- ✅ Higher accuracy: ±0.1% typical
- ✅ 16-bit ADC (vs 12-bit)
- ✅ Alert pin for threshold monitoring
- ✅ Energy accumulation register

**Disadvantages:**
- ⚠️ Higher cost: ~$3-4 per unit
- ⚠️ More complex (more registers)

**When to Use:**
- When higher accuracy is critical
- When energy accumulation is needed
- When budget allows for premium solution

---

### Alternative: **INA260** (Current + Voltage, No Shunt)

**Advantages:**
- ✅ No external shunt resistor needed (integrated)
- ✅ Measures up to ±15A
- ✅ 16-bit ADC
- ✅ Alert pin

**Disadvantages:**
- ⚠️ Higher cost: ~$4-5 per unit
- ⚠️ Less flexible (fixed current range)
- ⚠️ May not be suitable for very low current measurements

**When to Use:**
- When measuring higher currents (>1A)
- When space is extremely limited
- When shunt resistor placement is difficult

---

## Integration Architecture

### Option 1: FTDI FT2232H/FT4232H + INA219 (Recommended)

**Architecture:**
```
USB Host
  └── FT2232H/FT4232H
      ├── UART 1 → Target Board (Console)
      ├── UART 2 → Target Board (Debug)
      └── MPSSE (I2C) → INA219 Power Monitor
          └── Measures: Voltage, Current, Power
```

**Advantages:**
- ✅ Uses existing FTDI MPSSE for I2C
- ✅ No additional USB devices needed
- ✅ Single USB connection
- ✅ Well-supported (libftdi has I2C support)

**Implementation:**
- Use FTDI MPSSE in I2C mode
- libftdi provides I2C functions
- Read INA219 registers via I2C
- Calculate power from voltage × current

**Complexity:** ⭐⭐ (Low-Medium)
- Requires understanding MPSSE I2C mode
- libftdi examples available
- INA219 has simple register interface

---

### Option 2: CP2108 + INA219

**Architecture:**
```
USB Host
  └── CP2108
      ├── UART 1 → Target Board
      ├── UART 2 → Target Board
      └── GPIO (bit-banged I2C?) → INA219
```

**Challenges:**
- ⚠️ CP2108 GPIO control unclear
- ⚠️ May need bit-banged I2C (complex)
- ⚠️ Less reliable than hardware I2C

**Complexity:** ⭐⭐⭐⭐ (High)
- Not recommended unless CP2108 GPIO control is clarified

---

### Option 3: USB Hub + Separate I2C Bridge

**Architecture:**
```
USB Host
  └── USB Hub
      ├── CP2105 (Dual UART)
      └── USB-to-I2C Bridge
          └── INA219 Power Monitor
```

**Advantages:**
- ✅ Uses standard I2C bridge
- ✅ Separate from UART functionality
- ✅ Well-understood components

**Disadvantages:**
- ⚠️ More complex (USB hub + bridge)
- ⚠️ Higher cost
- ⚠️ More components

**Complexity:** ⭐⭐⭐ (Medium)

---

## Hardware Design Considerations

### Shunt Resistor Selection

**For Low Power Measurement (μA to mA):**

**Option A: 1Ω Shunt Resistor**
- Current Range: ±320mA
- Resolution: 100μA
- Power Loss: Low (P = I²R)
- **Best for:** Very low power measurements (<100mA)

**Option B: 0.1Ω Shunt Resistor**
- Current Range: ±3.2A
- Resolution: 1mA
- Power Loss: Very low
- **Best for:** General purpose (100mA - 3A)

**Option C: 0.01Ω Shunt Resistor**
- Current Range: ±32A
- Resolution: 10mA
- Power Loss: Minimal
- **Best for:** Higher current applications

**Recommendation:** Use **0.1Ω** for general purpose, or **1Ω** if focusing on very low power (<100mA)

### PCB Layout Considerations

1. **Shunt Resistor Placement:**
   - Place shunt resistor in power supply path
   - Use 4-wire (Kelvin) connection if possible
   - Minimize trace resistance

2. **INA219 Placement:**
   - Close to shunt resistor
   - Minimize I2C trace length
   - Proper decoupling capacitors

3. **Power Supply:**
   - INA219 needs 3.3V or 5V supply
   - Can use same supply as FTDI chip
   - Low power consumption (<1mA)

4. **Isolation:**
   - INA219 measures bus voltage (0-26V)
   - Ensure proper isolation if measuring high voltages
   - Use appropriate voltage dividers if needed

---

## Software Implementation

### Using libftdi (FTDI Solution)

**Example Code Structure:**
```c
// Initialize FTDI in MPSSE I2C mode
ftdi_set_bitmode(ftdi, 0, BITMODE_MPSSE);
ftdi_set_baudrate(ftdi, 100000); // I2C 100kHz

// Write to INA219 configuration register
i2c_write_register(ftdi, INA219_ADDR, CONFIG_REG, config_value);

// Read voltage
voltage = i2c_read_register(ftdi, INA219_ADDR, BUS_VOLTAGE_REG);

// Read current
current = i2c_read_register(ftdi, INA219_ADDR, CURRENT_REG);

// Calculate power
power = voltage * current;
```

**Python Alternative (pyftdi):**
```python
from pyftdi.i2c import I2cController

i2c = I2cController()
i2c.configure('ftdi://ftdi:2232h/1')  # Use MPSSE channel

ina219 = i2c.get_port(0x40)  # INA219 default address

# Read voltage and current
voltage = read_voltage(ina219)
current = read_current(ina219)
power = voltage * current
```

### INA219 Library Options

**Open-Source Libraries:**
- **Adafruit INA219** (Arduino/Python) - Well-documented
- **SparkFun INA219** (Arduino) - Simple API
- **Linux I2C Tools** - Command-line interface

**Integration:**
- Adapt existing libraries for FTDI MPSSE
- Or implement simple register read/write functions
- INA219 has straightforward register interface

---

## Cost Analysis

### Component Costs (Small Quantities)

| Component | Quantity | Unit Cost | Total Cost |
|-----------|---------|-----------|------------|
| **INA219** | 1 | $1.50 | $1.50 |
| **Shunt Resistor (0.1Ω)** | 1 | $0.20 | $0.20 |
| **Decoupling Caps** | 2 | $0.05 | $0.10 |
| **Pull-up Resistors (I2C)** | 2 | $0.02 | $0.04 |
| **PCB Area** | - | - | ~$0.50 |
| **Total Additional Cost** | | | **~$2.34** |

### Cost Impact
- **Minimal:** Adds <$3 to BOM
- **High Value:** Enables power profiling capabilities
- **Low Risk:** Well-proven components

---

## Accuracy and Performance

### INA219 Accuracy

**Voltage Measurement:**
- Accuracy: ±0.5% typical
- Resolution: 4mV (12-bit ADC)
- Range: 0-26V

**Current Measurement:**
- Accuracy: Depends on shunt resistor tolerance
- Typical: ±0.5% + shunt resistor error
- Resolution: Depends on shunt value (1mA with 0.1Ω)

**Power Calculation:**
- Calculated: Voltage × Current
- Accuracy: Combined voltage and current errors
- Typical: <1% total error

### Low Power Measurement Capability

**With 1Ω Shunt:**
- Minimum measurable: ~100μA
- Resolution: 100μA
- **Suitable for:** Very low power IoT devices, sleep modes

**With 0.1Ω Shunt:**
- Minimum measurable: ~1mA
- Resolution: 1mA
- **Suitable for:** General embedded systems, active modes

**For Nanoamp Measurements:**
- INA219 may not be sufficient
- Consider specialized low-current amplifiers
- Or use INA219 with larger shunt (10Ω) for very low currents

---

## Open-Source Reference Projects

### 1. Adafruit INA219 Breakout Board

**GitHub:** Various Adafruit repositories  
**Description:** Complete INA219 breakout board design  
**Value:** Reference schematic and layout

### 2. Power Monitoring Projects

**YoMo (You Only Meter Once):**
- Open-source metering board
- Uses different approach (not INA219)
- Cost: ~€50
- **Reference:** [yomo.sourceforge.net](https://yomo.sourceforge.net/)

**Enerduino-pro:**
- Arduino-based power monitor
- Uses photoresistor method
- **Reference:** Various Arduino projects

### 3. FTDI + INA219 Projects

**Status:** Limited direct examples found  
**Note:** But INA219 is commonly used with I2C, and FTDI MPSSE supports I2C, so integration is straightforward

---

## Implementation Difficulty Assessment

### Overall Complexity: ⭐⭐ (Low-Medium)

**Easy Parts:**
- ✅ INA219 is simple I2C device
- ✅ Well-documented register interface
- ✅ Existing libraries available
- ✅ Minimal external components

**Moderate Parts:**
- ⚠️ Need to understand FTDI MPSSE I2C mode
- ⚠️ Shunt resistor selection and placement
- ⚠️ PCB layout for accurate measurement

**Challenging Parts:**
- ⚠️ Calibration for high accuracy
- ⚠️ Very low current measurements (<100μA)

---

## Recommended Implementation Plan

### Phase 1: Proof of Concept
1. **Obtain INA219 breakout board** (Adafruit or similar)
2. **Test with FTDI FT2232H** using MPSSE I2C mode
3. **Develop basic read functions** (voltage, current, power)
4. **Validate accuracy** with known loads

### Phase 2: Integration
1. **Design INA219 into dongle PCB**
2. **Place shunt resistor** in power supply path
3. **Route I2C signals** from FTDI MPSSE
4. **Add decoupling and pull-ups**

### Phase 3: Software Development
1. **Create INA219 driver** using libftdi
2. **Implement power monitoring API**
3. **Add calibration routines**
4. **Create command-line interface**

### Phase 4: Testing and Validation
1. **Test with various loads** (μA to A range)
2. **Compare with reference meter**
3. **Validate low-power measurements**
4. **Document accuracy and limitations**

---

## Comparison with Alternatives

### Alternative 1: External USB Power Meter

**Pros:**
- ✅ No design work needed
- ✅ High accuracy
- ✅ Ready to use

**Cons:**
- ❌ Separate device
- ❌ Higher cost ($20-50)
- ❌ Not integrated with dongle

### Alternative 2: Microcontroller ADC

**Pros:**
- ✅ Lower component cost
- ✅ More flexible

**Cons:**
- ❌ Lower accuracy
- ❌ More complex design
- ❌ Requires calibration
- ❌ Additional microcontroller needed

### Alternative 3: Hall Effect Sensor

**Pros:**
- ✅ Non-intrusive (no shunt resistor)
- ✅ Good for high currents

**Cons:**
- ❌ Lower accuracy
- ❌ Not suitable for low currents
- ❌ Higher cost
- ❌ Requires calibration

---

## Recommendations

### Primary Recommendation: **INA219 with FTDI FT2232H**

**Rationale:**
1. **Low Cost:** <$3 additional BOM
2. **Good Accuracy:** ±0.5% suitable for development work
3. **Easy Integration:** I2C via FTDI MPSSE
4. **Proven Solution:** Widely used in open-source projects
5. **Low Power Capable:** Can measure down to 100μA with proper shunt

**Implementation:**
- Use **0.1Ω shunt** for general purpose (1mA resolution)
- Use **1Ω shunt** if focusing on very low power (100μA resolution)
- Integrate via FTDI MPSSE I2C mode
- Use existing INA219 libraries as reference

### Shunt Resistor Selection Guide

| Application | Current Range | Shunt Resistor | Resolution |
|-------------|---------------|----------------|------------|
| **Very Low Power** | 100μA - 100mA | 1Ω | 100μA |
| **Low Power** | 1mA - 500mA | 0.1Ω | 1mA |
| **General** | 10mA - 3A | 0.1Ω | 1mA |
| **High Current** | 100mA - 30A | 0.01Ω | 10mA |

**Recommendation:** Start with **0.1Ω** for flexibility, can add 1Ω option later if needed.

---

## Conclusion

Adding power monitoring to the ESL DUT dongle is **highly feasible and low cost**. The INA219 provides an excellent balance of cost, accuracy, and ease of integration. Using FTDI FT2232H's MPSSE I2C mode makes integration straightforward.

**Key Benefits:**
- ✅ Low cost (<$3 additional)
- ✅ Good accuracy for development work
- ✅ Easy integration with FTDI solution
- ✅ Enables power profiling and optimization
- ✅ Can measure down to microamp levels

**Next Steps:**
1. Obtain INA219 breakout board for testing
2. Test I2C communication via FTDI MPSSE
3. Validate accuracy with known loads
4. Integrate into dongle design

---

## References

- [INA219 Datasheet](https://www.ti.com/lit/ds/symlink/ina219.pdf)
- [INA226 Datasheet](https://www.ti.com/lit/ds/symlink/ina226.pdf)
- [INA260 Datasheet](https://www.ti.com/lit/ds/symlink/ina260.pdf)
- [Adafruit INA219 Breakout](https://www.adafruit.com/product/904)
- [FTDI MPSSE I2C Application Note](https://ftdichip.com/app-notes/)
- [libftdi Documentation](https://www.intra2net.com/en/developer/libftdi/)

