# KiCAD PCB Design Workflow

This guide outlines the step-by-step process for designing a professional PCB using KiCAD. This workflow can be used for the ESL DUT dongle project and adapted for other hardware designs.

## Table of Contents

1. [Prerequisites and Setup](#prerequisites-and-setup)
2. [Project Structure](#project-structure)
3. [Schematic Design](#schematic-design)
4. [PCB Layout](#pcb-layout)
5. [Design Rules and Validation](#design-rules-and-validation)
6. [Manufacturing Preparation](#manufacturing-preparation)
7. [Collaboration with Professional Tools](#collaboration-with-professional-tools)

---

## Prerequisites and Setup

### 1. Install KiCAD

**Linux:**
```bash
# Ubuntu/Debian
sudo apt-get install kicad

# Fedora
sudo dnf install kicad

# Arch Linux
sudo pacman -S kicad
```

**macOS:**
```bash
brew install --cask kicad
```

**Windows:**
- Download installer from: https://www.kicad.org/download/
- Install KiCAD 7.0 or later (recommended)

### 2. Install Component Libraries

KiCAD comes with standard libraries, but you may need additional libraries:

**Standard Libraries (usually pre-installed):**
- `Device` - Basic passive components
- `Connector` - Connectors and headers
- `Power` - Power symbols
- `Regulator_Linear` - Linear regulators

**Additional Libraries to Consider:**
- **Texas Instruments** - For INA228, other TI parts
- **FTDI** - May need custom symbol for FT2232H
- **USB Connectors** - USB Type-C symbols

**Install Library Manager:**
1. Open KiCAD
2. Go to: **Preferences → Manage Symbol Libraries**
3. Add libraries from official KiCAD library repository
4. Or download from: https://gitlab.com/kicad/libraries

### 3. Configure KiCAD Preferences

**Set Up Paths:**
1. **Preferences → Configure Paths**
   - Symbol libraries path
   - Footprint libraries path
   - 3D model libraries path

**Configure Defaults:**
1. **Preferences → Schematic Editor**
   - Default text size
   - Grid size
   - Pin length

2. **Preferences → PCB Editor**
   - Default track width
   - Default via size
   - Grid size

**Set Up Design Rules:**
1. **File → Board Setup → Design Rules**
   - Minimum track width (typically 0.1mm for standard PCBs)
   - Minimum via size
   - Clearance rules
   - Differential pair rules (for USB)

---

## Project Structure

### Recommended KiCAD Project Structure

```
hardware/
├── schematics/
│   └── esl-dut-dongle/
│       ├── esl-dut-dongle.kicad_sch    # Main schematic
│       ├── esl-dut-dongle.kicad_pcb    # PCB layout
│       ├── esl-dut-dongle.pro          # Project file
│       ├── symbols/                     # Custom symbols (if needed)
│       │   └── FT2232H.kicad_sym
│       └── footprints/                  # Custom footprints (if needed)
│           └── Custom_Connector.pretty
├── pcb/
│   └── manufacturing/
│       ├── gerber/                     # Gerber files
│       ├── drill/                      # Drill files
│       ├── pick-place/                 # Pick and place files
│       └── bom/                        # Bill of materials
└── 3d-models/
    └── esl-dut-dongle.step             # 3D model export
```

### Create New KiCAD Project

1. **File → New Project → New Project**
2. Choose location: `hardware/schematics/esl-dut-dongle/`
3. Name: `esl-dut-dongle`
4. KiCAD creates:
   - `esl-dut-dongle.kicad_sch` (schematic)
   - `esl-dut-dongle.kicad_pcb` (PCB)
   - `esl-dut-dongle.pro` (project file)

---

## Schematic Design

### Step 1: Create Schematic Sheet

1. Open `esl-dut-dongle.kicad_sch`
2. Set up sheet properties:
   - **File → Page Settings**
   - Title: "ESL DUT Dongle"
   - Revision: "0.1"
   - Date: Current date

### Step 2: Add Components

**Method 1: Using Symbol Library Browser**
1. Click **Add Symbol** tool (or press `A`)
2. Browse libraries or search for component
3. Place component on schematic

**Method 2: Using Symbol Search**
1. Press `A` to add symbol
2. Type component name (e.g., "INA228")
3. Select from results

**Key Components to Add:**
- FT2232H (may need custom symbol)
- INA228 (from TI library)
- USB Type-C connector
- Resistors, capacitors
- Headers/connectors

### Step 3: Create Custom Symbols (if needed)

**For FT2232H (if not in library):**

1. **Tools → Symbol Editor**
2. **File → New Symbol**
3. Create symbol:
   - Add pins with correct names
   - Add rectangle for body
   - Add reference designator (U?)
   - Add value field
4. Save to custom library: `symbols/FT2232H.kicad_sym`
5. Add library to project

**Symbol Pin Requirements:**
- Pin numbers must match datasheet
- Pin names should be descriptive
- Power pins should be marked as power pins
- Group related pins together

### Step 4: Connect Components

1. **Add Wire** tool (or press `W`)
2. Connect components according to netlist
3. Use **Add Net Label** (or press `L`) for named nets:
   - `+3V3`, `+5V`, `GND`
   - `I2C_SCL`, `I2C_SDA`
   - `UART1_TX`, `UART1_RX`

**Best Practices:**
- Use net labels for clarity
- Group related signals
- Use power symbols for power nets
- Add no-connect symbols (X) for unused pins

### Step 5: Add Power Symbols

1. **Add Power Symbol** tool (or press `P`)
2. Add power symbols:
   - `+3V3` for 3.3V power
   - `+5V` for 5V power
   - `GND` for ground

### Step 6: Add Annotations and Documentation

1. **Add Text** tool (or press `T`)
2. Add:
   - Title block information
   - Notes and warnings
   - Design notes
   - Version information

3. **Add Graphic Lines/Shapes** for:
   - Section dividers
   - Highlighting important areas

### Step 7: Assign Footprints

1. **Tools → Assign Footprints**
2. For each component:
   - Select component
   - Choose appropriate footprint
   - Verify footprint matches component package

**Common Footprint Libraries:**
- `Resistor_SMD` - For SMD resistors
- `Capacitor_SMD` - For SMD capacitors
- `Package_QFP` - For QFP/QFN packages
- `Connector_USB` - For USB connectors

### Step 8: Electrical Rules Check (ERC)

1. **Inspect → Electrical Rules Check**
2. Review errors and warnings:
   - Unconnected pins
   - Power pin conflicts
   - Pin type mismatches
3. Fix all errors
4. Address warnings (some may be acceptable)

### Step 9: Generate Netlist

1. **Tools → Generate Netlist**
2. Save netlist (usually automatic)
3. Verify netlist is correct

---

## PCB Layout

### Step 1: Open PCB Editor

1. Click **Open PCB in Board Editor** button (or `F4`)
2. PCB editor opens with components placed at origin

### Step 2: Set Up Board Outline

1. **View → Switch to Footprint Editor** (if needed)
2. Switch to **Edge.Cuts** layer
3. **Add Graphic Polygon** or **Add Graphic Rectangle**
4. Draw board outline (e.g., 50mm x 30mm)
5. Set origin: **Place → Drill and Place Offset**

### Step 3: Configure Stackup

1. **File → Board Setup → Physical Stackup**
2. Configure layers:
   - **4-layer recommended for power monitoring:**
     - Top (Signal)
     - GND (Ground plane)
     - Power (Power plane - 3.3V, 5V)
     - Bottom (Signal)
3. Set copper thickness (typically 1oz = 35μm)
4. Set dielectric thickness

### Step 4: Configure Design Rules

1. **File → Board Setup → Design Rules**
2. **Net Classes:**
   - Create net classes:
     - `Default` - 0.1mm track, 0.1mm clearance
     - `Power` - 0.2mm track, 0.15mm clearance
     - `USB` - Differential pair, 90Ω impedance
     - `I2C` - 0.1mm track, standard clearance
3. **Constraints:**
   - Minimum track width: 0.1mm
   - Minimum via size: 0.2mm
   - Minimum clearance: 0.1mm
   - Minimum hole size: 0.2mm

### Step 5: Place Components

**Initial Placement:**
1. Components appear at origin
2. Drag components to approximate positions
3. Group related components:
   - Power supply section
   - USB interface section
   - Power monitoring section
   - Connector section

**Placement Guidelines:**
- Keep USB traces short
- Place decoupling capacitors close to ICs
- Group power monitoring components together
- Consider assembly orientation
- Leave space for routing

**Useful Tools:**
- **Align/Distribute** - Align components
- **Grid** - Use grid for alignment
- **3D Viewer** - Check 3D view (`Alt+3`)

### Step 6: Route Power and Ground

**Power Planes:**
1. **Add Filled Zone** tool (or press `Z`)
2. Select layer (Power plane)
3. Draw zone covering board
4. Assign net (e.g., `+3V3`)
5. Set fill style: Solid
6. Repeat for other power nets

**Ground Plane:**
1. Create filled zone on GND layer
2. Cover entire board
3. Connect all GND pads to plane

**Power Traces:**
1. Route power traces with appropriate width
2. Use `Power` net class (wider traces)
3. Connect to power planes via vias

### Step 7: Route Signal Traces

**General Routing:**
1. **Add Track** tool (or press `X`)
2. Route traces according to schematic
3. Use appropriate net class
4. Keep traces as short as possible
5. Avoid 90-degree angles (use 45-degree)

**USB Differential Pair:**
1. **Route → Interactive Differential Pair**
2. Select USB D+ and D- nets
3. Route together maintaining spacing
4. Set impedance: 90Ω
5. Keep length matched

**I2C Signals:**
1. Route SCL and SDA together
2. Keep traces short
3. Avoid routing near high-speed signals

**GPIO Signals:**
1. Standard routing
2. Consider series resistors for protection
3. Keep traces away from sensitive analog

### Step 8: Add Guard Rings (for Power Monitoring)

**For Nanoamp Measurements:**
1. **Add Filled Zone** tool
2. Create guard ring around:
   - INA228 IC
   - Shunt resistor
   - Sensitive traces
3. Connect guard ring to analog ground
4. Keep guard ring close to protected traces

### Step 9: Add Test Points

1. **Add Footprint** tool
2. Add test point footprints:
   - Power supply voltages
   - USB signals
   - I2C signals
   - GPIO signals
3. Place test points in accessible locations

### Step 10: Add Silkscreen and Documentation

1. **F.Silkscreen** layer
2. **Add Text** tool
3. Add:
   - Component designators
   - Component values
   - Pin numbers
   - Version number
   - Test point labels
   - Warnings/notes

### Step 11: Design Rule Check (DRC)

1. **Inspect → Design Rules Check**
2. Check all categories:
   - Unconnected items
   - Clearance violations
   - Track width violations
   - Via violations
   - Copper slivers
3. Fix all errors
4. Review warnings

### Step 12: 3D View and Verification

1. **View → 3D Viewer** (or `Alt+3`)
2. Verify:
   - Component placement
   - Board dimensions
   - Connector orientation
   - Clearance issues
3. Export 3D model if needed: **File → Export → STEP**

---

## Design Rules and Validation

### Critical Design Rules

**For Standard PCB:**
- Minimum track width: 0.1mm (4 mil)
- Minimum clearance: 0.1mm (4 mil)
- Minimum via size: 0.2mm drill, 0.4mm pad
- Minimum hole size: 0.2mm

**For Power Monitoring (Nanoamp):**
- Guard rings around sensitive areas
- Separate analog ground plane
- Low-leakage PCB materials (FR4 is acceptable)
- Proper shielding
- Clean power supplies

**For USB Signals:**
- Differential pair impedance: 90Ω
- Length matching: <0.1mm difference
- Keep away from noisy signals
- Proper termination

### Validation Checklist

Before sending to manufacturing:

- [ ] ERC passed (no errors)
- [ ] DRC passed (no errors)
- [ ] All components have footprints assigned
- [ ] All nets are routed
- [ ] Power and ground planes are complete
- [ ] Test points added
- [ ] Silkscreen is readable
- [ ] 3D view verified
- [ ] BOM generated and verified
- [ ] Design rules match manufacturer capabilities

---

## Manufacturing Preparation

### Step 1: Generate Gerber Files

1. **File → Fabrication Outputs → Gerbers**
2. Configure:
   - **Layers:** Select all copper layers
   - **Plot format:** Gerber X2 (recommended)
   - **Include:** All required layers
3. Generate files:
   - `*.GTL` - Top layer
   - `*.GBL` - Bottom layer
   - `*.GTS` - Top solder mask
   - `*.GBS` - Bottom solder mask
   - `*.GTO` - Top silkscreen
   - `*.GBO` - Bottom silkscreen
   - `*.GKO` - Keep-out/edge cuts

### Step 2: Generate Drill Files

1. **File → Fabrication Outputs → Drill Files**
2. Configure:
   - **Format:** Excellon
   - **Units:** Millimeters
   - **Zeros format:** Decimal format
3. Generate:
   - `*.drl` - Drill file
   - `*.drill_report.txt` - Drill report

### Step 3: Generate Pick and Place File

1. **File → Fabrication Outputs → Footprint Position (.pos) File**
2. Configure:
   - **Format:** CSV
   - **Units:** Millimeters
   - **Include:** All components
3. Generate for assembly

### Step 4: Generate Bill of Materials (BOM)

1. **Tools → Generate Bill of Materials**
2. Configure:
   - **Template:** Default or custom
   - **Format:** CSV or HTML
3. Generate BOM with:
   - Reference designators
   - Component values
   - Footprint information
   - Manufacturer part numbers (if added)

### Step 5: Create Manufacturing Package

**Organize Files:**
```
manufacturing/
├── gerber/
│   ├── esl-dut-dongle.GTL
│   ├── esl-dut-dongle.GBL
│   ├── esl-dut-dongle.GTS
│   ├── esl-dut-dongle.GBS
│   ├── esl-dut-dongle.GTO
│   ├── esl-dut-dongle.GBO
│   └── esl-dut-dongle.GKO
├── drill/
│   ├── esl-dut-dongle.drl
│   └── esl-dut-dongle.drill_report.txt
├── pick-place/
│   └── esl-dut-dongle.pos
├── bom/
│   └── esl-dut-dongle.csv
└── README.txt (manufacturing notes)
```

**Manufacturing Notes (README.txt):**
- PCB thickness: 1.6mm
- Copper weight: 1oz
- Surface finish: HASL or ENIG
- Solder mask: Green
- Silkscreen: White
- Minimum track width: 0.1mm
- Minimum clearance: 0.1mm

### Step 6: Verify with Gerber Viewer

**Online Gerber Viewers:**
- https://www.pcbway.com/project/onlineGerberViewer.html
- https://www.gerber-viewer.com/

**KiCAD Gerber Viewer:**
1. **File → Plot**
2. **View Gerber Files** button
3. Verify all layers are correct

---

## Collaboration with Professional Tools

### Exporting from KiCAD

**For Altium Designer:**
- Export as ODB++ (if supported)
- Or export Gerber files (universal)

**For OrCAD:**
- Export Gerber files
- Export netlist (IPC-D-356 format)

**For Eagle:**
- Export Gerber files
- May need manual conversion

### Importing to Professional Tools

**From KiCAD to Altium:**
1. Export Gerber files from KiCAD
2. Import Gerber files into Altium
3. Recreate schematic if needed
4. Import netlist

**Best Practice:**
- Keep KiCAD files as source
- Export standard formats (Gerber) for collaboration
- Document any manual conversions needed

### File Format Compatibility

**Universal Formats:**
- **Gerber** - PCB layout (universal)
- **ODB++** - Complete PCB data (if supported)
- **STEP** - 3D models (universal)
- **DXF** - 2D drawings (universal)

**KiCAD-Specific:**
- `.kicad_sch` - Schematic (KiCAD only)
- `.kicad_pcb` - PCB layout (KiCAD only)
- `.kicad_pro` - Project file (KiCAD only)

### Collaboration Workflow

1. **Design in KiCAD** (your workflow)
2. **Export Gerber files** (for manufacturing)
3. **Share Gerber files** with colleagues using professional tools
4. **Colleagues can:**
   - Review in their tools
   - Import for modifications
   - Use for manufacturing
5. **Keep KiCAD as source** for future modifications

---

## Additional Resources

### KiCAD Documentation
- Official Manual: https://docs.kicad.org/
- Getting Started Guide: https://docs.kicad.org/7.0/en/getting_started_in_kicad/

### Tutorials
- KiCAD Tutorial Series: https://www.youtube.com/results?search_query=kicad+tutorial
- Contextual Electronics: https://contextualelectronics.com/

### Component Libraries
- Official Library: https://gitlab.com/kicad/libraries
- SnapEDA: https://www.snapeda.com/ (component models)

### Design Guidelines
- See: `docs/development/DESIGN_GUIDELINES.md`
- See: `hardware/examples/pcb-design-investigation/` for examples

---

## Next Steps

1. **Install KiCAD** and configure libraries
2. **Create project structure** in `hardware/schematics/`
3. **Start with schematic** design
4. **Move to PCB layout** once schematic is complete
5. **Generate manufacturing files** when ready
6. **Order prototype PCBs** from manufacturer (JLCPCB, PCBWay, etc.)

---

## Notes

- This workflow is iterative - expect to go back and forth between schematic and PCB
- Start simple and add complexity gradually
- Test with small sections before completing full design
- Get feedback early from colleagues using professional tools
- Keep design files version controlled (Git)

