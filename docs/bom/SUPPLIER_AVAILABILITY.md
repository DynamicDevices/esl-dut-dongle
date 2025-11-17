# Supplier Availability and Pricing Research

## Overview

This document provides a structured approach to researching component availability and pricing from Future Electronics (primary), Mouser, and DigiKey. It includes part numbers, supplier-specific notes, and guidance on where to find alternatives if needed.

**Last Updated:** November 2024  
**Status:** Research Template - Requires actual supplier queries

---

## Research Methodology

### Tools Available

1. **Mouser Price and Availability Assistant**
   - Upload BOM (up to 200 part numbers)
   - Real-time pricing and stock levels
   - Suggests alternatives for unavailable parts
   - Link: https://www.mouser.com/price-availability-assistant/

2. **DigiKey myLists Tool**
   - Upload BOM for pricing and availability
   - Live stock status
   - Substitute product suggestions
   - Link: https://www.digikey.com/en/resources/bom-manager

3. **Octopart BOM Tool**
   - Aggregates data from multiple distributors
   - Includes Future Electronics, Mouser, DigiKey
   - Real-time pricing and availability
   - Link: https://octopart.com/

4. **Future Electronics**
   - **Note:** Future Electronics typically requires direct contact for pricing
   - Contact local Future Electronics sales representative
   - May offer better pricing for main ICs at volume
   - Website: https://www.futureelectronics.com/

---

## Main ICs - Availability Research

### FT2232H-56Q (FTDI USB-to-Dual-UART + MPSSE)

| Supplier | Status | Price (50 qty) | Lead Time | Notes | Action Required |
|----------|--------|----------------|-----------|-------|-----------------|
| **Future Electronics** | ⏳ To Check | TBD | TBD | Primary distributor - contact sales rep | **Contact Future Electronics** |
| **Mouser** | ⏳ To Check | TBD | TBD | Check Mouser.com for stock | Check Mouser website |
| **DigiKey** | ⏳ To Check | TBD | TBD | Check DigiKey.com for stock | Check DigiKey website |

**Alternative Part Numbers:**
- FT2232H-56Q (QFN-56 package) - Standard
- FT2232HL-REEL (Tape and reel) - For production
- Check for package variations if needed

**Alternative Suppliers (if unavailable):**
- Arrow Electronics
- Avnet
- TTI

**Research Notes:**
- FTDI chips are generally well-stocked
- Future Electronics is FTDI authorized distributor
- May have better pricing at volume through Future Electronics

---

### FT4232H-56Q (FTDI USB-to-Quad-UART + MPSSE)

| Supplier | Status | Price (50 qty) | Lead Time | Notes | Action Required |
|----------|--------|----------------|-----------|-------|-----------------|
| **Future Electronics** | ⏳ To Check | TBD | TBD | Primary distributor - contact sales rep | **Contact Future Electronics** |
| **Mouser** | ⏳ To Check | TBD | TBD | Check Mouser.com for stock | Check Mouser website |
| **DigiKey** | ⏳ To Check | TBD | TBD | Check DigiKey.com for stock | Check DigiKey website |

**Alternative Part Numbers:**
- FT4232H-56Q (QFN-56 package) - Standard
- FT4232HL-REEL (Tape and reel) - For production

**Alternative Suppliers (if unavailable):**
- Arrow Electronics
- Avnet
- TTI

**Research Notes:**
- Similar availability to FT2232H
- Future Electronics recommended for volume pricing

---

### INA219BIDCNT (Texas Instruments Power Monitor)

| Supplier | Status | Price (50 qty) | Lead Time | Notes | Action Required |
|----------|--------|----------------|-----------|-------|-----------------|
| **Future Electronics** | ⏳ To Check | TBD | TBD | Primary distributor - contact sales rep | **Contact Future Electronics** |
| **Mouser** | ⏳ To Check | TBD | TBD | Check Mouser.com for stock | Check Mouser website |
| **DigiKey** | ⏳ To Check | TBD | TBD | Check DigiKey.com for stock | Check DigiKey website |

**Alternative Part Numbers:**
- INA219BIDCNT (SOT-23-8 package) - Standard
- INA219AIDCNR (Tape and reel) - For production
- INA219BID (Different package option)

**Alternative Suppliers (if unavailable):**
- Arrow Electronics
- Avnet
- Newark

