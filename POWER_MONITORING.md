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

## Nanoamp-Level Measurement (nA)

### Overview

Measuring currents down to **nanoamps (nA)** is significantly more challenging than microamp measurements. It requires specialized components, careful PCB design, and attention to noise and leakage currents. However, it is **feasible** for applications requiring ultra-low power monitoring.

### Challenges at Nanoamp Levels

1. **Leakage Currents:**
   - PCB trace leakage can be significant at nA levels
   - Component leakage currents become critical
   - Requires guarding and shielding techniques

2. **Noise:**
   - Environmental electromagnetic interference
   - Internal component noise
   - Requires careful PCB layout and shielding

3. **Offset Voltages:**
   - Amplifier offset voltages become significant
   - Requires zero-drift or chopper-stabilized amplifiers

4. **Temperature Stability:**
   - Temperature variations affect measurements
   - Requires components with low temperature coefficients

---

### Solutions for Nanoamp Measurement

#### Option 1: INA228 (Recommended for nA)

**Specifications:**
- **Input Bias Current:** 2.5 nA (extremely low)
- **ADC Resolution:** 20-bit (vs 12-bit for INA219)
- **Accuracy:** Higher than INA219
- **Interface:** I2C
- **Cost:** ~$3-4 per unit

**Advantages:**
- ✅ Specifically designed for low-current applications
- ✅ 20-bit ADC provides high resolution
- ✅ 2.5 nA input bias current enables nA measurements
- ✅ I2C interface (same as INA219)
- ✅ Pin-compatible with INA233

**Current Range:**
- With 1Ω shunt: Can measure down to ~10-50 nA
- With 10Ω shunt: Can measure down to ~1-5 nA
- Resolution: Depends on shunt and configuration

**Integration Complexity:** ⭐⭐⭐ (Medium)
- Similar to INA219 but requires more careful design
- PCB layout critical for accuracy
- May require guarding techniques

**Cost:** ~$3-4 per unit

---

#### Option 2: MAX40203AUK+T (Nanoamp Current Sense Amplifier)

**Specifications:**
- **Purpose:** Nanoamp current sense amplifier
- **Ultra-Low Offset:** Designed for nA measurements
- **Low Quiescent Current:** Energy-efficient
- **Package:** SOT23-5 (very small)

**Advantages:**
- ✅ Specifically designed for nanoamp measurements
- ✅ Ultra-low offset voltage
- ✅ Low power consumption

**Disadvantages:**
- ⚠️ Requires external ADC (not integrated like INA228)
- ⚠️ More complex design (amplifier + ADC)
- ⚠️ May need microcontroller for digitization

**Integration Complexity:** ⭐⭐⭐⭐ (High)
- Requires additional ADC
- More complex circuit design
- Higher component count

**Cost:** ~$2-3 per unit (plus ADC cost)

---

#### Option 3: LTC2063 Zero-Drift Amplifier + External ADC

**Specifications:**
- **Input Offset Voltage:** 5 µV maximum
- **Supply Current:** 1.4 µA (extremely low)
- **Type:** Zero-drift operational amplifier
- **Purpose:** Precision high-side current sensing

**Advantages:**
- ✅ Ultra-low offset (5 µV)
- ✅ Extremely low power (1.4 µA)
- ✅ Zero-drift technology
- ✅ Wide dynamic range

**Disadvantages:**
- ⚠️ Requires external ADC
- ⚠️ More complex design
- ⚠️ Requires precision shunt resistor

**Integration Complexity:** ⭐⭐⭐⭐ (High)
- Custom amplifier circuit
- External ADC required
- More design complexity

**Cost:** ~$2-3 per unit (plus ADC and components)

---

#### Option 4: Transimpedance Amplifier (TIA) Approach

**Architecture:**
- High-value feedback resistor (e.g., 20 MΩ)
- Low-input-bias-current op-amp
- Converts current directly to voltage

**Advantages:**
- ✅ Can measure very low currents (nA to pA)
- ✅ Flexible design
- ✅ Can be optimized for specific range

**Disadvantages:**
- ⚠️ Requires careful op-amp selection
- ⚠️ High-value resistors can be noisy
- ⚠️ Requires external ADC
- ⚠️ More complex design

**Integration Complexity:** ⭐⭐⭐⭐⭐ (Very High)
- Custom analog design
- Requires analog expertise
- Sensitive to layout and noise

**Cost:** Variable (depends on components)

---

#### Option 5: Commercial Solutions (Reference)

**NanoRanger (AltoNovus):**
- Measures: 1 nA to 800 mA
- Resolution: 10 pA
- Purpose: Low-cost ammeter for IoT devices
- **Note:** Standalone device, not integrated solution

**tinyCurrent:**
- Shunt and amplifier combination
- Low burden voltage
- Compatible with oscilloscopes
- **Note:** External measurement device

**Use Case:** These are useful for validation and testing, but not for integrated dongle design.

---

### Comparison: Microamp vs Nanoamp Solutions

| Solution | Minimum Current | Resolution | Cost | Complexity | Best For |
|----------|----------------|------------|------|------------|----------|
| **INA219** | 100 μA | 100 μA | $1.50 | ⭐⭐ | General low power |
| **INA228** | 1-10 nA | 1-10 nA | $3-4 | ⭐⭐⭐ | **Nanoamp measurement** |
| **MAX40203** | <1 nA | <1 nA | $2-3 + ADC | ⭐⭐⭐⭐ | Ultra-low current |
| **LTC2063 + ADC** | <1 nA | <1 nA | $2-3 + ADC | ⭐⭐⭐⭐ | Custom solutions |
| **TIA** | pA-nA | pA | Variable | ⭐⭐⭐⭐⭐ | Research/very low |

