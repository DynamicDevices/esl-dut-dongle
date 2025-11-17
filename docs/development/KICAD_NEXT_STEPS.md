# KiCAD Next Steps - Practical Guide

Based on the example design with **FT4232H** and **dual power monitoring (INA219 + INA228)**, here are the practical next steps to start using KiCAD.

## Prerequisites ✅

- [x] KiCAD installed (version 6.0.2+)
- [x] Design documents prepared (`hardware/examples/pcb-design-investigation/schematics/`)
- [x] Provisional assumptions documented (FT4232H, INA219, INA228)

---

## Step 1: Launch KiCAD and Create Project

### Launch KiCAD
```bash
kicad &
```

Or from applications menu: **KiCAD**

### Create New Project

1. **File → New Project → New Project**
2. **Location:** Navigate to `hardware/schematics/esl-dut-dongle/`
   - Create directory if it doesn't exist
3. **Name:** `esl-dut-dongle`
4. Click **Save**

**Files Created:**
- `esl-dut-dongle.kicad_sch` - Schematic file
- `esl-dut-dongle.kicad_pcb` - PCB layout file
- `esl-dut-dongle.pro` - Project file

---

## Step 2: Configure Project Settings

### Set Up Page Settings

1. Open `esl-dut-dongle.kicad_sch`
2. **File → Page Settings**
3. Configure:
   - **Title:** "ESL DUT Dongle - Example Design"
   - **Revision:** "0.1"
   - **Date:** Current date
   - **Company:** "Active Edge Solutions"
   - **Comment 1:** "Provisional design - FT4232H + Dual Power Monitoring"

---

## Step 3: Check and Install Libraries

### Verify Standard Libraries

1. **Preferences → Manage Symbol Libraries**
2. Verify these libraries are available:
   - `Device` - Basic components (resistors, capacitors)
   - `Connector` - Connectors and headers
   - `Power` - Power symbols
   - `Regulator_Linear` - Regulators

### Install Additional Libraries (if needed)

**For Texas Instruments Components:**
1. **Preferences → Manage Symbol Libraries**
2. Click **Add** (folder icon)
3. Add library path or download from:
   - https://gitlab.com/kicad/libraries/kicad-symbols
   - Look for Texas Instruments library

**For USB Connectors:**
- Search for USB-C symbols in connector libraries
- May need to create custom symbol if not available

---

## Step 4: Create Custom Symbols (Likely Needed)

### FT4232H Symbol

**Why:** FT4232H may not be in standard libraries

**Steps:**
1. **Tools → Symbol Editor**
2. **File → New Symbol**
3. **Library:** Create new library `Custom_Symbols` or add to existing
4. **Symbol Name:** `FT4232H`

**Create Symbol:**
- Add rectangle for body
- Add pins according to datasheet:
  - USB pins: VBUS, D+, D-, GND
  - Power pins: VCC, VCCIO, GND
  - Channel A: ADBUS0-7 (UART1 + GPIO)
  - Channel B: BDBUS0-7 (UART2 + GPIO)
  - Channel C: CDBUS0-7 (UART3)
  - Channel D: DDBUS0-7 (UART4)
  - I2C: ADBUS8/SCL, ADBUS9/SDA
  - Clock: OSCI, OSCO
  - Reset: RESET#

**Reference:** Use FT4232H datasheet for exact pin numbers and names

**Save:** Save symbol to library

### INA219 and INA228 Symbols

**Check First:** May be in Texas Instruments library

**If Not Available:**
1. Create similar to FT4232H process
2. Use datasheets for pin assignments
3. INA219: MSOP-10 package
4. INA228: MSOP-10 package

---

## Step 5: Start Drawing Schematic

### Add Components

**Method:** Press `A` or click **Add Symbol** tool

**Add These Components:**

1. **FT4232H (U1)**
   - Search for "FT4232H" or use custom symbol
   - Place on schematic

2. **INA219 (U2)**
   - Search for "INA219" or use TI library
   - Place on schematic

3. **INA228 (U3)**
   - Search for "INA228" or use TI library
   - Place on schematic

4. **USB Type-C Connector (J1)**
   - Search for "USB-C" or "USB Type-C"
   - May need custom symbol

5. **Target Board Connector (J2)**
   - Use header symbol (2.54mm pitch)
   - 28-pin header

6. **Passive Components:**
   - Resistors: 10kΩ (I2C pull-ups), 1kΩ (LED)
   - Capacitors: 0.1μF (decoupling), 10μF (bulk)
   - Shunt resistors: 0.1Ω, 10Ω

### Connect Components

**Method:** Press `W` or click **Add Wire** tool

**Follow the Netlist:**
- Reference: `hardware/examples/pcb-design-investigation/schematics/NETLIST.md`
- Connect according to pin assignments in schematic design document

**Key Connections:**

1. **USB Interface:**
   - J1.VBUS → U1.VBUS
   - J1.D+ → U1.D+
   - J1.D- → U1.D-
   - J1.GND → GND

2. **UART Channels:**
   - U1.ADBUS0-3 → J2 pins 1-4 (UART1)
   - U1.BDBUS0-3 → J2 pins 5-8 (UART2)
   - U1.CDBUS0-3 → J2 pins 9-12 (UART3)
   - U1.DDBUS0-3 → J2 pins 13-16 (UART4)

3. **GPIO:**
   - U1.ADBUS4-7 → J2 pins 17-20 (Boot Mode)
   - U1.BDBUS4 → J2 pin 21 (Reset)

4. **I2C Bus:**
   - U1.ADBUS8 → I2C_SCL → U2.SCL, U3.SCL
   - U1.ADBUS9 → I2C_SDA → U2.SDA, U3.SDA