**Research Notes:**
- TI parts widely available
- Future Electronics is TI authorized distributor
- Common part, should be readily available

---

### INA228AIDCNT (Texas Instruments Power Monitor - 20-bit)

| Supplier | Status | Price (50 qty) | Lead Time | Notes | Action Required |
|----------|--------|----------------|-----------|-------|-----------------|
| **Future Electronics** | ⏳ To Check | TBD | TBD | Primary distributor - contact sales rep | **Contact Future Electronics** |
| **Mouser** | ⏳ To Check | TBD | TBD | Check Mouser.com for stock | Check Mouser website |
| **DigiKey** | ⏳ To Check | TBD | TBD | Check DigiKey.com for stock | Check DigiKey website |

**Alternative Part Numbers:**
- INA228AIDCNT (SOT-23-8 package) - Standard
- INA228AIDCNR (Tape and reel) - For production

**Alternative Suppliers (if unavailable):**
- Arrow Electronics
- Avnet
- Newark

**Research Notes:**
- Newer part than INA219
- May have limited stock initially
- Future Electronics recommended for TI parts

---

## Passive Components - Availability Research

### 0.1Ω 1% Shunt Resistor (1W)

**Recommended Manufacturers:**
- Vishay (WSR series)
- Bourns (CSS series)
- Yageo (LR series)

| Supplier | Status | Price (50 qty) | Lead Time | Part Number | Action Required |
|----------|--------|----------------|-----------|-------------|-----------------|
| **Mouser** | ⏳ To Check | TBD | TBD | Search: "0.1 ohm 1% 1W shunt" | Check Mouser website |
| **DigiKey** | ⏳ To Check | TBD | TBD | Search: "0.1 ohm 1% 1W shunt" | Check DigiKey website |

**Suggested Part Numbers:**
- Vishay WSR2R1000FEA (0.1Ω, 1%, 2W, 2512)
- Bourns CSS2H-2512R-L100F (0.1Ω, 1%, 2W, 2512)
- Yageo LR2512-F-R100-F (0.1Ω, 1%, 1W, 2512)

**Alternative Suppliers (if unavailable):**
- LCSC (for lower cost options)
- Arrow Electronics
- Newark

**Research Notes:**
- Shunt resistors are common parts
- Multiple manufacturers available
- Consider package size (2512 recommended for 1W)

---

### 10Ω 1% Shunt Resistor (0.5W)

**Recommended Manufacturers:**
- Vishay
- Bourns
- Yageo

| Supplier | Status | Price (50 qty) | Lead Time | Part Number | Action Required |
|----------|--------|----------------|-----------|-------------|-----------------|
| **Mouser** | ⏳ To Check | TBD | TBD | Search: "10 ohm 1% 0.5W shunt" | Check Mouser website |
| **DigiKey** | ⏳ To Check | TBD | TBD | Search: "10 ohm 1% 0.5W shunt" | Check DigiKey website |

**Suggested Part Numbers:**
- Vishay WSR2R1000FEA (10Ω variant)
- Bourns CSS2H-2512R-L10F (10Ω, 1%, 0.5W, 2512)
- Yageo LR2512-F-R10-F (10Ω, 1%, 0.5W, 2512)

**Alternative Suppliers (if unavailable):**
- LCSC
- Arrow Electronics
- Newark

**Research Notes:**
- Less common than 0.1Ω
- May need to search multiple manufacturers
- Consider 1206 or 2512 package

---

### 10kΩ Resistor (0805, I2C Pull-up)

**Recommended Manufacturers:**
- Yageo
- Panasonic
- Vishay
- KOA Speer

| Supplier | Status | Price (50 qty) | Lead Time | Part Number | Action Required |
|----------|--------|----------------|-----------|-------------|-----------------|
| **Mouser** | ⏳ To Check | TBD | TBD | Search: "10k ohm 0805 1%" | Check Mouser website |
| **DigiKey** | ⏳ To Check | TBD | TBD | Search: "10k ohm 0805 1%" | Check DigiKey website |

**Suggested Part Numbers:**
- Yageo RC0805FR-0710KL (10kΩ, 1%, 0805)
- Panasonic ERJ-6ENF1002V (10kΩ, 1%, 0805)
- Vishay CRCW080510K0FKEA (10kΩ, 1%, 0805)