---

### PCB Design Requirements for Nanoamp Measurement

#### Critical Design Considerations

1. **Guarding:**
   - Guard rings around sensitive traces
   - Reduces leakage currents
   - Essential for nA measurements

2. **Shielding:**
   - Shield sensitive circuits
   - Reduce EMI pickup
   - May require metal enclosure

3. **PCB Material:**
   - Low-leakage PCB materials
   - Avoid moisture-absorbing materials
   - Consider conformal coating

4. **Trace Routing:**
   - Minimize trace lengths
   - Avoid parallel traces (capacitive coupling)
   - Use ground planes effectively

5. **Component Selection:**
   - Low-leakage components
   - Low-temperature-coefficient resistors
   - High-quality capacitors

6. **Power Supply:**
   - Clean, low-noise power supplies
   - Proper decoupling
   - May need linear regulators

---

### Recommended Approach for Nanoamp Measurement

#### Primary Recommendation: **INA228 with Careful Design**

**Why INA228:**
1. **Integrated Solution:** ADC included, no external ADC needed
2. **I2C Interface:** Same interface as INA219 (easy integration)
3. **Proven Technology:** Designed specifically for low-current measurement
4. **Reasonable Cost:** ~$3-4 per unit
5. **Good Resolution:** 20-bit ADC provides nA-level resolution

**Implementation:**
- Use **10Ω shunt resistor** for nA measurements
- Careful PCB layout with guarding
- Proper shielding and grounding
- Calibration routine for accuracy

**Expected Performance:**
- Minimum measurable: ~1-10 nA (depending on shunt)
- Resolution: ~1-10 nA
- Accuracy: Better than INA219, but requires careful design

**Integration with FTDI:**
- Same I2C interface as INA219
- Use FTDI MPSSE I2C mode
- Similar software implementation

---

### Cost Analysis for Nanoamp Solution

| Component | Quantity | Unit Cost | Total Cost |
|-----------|---------|-----------|------------|
| **INA228** | 1 | $3.50 | $3.50 |
| **Shunt Resistor (10Ω)** | 1 | $0.50 | $0.50 |
| **Decoupling Caps** | 2 | $0.10 | $0.20 |
| **Pull-up Resistors** | 2 | $0.02 | $0.04 |
| **Guard Ring (PCB)** | - | - | ~$1.00 |
| **Shielding (optional)** | - | - | ~$2.00 |
| **Total Additional Cost** | | | **~$5-7** |

**Note:** PCB design complexity increases cost (more layers, special materials may be needed).

---

### Implementation Difficulty: Nanoamp vs Microamp

| Aspect | Microamp (INA219) | Nanoamp (INA228) |
|--------|-------------------|------------------|
| **Component Cost** | $1.50 | $3.50 |
| **PCB Complexity** | Standard | Advanced (guarding) |
| **Design Time** | Low | Medium-High |
| **Calibration** | Simple | More complex |
| **Noise Sensitivity** | Low | High |
| **Overall Complexity** | ⭐⭐ | ⭐⭐⭐ |

---

### When to Use Nanoamp Measurement

**Use INA228 (nA) when:**
- ✅ Measuring sleep mode currents (<100 μA)
- ✅ Ultra-low power IoT devices
- ✅ Battery-powered applications
- ✅ Power optimization is critical
- ✅ Need to measure leakage currents

**Use INA219 (μA) when:**
- ✅ General low-power measurement (100 μA - 3A)
- ✅ Active mode power profiling
- ✅ Cost-sensitive applications
- ✅ Simpler PCB design acceptable

---

### Hybrid Approach: Dual Range

**Option:** Include both INA219 and INA228

**Architecture:**
- **INA219:** For active mode (μA to A range)
- **INA228:** For sleep mode (nA to μA range)
- Switch between them or use both simultaneously

**Advantages:**
- ✅ Best of both worlds
- ✅ Wide measurement range
- ✅ Optimized for each range

**Disadvantages:**
- ⚠️ Higher cost (~$5-6 additional)
- ⚠️ More complex design
- ⚠️ Requires switching logic

**Complexity:** ⭐⭐⭐⭐ (High)

---

## References

- [INA219 Datasheet](https://www.ti.com/lit/ds/symlink/ina219.pdf)
- [INA226 Datasheet](https://www.ti.com/lit/ds/symlink/ina226.pdf)
- [INA228 Datasheet](https://www.ti.com/lit/ds/symlink/ina228.pdf)
- [INA260 Datasheet](https://www.ti.com/lit/ds/symlink/ina260.pdf)
- [MAX40203 Datasheet](https://www.maximintegrated.com/en/products/analog/amplifiers/MAX40203.html)
- [LTC2063 Datasheet](https://www.analog.com/en/products/ltc2063.html)
- [Adafruit INA219 Breakout](https://www.adafruit.com/product/904)
- [FTDI MPSSE I2C Application Note](https://ftdichip.com/app-notes/)
- [libftdi Documentation](https://www.intra2net.com/en/developer/libftdi/)
- [NanoRanger Ammeter](https://www.eetimes.com/sensor-network-company-develops-ammeter-heres-why/)
- [tinyCurrent Device](https://n-fuse.co/devices/tinyCurrent-precision-low-Current-Measurement-Shunt-and-Amplifier-Device.html)

