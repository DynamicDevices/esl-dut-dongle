# Bill of Materials (BOM) and Cost Analysis

## Overview

This document provides detailed bill of materials and cost estimates for the ESL DUT dongle project. Costs are estimated for small quantity production (10-100 units) and may vary based on supplier, quantity, and market conditions.

**Last Updated:** November 2024  
**Currency:** USD  
**Quantity Basis:** 50 units (unless otherwise specified)

---

## Configuration Options

### Configuration 1: Basic (FTDI FT2232H + INA219)
- 2 UARTs + GPIO control
- Power monitoring down to 100 μA
- **Target Cost:** ~$15-20 per unit

### Configuration 2: Enhanced (FTDI FT2232H + INA228)
- 2 UARTs + GPIO control
- Power monitoring down to 1-10 nA
- **Target Cost:** ~$18-25 per unit

### Configuration 3: Premium (FTDI FT4232H + INA219)
- 4 UARTs + GPIO control
- Power monitoring down to 100 μA
- **Target Cost:** ~$20-28 per unit

### Configuration 4: Ultimate (FTDI FT4232H + INA228)
- 4 UARTs + GPIO control
- Power monitoring down to 1-10 nA
- **Target Cost:** ~$23-33 per unit

---

## Configuration 1: Basic (FTDI FT2232H + INA219)

### Main Components

| Part Number | Description | Qty | Unit Cost | Total Cost | Supplier Notes |
|-------------|-------------|-----|-----------|------------|----------------|
| **FT2232H-56Q** | FTDI USB-to-Dual-UART + MPSSE | 1 | $4.50 | $4.50 | DigiKey, Mouser |
| **INA219BIDCNT** | Power Monitor IC (I2C) | 1 | $1.50 | $1.50 | DigiKey, Mouser |
| **0.1Ω 1% Shunt** | Current sense resistor (0.1Ω, 1W) | 1 | $0.20 | $0.20 | DigiKey, Mouser |
| **10kΩ Resistor** | I2C pull-up (0805) | 2 | $0.02 | $0.04 | DigiKey, Mouser |
| **0.1μF Capacitor** | Decoupling (0805, X7R) | 4 | $0.05 | $0.20 | DigiKey, Mouser |
| **10μF Capacitor** | Power supply decoupling (0805) | 2 | $0.08 | $0.16 | DigiKey, Mouser |

**Subtotal - Main Components:** $6.80

### Connectors and Mechanical

| Part Number | Description | Qty | Unit Cost | Total Cost | Notes |
|-------------|-------------|-----|-----------|------------|-------|
| **USB-C Connector** | USB Type-C receptacle | 1 | $0.50 | $0.50 | Or USB-B Micro |
| **Header Pins** | 2.54mm pitch, male | 20 | $0.01 | $0.20 | For target board connection |
| **Header Sockets** | 2.54mm pitch, female | 20 | $0.01 | $0.20 | Alternative to pins |
| **LED** | Status LED (0805, red/green) | 2 | $0.05 | $0.10 | Optional |
| **Resistor (LED)** | Current limiting (1kΩ, 0805) | 2 | $0.02 | $0.04 | For LEDs |

**Subtotal - Connectors:** $1.04

### PCB and Assembly

| Item | Description | Cost | Notes |
|------|-------------|------|-------|
| **PCB (2-layer)** | 50mm x 30mm, 2-layer, FR4 | $2.50 | JLCPCB, PCBWay (50 units) |
| **PCB (4-layer)** | 50mm x 30mm, 4-layer, FR4 | $4.00 | If needed for better routing |
| **SMT Assembly** | Pick and place + reflow | $3.00 | JLCPCB assembly service |
| **Stencil** | Solder paste stencil | $0.50 | One-time cost (amortized) |

**Subtotal - PCB/Assembly:** $6.00 (2-layer) or $7.50 (4-layer)

### Enclosure (Optional)

| Item | Description | Cost | Notes |
|------|-------------|------|-------|
| **3D Printed Case** | Custom enclosure | $2.00 | 3D printing service |
| **Screws/Standoffs** | M2 hardware | $0.50 | For mounting |

**Subtotal - Enclosure:** $2.50

### Total Cost - Configuration 1

**Without Enclosure:**
- Components: $6.80
- Connectors: $1.04
- PCB/Assembly: $6.00
- **Total: $13.84 per unit**

**With Enclosure:**
- Base: $13.84
- Enclosure: $2.50
- **Total: $16.34 per unit**

