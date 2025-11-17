# Shunt Resistor Selection - RESOLVED

## Solution: Dual-Range Power Monitoring

**Final Design Decision:**
- Power Monitors: INA219 + INA228 (dual range)
- Shunt Resistors: 10Ω (INA219) + 0.01Ω (INA228)
- Measurement Range: nA to A (full coverage)

**Rationale:**
- INA219 with 10Ω shunt: 1μA to 32mA range (μA measurements)
- INA228 with 0.01Ω shunt: nA to A range (nanoamp measurements)
- Provides complete coverage from nanoamps to amps

## Shunt Resistor Requirements

### For INA219 (1μA minimum):

**Option 1: 1Ω Shunt**
- Voltage at 1μA: 1μA × 1Ω = 1μV (marginal, near resolution limit)
- Maximum current: 320mA (before hitting ±320mV limit)
- Range: 1μA to 320mA

**Option 2: 10Ω Shunt** (Recommended)
- Voltage at 1μA: 1μA × 10Ω = 10μV (good signal level)
- Maximum current: 32mA (before hitting ±320mV limit)
- Range: 1μA to 32mA
- **Better accuracy at 1μA**

### For INA228 (nanoamp measurements):

**0.01Ω Shunt is appropriate**
- INA228 has much higher resolution (20-bit ADC)
- Can measure nanoamp levels with 0.01Ω shunt
- Range: nA to A levels

## Design Options

### Option A: INA219 with Correct Shunt
- **Power Monitor:** INA219
- **Shunt:** 1Ω or 10Ω (not 0.01Ω)
- **Range:** 1μA to 32mA (with 10Ω) or 320mA (with 1Ω)
- **Cost:** Lower (~$1.50)

### Option B: INA228 with 0.01Ω Shunt
- **Power Monitor:** INA228
- **Shunt:** 0.01Ω (current spec)
- **Range:** nA to A levels
- **Cost:** Higher (~$3.50)

### Option C: Dual Range (Both INA219 and INA228)
- **Power Monitors:** INA219 + INA228
- **Shunts:** 10Ω (INA219) + 0.01Ω (INA228)
- **Range:** nA to A (full coverage)
- **Cost:** Highest (~$5.00)

## Final Decision

**✅ RESOLVED: Using Both Parts (Option C)**

- **INA219:** 10Ω shunt for μA range (1μA to 32mA)
- **INA228:** 0.01Ω shunt for nA range (nA to A)
- **Q4 Updated:** Dual range (INA219 + INA228)
- **Q5 Updated:** Dual shunts: 10Ω + 0.01Ω

This provides complete current measurement coverage from nanoamps to amps.