5. **Power Monitoring:**
   - Power path → Shunt resistors → INA219/INA228
   - Reference netlist for exact connections

### Add Net Labels

**Method:** Press `L` or click **Add Net Label** tool

**Add Labels:**
- `+3V3`, `+5V`, `GND`, `AGND`
- `I2C_SCL`, `I2C_SDA`
- `UART1_TX`, `UART1_RX`, etc.
- `BOOT_MODE_0`, `BOOT_MODE_1`, etc.

### Add Power Symbols

**Method:** Press `P` or click **Add Power Symbol** tool

**Add:**
- `+3V3` symbol
- `+5V` symbol
- `GND` symbol

---

## Step 6: Assign Footprints

### For Each Component

1. **Tools → Assign Footprints**
2. Select component
3. Choose appropriate footprint:
   - **FT4232H:** QFN-56 package (search "QFN" libraries)
   - **INA219/INA228:** MSOP-10 package
   - **USB-C:** USB-C connector footprint
   - **Headers:** 2.54mm pitch headers
   - **Resistors/Capacitors:** 0805 SMD footprints

**Verify:** Footprint matches component package from datasheet

---

## Step 7: Run Electrical Rules Check (ERC)

1. **Inspect → Electrical Rules Check**
2. Review errors and warnings
3. **Fix all errors:**
   - Unconnected pins
   - Power conflicts
   - Pin type mismatches
4. **Address warnings** (some may be acceptable)

---

## Step 8: Generate Netlist

1. **Tools → Generate Netlist**
2. Verify netlist is correct
3. Compare with reference netlist document

---

## Step 9: Open PCB Editor

1. Click **Open PCB in Board Editor** button (or press `F4`)
2. PCB editor opens with components at origin

---

## Step 10: Set Up PCB

### Draw Board Outline

1. Switch to **Edge.Cuts** layer
2. **Add Graphic Rectangle** tool
3. Draw board outline (e.g., 50mm x 30mm)
4. Set origin: **Place → Drill and Place Offset**

### Configure Stackup

1. **File → Board Setup → Physical Stackup**
2. Configure **4-layer stackup:**
   - **Top** (Signal)
   - **GND** (Ground plane)
   - **Power** (Power plane)
   - **Bottom** (Signal)
3. Set copper thickness: **1oz (35μm)**

### Configure Design Rules

1. **File → Board Setup → Design Rules**
2. **Net Classes:**
   - `Default`: 0.1mm track, 0.1mm clearance
   - `Power`: 0.2mm track, 0.15mm clearance
   - `USB`: Differential pair, 90Ω impedance
   - `I2C`: 0.1mm track, standard clearance

---

## Step 11: Place Components

1. Components appear at origin
2. Drag to approximate positions:
   - Group USB section
   - Group power monitoring section
   - Group connectors
3. Use **Align/Distribute** tools
4. Check **3D View** (`Alt+3`)

---

## Step 12: Route Power and Ground

1. **Add Filled Zone** tool (`Z`)
2. Create **GND plane** on GND layer
3. Create **+3V3 plane** on Power layer
4. Create **+5V plane** on Power layer
5. Connect power pins via vias

---

## Step 13: Route Signals

1. **Add Track** tool (`X`)
2. Route USB differential pair (keep together, 90Ω)
3. Route I2C signals (SCL, SDA together)
4. Route UART signals
5. Route GPIO signals
6. Add **guard rings** around power monitoring section

---

## Step 14: Design Rule Check (DRC)

1. **Inspect → Design Rules Check**
2. Fix all errors
3. Review warnings
4. Verify in **3D View**

---

## Step 15: Generate Manufacturing Files (When Ready)

1. **File → Fabrication Outputs → Gerbers**
2. **File → Fabrication Outputs → Drill Files**
3. **File → Fabrication Outputs → Footprint Position**
4. **Tools → Generate Bill of Materials**

---

## Tips for Success

### Start Simple
- Begin with a small section (e.g., USB interface)
- Get comfortable with KiCAD interface
- Expand gradually

### Use Reference Documents
- Keep `SCHEMATIC_DESIGN.md` open
- Reference `NETLIST.md` for connections
- Check datasheets for pin assignments

### Common Issues
- **Missing symbols:** Create custom symbols
- **Wrong footprints:** Verify package sizes
- **ERC errors:** Check power connections
- **DRC errors:** Verify design rules

### Learning Resources
- KiCAD Tutorial: https://docs.kicad.org/
- YouTube tutorials: Search "KiCAD tutorial"
- KiCAD Forum: https://forum.kicad.info/

---

## Quick Reference: KiCAD Keyboard Shortcuts

- `A` - Add symbol
- `W` - Add wire
- `L` - Add net label
- `P` - Add power symbol
- `X` - Add track (PCB)
- `Z` - Add filled zone (PCB)
- `F4` - Open PCB editor
- `Alt+3` - 3D view
- `E` - Edit properties
- `M` - Move
- `R` - Rotate
- `Delete` - Delete selected

---

## Next Actions

1. **Launch KiCAD** and create project
2. **Create custom symbols** for FT4232H (if needed)
3. **Start with USB section** - simplest part
4. **Add components gradually** - don't try to do everything at once
5. **Reference design documents** - keep them open
6. **Ask for help** - KiCAD forum or documentation

---

## Files to Reference

- **Schematic Design:** `hardware/examples/pcb-design-investigation/schematics/SCHEMATIC_DESIGN.md`
- **Netlist:** `hardware/examples/pcb-design-investigation/schematics/NETLIST.md`
- **Full Workflow:** `docs/development/KICAD_WORKFLOW.md`
- **Quick Start:** `docs/development/KICAD_QUICK_START.md`

Good luck with your KiCAD exploration! 🚀