**Estimated Retail Price (2x markup):** $27-33

---

## Configuration 2: Enhanced (FTDI FT2232H + INA228)

### Main Components

| Part Number | Description | Qty | Unit Cost | Total Cost | Notes |
|-------------|-------------|-----|-----------|------------|-------|
| **FT2232H-56Q** | FTDI USB-to-Dual-UART + MPSSE | 1 | $4.50 | $4.50 | Same as Config 1 |
| **INA228AIDCNT** | Power Monitor IC (I2C, 20-bit) | 1 | $3.50 | $3.50 | Nanoamp capable |
| **10Ω 1% Shunt** | Current sense resistor (10Ω, 0.5W) | 1 | $0.50 | $0.50 | For nA measurements |
| **0.1Ω 1% Shunt** | Current sense resistor (0.1Ω, 1W) | 1 | $0.20 | $0.20 | Optional: dual range |
| **10kΩ Resistor** | I2C pull-up (0805) | 2 | $0.02 | $0.04 | Same as Config 1 |
| **0.1μF Capacitor** | Decoupling (0805, X7R) | 4 | $0.05 | $0.20 | Same as Config 1 |
| **10μF Capacitor** | Power supply decoupling (0805) | 2 | $0.08 | $0.16 | Same as Config 1 |

**Subtotal - Main Components:** $9.10 (single shunt) or $9.30 (dual shunt)

### Connectors and Mechanical

Same as Configuration 1: **$1.04**

### PCB and Assembly

| Item | Description | Cost | Notes |
|------|-------------|------|-------|
| **PCB (4-layer)** | 50mm x 30mm, 4-layer, FR4 | $4.00 | Recommended for guarding |
| **SMT Assembly** | Pick and place + reflow | $3.00 | Same as Config 1 |
| **Stencil** | Solder paste stencil | $0.50 | One-time cost |

**Subtotal - PCB/Assembly:** $7.50

### Enclosure (Optional)

Same as Configuration 1: **$2.50**

### Total Cost - Configuration 2

**Without Enclosure:**
- Components: $9.10
- Connectors: $1.04
- PCB/Assembly: $7.50
- **Total: $17.64 per unit**

**With Enclosure:**
- Base: $17.64
- Enclosure: $2.50
- **Total: $20.14 per unit**

**Estimated Retail Price (2x markup):** $34-40

---

## Configuration 3: Premium (FTDI FT4232H + INA219)

### Main Components

| Part Number | Description | Qty | Unit Cost | Total Cost | Notes |
|-------------|-------------|-----|-----------|------------|-------|
| **FT4232H-56Q** | FTDI USB-to-Quad-UART + MPSSE | 1 | $6.50 | $6.50 | 4 UARTs |
| **INA219BIDCNT** | Power Monitor IC (I2C) | 1 | $1.50 | $1.50 | Same as Config 1 |
| **0.1Ω 1% Shunt** | Current sense resistor (0.1Ω, 1W) | 1 | $0.20 | $0.20 | Same as Config 1 |
| **10kΩ Resistor** | I2C pull-up (0805) | 2 | $0.02 | $0.04 | Same as Config 1 |
| **0.1μF Capacitor** | Decoupling (0805, X7R) | 6 | $0.05 | $0.30 | More caps for 4 UARTs |
| **10μF Capacitor** | Power supply decoupling (0805) | 2 | $0.08 | $0.16 | Same as Config 1 |

**Subtotal - Main Components:** $8.76

### Connectors and Mechanical

| Part Number | Description | Qty | Unit Cost | Total Cost | Notes |
|-------------|-------------|-----|-----------|------------|-------|
| **USB-C Connector** | USB Type-C receptacle | 1 | $0.50 | $0.50 | Same as Config 1 |
| **Header Pins** | 2.54mm pitch, male | 30 | $0.01 | $0.30 | More pins for 4 UARTs |
| **LED** | Status LED (0805, red/green) | 2 | $0.05 | $0.10 | Same as Config 1 |
| **Resistor (LED)** | Current limiting (1kΩ, 0805) | 2 | $0.02 | $0.04 | Same as Config 1 |

**Subtotal - Connectors:** $0.94

### PCB and Assembly

Same as Configuration 1: **$6.00** (2-layer) or **$7.50** (4-layer)

### Enclosure (Optional)

Same as Configuration 1: **$2.50**

### Total Cost - Configuration 3

**Without Enclosure:**
- Components: $8.76
- Connectors: $0.94
- PCB/Assembly: $6.00
- **Total: $15.70 per unit**