**Alternative Suppliers (if unavailable):**
- LCSC (very low cost)
- Arrow Electronics
- Newark

**Research Notes:**
- Very common part
- Should be readily available
- Multiple manufacturers
- Low cost (<$0.01 in volume)

---

### 0.1μF Capacitor (0805, X7R)

**Recommended Manufacturers:**
- Murata
- TDK
- Yageo
- Samsung

| Supplier | Status | Price (50 qty) | Lead Time | Part Number | Action Required |
|----------|--------|----------------|-----------|-------------|-----------------|
| **Mouser** | ⏳ To Check | TBD | TBD | Search: "0.1uF 0805 X7R 50V" | Check Mouser website |
| **DigiKey** | ⏳ To Check | TBD | TBD | Search: "0.1uF 0805 X7R 50V" | Check DigiKey website |

**Suggested Part Numbers:**
- Murata GRM21BR71H104KA01L (0.1μF, X7R, 50V, 0805)
- TDK C2012X7R1H104K (0.1μF, X7R, 50V, 0805)
- Yageo CC0805KRX7R9BB104 (0.1μF, X7R, 50V, 0805)

**Alternative Suppliers (if unavailable):**
- LCSC (very low cost)
- Arrow Electronics
- Newark

**Research Notes:**
- Extremely common part
- Should be readily available
- Very low cost (<$0.01 in volume)
- Multiple manufacturers

---

### 10μF Capacitor (0805, X7R or X5R)

**Recommended Manufacturers:**
- Murata
- TDK
- Samsung

| Supplier | Status | Price (50 qty) | Lead Time | Part Number | Action Required |
|----------|--------|----------------|-----------|-------------|-----------------|
| **Mouser** | ⏳ To Check | TBD | TBD | Search: "10uF 0805 X5R 25V" | Check Mouser website |
| **DigiKey** | ⏳ To Check | TBD | TBD | Search: "10uF 0805 X5R 25V" | Check DigiKey website |

**Suggested Part Numbers:**
- Murata GRM21BR61E106ME15L (10μF, X5R, 25V, 0805)
- TDK C2012X5R1E106K (10μF, X5R, 25V, 0805)
- Samsung CL21A106KAYNNNE (10μF, X5R, 25V, 0805)

**Alternative Suppliers (if unavailable):**
- LCSC
- Arrow Electronics
- Newark

**Research Notes:**
- Common part but less so than 0.1μF
- May need to check multiple manufacturers
- Consider 1206 package if 0805 unavailable
- X5R more common than X7R for 10μF

---

## Connectors and Mechanical - Availability Research

### USB Type-C Connector

**Recommended Manufacturers:**
- Molex
- TE Connectivity
- JAE
- Hirose

| Supplier | Status | Price (50 qty) | Lead Time | Part Number | Action Required |
|----------|--------|----------------|-----------|-------------|-----------------|
| **Mouser** | ⏳ To Check | TBD | TBD | Search: "USB-C receptacle SMT" | Check Mouser website |
| **DigiKey** | ⏳ To Check | TBD | TBD | Search: "USB-C receptacle SMT" | Check DigiKey website |

**Suggested Part Numbers:**
- Molex 1054500101 (USB-C receptacle, SMT)
- TE Connectivity 292303-1 (USB-C receptacle, SMT)
- JAE DX07S024JJ1R1500 (USB-C receptacle, SMT)

**Alternative:**
- USB Micro-B connector (more common, lower cost)
- Molex 47346-0001 (USB Micro-B, SMT)

**Alternative Suppliers (if unavailable):**
- Arrow Electronics
- Newark
- TME (for some connectors)

**Research Notes:**
- USB-C connectors have many variants
- Check pin count and mounting style
- USB Micro-B is simpler alternative
- Consider mechanical requirements

---

### Header Pins (2.54mm pitch, male)

**Recommended Manufacturers:**
- Samtec
- Sullins
- TE Connectivity
- 3M

| Supplier | Status | Price (50 qty) | Lead Time | Part Number | Action Required |
|----------|--------|----------------|-----------|-------------|-----------------|
| **Mouser** | ⏳ To Check | TBD | TBD | Search: "header pin 2.54mm male" | Check Mouser website |
| **DigiKey** | ⏳ To Check | TBD | TBD | Search: "header pin 2.54mm male" | Check DigiKey website |