**With Enclosure:**
- Base: $15.70
- Enclosure: $2.50
- **Total: $18.20 per unit**

**Estimated Retail Price (2x markup):** $31-37

---

## Configuration 4: Ultimate (FTDI FT4232H + INA228)

### Main Components

| Part Number | Description | Qty | Unit Cost | Total Cost | Notes |
|-------------|-------------|-----|-----------|------------|-------|
| **FT4232H-56Q** | FTDI USB-to-Quad-UART + MPSSE | 1 | $6.50 | $6.50 | Same as Config 3 |
| **INA228AIDCNT** | Power Monitor IC (I2C, 20-bit) | 1 | $3.50 | $3.50 | Same as Config 2 |
| **10Ω 1% Shunt** | Current sense resistor (10Ω, 0.5W) | 1 | $0.50 | $0.50 | Same as Config 2 |
| **0.1Ω 1% Shunt** | Current sense resistor (0.1Ω, 1W) | 1 | $0.20 | $0.20 | Optional: dual range |
| **10kΩ Resistor** | I2C pull-up (0805) | 2 | $0.02 | $0.04 | Same as Config 1 |
| **0.1μF Capacitor** | Decoupling (0805, X7R) | 6 | $0.05 | $0.30 | Same as Config 3 |
| **10μF Capacitor** | Power supply decoupling (0805) | 2 | $0.08 | $0.16 | Same as Config 1 |

**Subtotal - Main Components:** $11.20 (single shunt) or $11.40 (dual shunt)

### Connectors and Mechanical

Same as Configuration 3: **$0.94**

### PCB and Assembly

Same as Configuration 2: **$7.50** (4-layer recommended)

### Enclosure (Optional)

Same as Configuration 1: **$2.50**

### Total Cost - Configuration 4

**Without Enclosure:**
- Components: $11.20
- Connectors: $0.94
- PCB/Assembly: $7.50
- **Total: $19.64 per unit**

**With Enclosure:**
- Base: $19.64
- Enclosure: $2.50
- **Total: $22.14 per unit**

**Estimated Retail Price (2x markup):** $39-45

---

## Cost Summary Table

| Configuration | Description | Cost (No Enclosure) | Cost (With Enclosure) | Retail Est. |
|---------------|-------------|---------------------|----------------------|-------------|
| **1. Basic** | FT2232H + INA219 | $13.84 | $16.34 | $27-33 |
| **2. Enhanced** | FT2232H + INA228 | $17.64 | $20.14 | $34-40 |
| **3. Premium** | FT4232H + INA219 | $15.70 | $18.20 | $31-37 |
| **4. Ultimate** | FT4232H + INA228 | $19.64 | $22.14 | $39-45 |

---

## Additional Costs (One-Time)

### Development and Tooling

| Item | Cost | Notes |
|------|------|-------|
| **PCB Design Software** | $0-500 | KiCad (free) or Altium ($) |
| **Component Samples** | $50-100 | Initial testing |
| **Prototype PCBs** | $20-50 | 5-10 boards for testing |
| **Assembly Setup** | $0-200 | If doing in-house assembly |
| **Testing Equipment** | $100-500 | Multimeter, oscilloscope, etc. |
| **Certification (if needed)** | $500-2000 | FCC, CE, etc. (if commercial) |

**Total Development Cost:** $670-3,350 (one-time)

### Software Development

| Item | Cost | Notes |
|------|------|-------|
| **Driver Development** | $0 | Use libftdi (open-source) |
| **Control Software** | $0-500 | Python/C++ development time |
| **Documentation** | $0-200 | User manual, API docs |

**Total Software Cost:** $0-700 (one-time)

---

## Quantity Discounts

### Component Pricing (Volume)

| Quantity | FT2232H | FT4232H | INA219 | INA228 | Discount |
|----------|---------|---------|--------|--------|----------|
| **10 units** | $4.50 | $6.50 | $1.50 | $3.50 | 0% |
| **50 units** | $4.50 | $6.50 | $1.50 | $3.50 | 0% |
| **100 units** | $4.20 | $6.00 | $1.35 | $3.20 | ~5-10% |
| **500 units** | $3.80 | $5.50 | $1.20 | $2.90 | ~15-20% |
| **1000 units** | $3.50 | $5.00 | $1.10 | $2.70 | ~20-25% |

### PCB Pricing (Volume)

| Quantity | 2-Layer | 4-Layer | Notes |
|----------|---------|---------|-------|
| **10 units** | $3.50 | $5.50 | Higher setup cost |
| **50 units** | $2.50 | $4.00 | Standard pricing |
| **100 units** | $2.00 | $3.50 | Volume discount |
| **500 units** | $1.50 | $2.50 | Significant discount |
| **1000 units** | $1.20 | $2.00 | Best pricing |

---

## Assembly Options

### Option 1: JLCPCB Assembly Service

**Pros:**
- ✅ Low cost ($3-5 per board)
- ✅ Good quality
- ✅ Fast turnaround (1-2 weeks)
- ✅ Handles most components

**Cons:**
- ⚠️ Limited component selection
- ⚠️ May need to source some parts separately

**Cost:** $3-5 per board (50 units)

### Option 2: Local Assembly House

**Pros:**
- ✅ Full component selection
- ✅ Better support
- ✅ Can handle special requirements

**Cons:**
- ⚠️ Higher cost ($5-10 per board)
- ⚠️ Longer lead time

**Cost:** $5-10 per board (50 units)

### Option 3: In-House Assembly

**Pros:**
- ✅ Full control
- ✅ No minimum quantities
- ✅ Fast iteration

**Cons:**
- ⚠️ Requires equipment (reflow oven, pick & place)
- ⚠️ Time investment
- ⚠️ Quality control responsibility

**Cost:** Equipment ($500-2000) + time

---

## Recommended Configuration

### For Development/Prototyping: **Configuration 1 (Basic)**

**Rationale:**
- Lowest cost ($13.84)
- Meets all core requirements
- Easy to prototype and test
- Can upgrade to INA228 later if needed

### For Production: **Configuration 2 (Enhanced)**

**Rationale:**
- Nanoamp measurement capability
- Still reasonable cost ($17.64)
- Better for low-power development work
- Good balance of features and cost

### For Maximum Features: **Configuration 4 (Ultimate)**

**Rationale:**
- 4 UARTs (future-proof)
- Nanoamp measurement
- Best for comprehensive testing
- Higher cost but maximum capability

---

## Cost Breakdown Example (Configuration 2)

**Per Unit Cost (50 units):**
- Main ICs: $8.00 (FT2232H + INA228)
- Passives/Resistors: $0.64
- Connectors: $1.04
- PCB (4-layer): $4.00
- Assembly: $3.00
- **Subtotal: $16.68**

**With 20% margin for overhead:**
- Base cost: $16.68
- Overhead (20%): $3.34
- **Total: $20.02**

**With Enclosure:**
- Base: $20.02
- Enclosure: $2.50
- **Total: $22.52**

---

## Notes and Assumptions

1. **Component Pricing:**
   - Based on DigiKey/Mouser pricing (November 2024)
   - Small quantity pricing (50 units)
   - Prices may vary by supplier and region

2. **PCB Costs:**
   - Based on JLCPCB/PCBWay pricing
   - Standard FR4, 1.6mm thickness
   - Includes shipping (amortized)

3. **Assembly Costs:**
   - Based on JLCPCB assembly service
   - Assumes standard SMT components
   - May vary for hand-assembly or local services

4. **Currency:**
   - All prices in USD
   - Exchange rates may affect international pricing

5. **Volume Discounts:**
   - Significant discounts available at 500+ units
   - Component pricing improves at higher volumes
   - PCB costs decrease substantially

6. **Design Complexity:**
   - Assumes standard 2-layer PCB for basic configs
   - 4-layer recommended for nanoamp measurements
   - May need additional layers for complex routing

---

## Future Cost Optimization

1. **Custom Shunt Resistors:**
   - May be able to reduce cost with custom values
   - Bulk purchasing of precision resistors

2. **Alternative Suppliers:**
   - LCSC for some components (lower cost)
   - Direct manufacturer pricing at higher volumes

3. **PCB Optimization:**
   - Reduce board size to lower PCB cost
   - Optimize layer count based on requirements

4. **Assembly Optimization:**
   - Use JLCPCB's component library for better pricing
   - Consider panelization for lower per-unit cost

---

## References

- [DigiKey](https://www.digikey.com/)
- [Mouser Electronics](https://www.mouser.com/)
- [JLCPCB](https://jlcpcb.com/)
- [PCBWay](https://www.pcbway.com/)
- [LCSC](https://www.lcsc.com/)

---

## Revision History

- **v1.0** (November 2024): Initial BOM and cost analysis
  - All four configurations defined
  - Component pricing researched
  - Assembly options documented