**Suggested Part Numbers:**
- Samtec TSW-102-07-G-S (2.54mm, 2x1, gold)
- Sullins PRPC002SAAN-RC (2.54mm, 2x1, tin)
- Generic 2.54mm headers widely available

**Alternative Suppliers (if unavailable):**
- LCSC (very low cost)
- Arrow Electronics
- Newark

**Research Notes:**
- Very common part
- Multiple manufacturers
- Low cost
- Consider plating (gold vs tin)

---

### Header Sockets (2.54mm pitch, female)

**Recommended Manufacturers:**
- Samtec
- Sullins
- TE Connectivity

| Supplier | Status | Price (50 qty) | Lead Time | Part Number | Action Required |
|----------|--------|----------------|-----------|-------------|-----------------|
| **Mouser** | ⏳ To Check | TBD | TBD | Search: "header socket 2.54mm female" | Check Mouser website |
| **DigiKey** | ⏳ To Check | TBD | TBD | Search: "header socket 2.54mm female" | Check DigiKey website |

**Suggested Part Numbers:**
- Samtec SSW-102-01-G-S (2.54mm, 2x1, gold)
- Sullins SFH11-PBPC-D10-ST-BK (2.54mm, 2x1, tin)

**Alternative Suppliers (if unavailable):**
- LCSC
- Arrow Electronics
- Newark

**Research Notes:**
- Common part
- Multiple manufacturers
- Low cost

---

### LED (0805, red/green)

**Recommended Manufacturers:**
- Kingbright
- Lite-On
- Osram
- Vishay

| Supplier | Status | Price (50 qty) | Lead Time | Part Number | Action Required |
|----------|--------|----------------|-----------|-------------|-----------------|
| **Mouser** | ⏳ To Check | TBD | TBD | Search: "LED 0805 red green" | Check Mouser website |
| **DigiKey** | ⏳ To Check | TBD | TBD | Search: "LED 0805 red green" | Check DigiKey website |

**Suggested Part Numbers:**
- Kingbright APT1608SRCPRV (0805, red)
- Kingbright APT1608SGC (0805, green)
- Lite-On LTST-C170KGKT (0805, green)

**Alternative Suppliers (if unavailable):**
- LCSC
- Arrow Electronics
- Newark

**Research Notes:**
- Very common parts
- Multiple manufacturers
- Low cost
- Consider brightness requirements

---

### LED Current Limiting Resistor (1kΩ, 0805)

**Same as 10kΩ resistor section above - use 1kΩ variant**

| Supplier | Status | Price (50 qty) | Lead Time | Part Number | Action Required |
|----------|--------|----------------|-----------|-------------|-----------------|
| **Mouser** | ⏳ To Check | TBD | TBD | Search: "1k ohm 0805 1%" | Check Mouser website |
| **DigiKey** | ⏳ To Check | TBD | TBD | Search: "1k ohm 0805 1%" | Check DigiKey website |

**Suggested Part Numbers:**
- Yageo RC0805FR-071KL (1kΩ, 1%, 0805)
- Panasonic ERJ-6ENF1001V (1kΩ, 1%, 0805)

---

## Research Checklist

### Phase 1: Main ICs (Priority)

- [ ] **FT2232H-56Q**
  - [ ] Contact Future Electronics sales rep for pricing
  - [ ] Check Mouser.com for availability and price
  - [ ] Check DigiKey.com for availability and price
  - [ ] Compare pricing across suppliers
  - [ ] Note lead times

- [ ] **FT4232H-56Q**
  - [ ] Contact Future Electronics sales rep for pricing
  - [ ] Check Mouser.com for availability and price
  - [ ] Check DigiKey.com for availability and price
  - [ ] Compare pricing across suppliers
  - [ ] Note lead times

- [ ] **INA219BIDCNT**
  - [ ] Contact Future Electronics sales rep for pricing
  - [ ] Check Mouser.com for availability and price
  - [ ] Check DigiKey.com for availability and price
  - [ ] Compare pricing across suppliers
  - [ ] Note lead times

- [ ] **INA228AIDCNT**
  - [ ] Contact Future Electronics sales rep for pricing
  - [ ] Check Mouser.com for availability and price
  - [ ] Check DigiKey.com for availability and price
  - [ ] Compare pricing across suppliers
  - [ ] Note lead times

### Phase 2: Passive Components

- [ ] **0.1Ω Shunt Resistor**
  - [ ] Search Mouser for available part numbers
  - [ ] Search DigiKey for available part numbers
  - [ ] Compare pricing and availability
  - [ ] Select best option

- [ ] **10Ω Shunt Resistor**
  - [ ] Search Mouser for available part numbers
  - [ ] Search DigiKey for available part numbers
  - [ ] Compare pricing and availability
  - [ ] Select best option

- [ ] **10kΩ Resistor (I2C pull-up)**
  - [ ] Search Mouser for available part numbers
  - [ ] Search DigiKey for available part numbers
  - [ ] Compare pricing and availability
  - [ ] Select best option

- [ ] **0.1μF Capacitor**
  - [ ] Search Mouser for available part numbers
  - [ ] Search DigiKey for available part numbers
  - [ ] Compare pricing and availability
  - [ ] Select best option

- [ ] **10μF Capacitor**
  - [ ] Search Mouser for available part numbers
  - [ ] Search DigiKey for available part numbers
  - [ ] Compare pricing and availability
  - [ ] Select best option

### Phase 3: Connectors and Mechanical

- [ ] **USB Type-C Connector**
  - [ ] Search Mouser for available part numbers
  - [ ] Search DigiKey for available part numbers
  - [ ] Compare pricing and availability
  - [ ] Consider USB Micro-B as alternative
  - [ ] Select best option

- [ ] **Header Pins**
  - [ ] Search Mouser for available part numbers
  - [ ] Search DigiKey for available part numbers
  - [ ] Compare pricing and availability
  - [ ] Select best option

- [ ] **Header Sockets**
  - [ ] Search Mouser for available part numbers
  - [ ] Search DigiKey for available part numbers
  - [ ] Compare pricing and availability
  - [ ] Select best option

- [ ] **LEDs**
  - [ ] Search Mouser for available part numbers
  - [ ] Search DigiKey for available part numbers
  - [ ] Compare pricing and availability
  - [ ] Select best option

---

## Alternative Suppliers Reference

### If Components Unavailable from Primary Suppliers

**Authorized Distributors:**
- **Arrow Electronics** - Large inventory, good for ICs
- **Avnet** - Comprehensive component selection
- **TTI** - Specialized in passives and connectors
- **Newark** - Good selection, competitive pricing

**Alternative Sources:**
- **LCSC** - Low-cost components (especially passives)
- **TME** - European distributor, good for some parts
- **RS Components** - Good selection, international

**Component-Specific Alternatives:**
- **Shunt Resistors:** Check Vishay, Bourns, Yageo directly
- **Capacitors:** Check Murata, TDK, Samsung directly
- **Connectors:** Check Molex, TE Connectivity directly

---

## Pricing Notes

### Future Electronics
- **Contact Required:** Future Electronics typically requires direct contact for pricing
- **Volume Pricing:** May offer better pricing at higher volumes
- **Relationship:** Establishing relationship with sales rep recommended
- **Lead Times:** May have better visibility into lead times

### Mouser and DigiKey
- **Public Pricing:** Pricing available on websites
- **Volume Discounts:** Automatic volume pricing shown
- **Stock Status:** Real-time inventory shown
- **Lead Times:** Clearly displayed for out-of-stock items

---

## Next Steps

1. **Contact Future Electronics:**
   - Reach out to local Future Electronics sales representative
   - Request pricing for main ICs (FT2232H, FT4232H, INA219, INA228)
   - Ask about volume pricing for 50+ units
   - Inquire about lead times and stock availability

2. **Use BOM Tools:**
   - Upload BOM to Mouser Price and Availability Assistant
   - Upload BOM to DigiKey myLists
   - Use Octopart to compare across all suppliers

3. **Fill in Research Table:**
   - Update this document with actual pricing
   - Note availability status
   - Document lead times
   - Identify any unavailable components

4. **Identify Alternatives:**
   - For any unavailable components, find alternatives
   - Verify compatibility
   - Update BOM with alternative part numbers

---

## Revision History

- **v1.0** (November 2024): Initial research template created
  - All components listed with supplier research tables
  - Suggested part numbers provided
  - Research checklist created
  - Alternative suppliers documented

