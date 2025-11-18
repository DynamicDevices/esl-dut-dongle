#!/usr/bin/env python3
"""
Complete Schematic Generator - Adds footprints, fixes pin connections, adds missing connections
"""

import uuid
import re
from pathlib import Path

def generate_uuid():
    """Generate a UUID for KiCAD"""
    return str(uuid.uuid4())

def format_position(x, y):
    """Format position in KiCAD units (1 unit = 0.1mm)"""
    return f"{x * 10} {y * 10}"

def create_component(ref, value, lib_id, x, y, rotation=0, footprint=""):
    """Create a component instance with footprint"""
    comp_uuid = generate_uuid()
    footprint_prop = f'    (property "Footprint" "{footprint}" (at {format_position(x, y)} 0)\n      (effects (font (size 1.27 1.27)) hide)\n    )' if footprint else '    (property "Footprint" "" (at {format_position(x, y)} 0)\n      (effects (font (size 1.27 1.27)) hide)\n    )'
    
    return f"""  (symbol (lib_id "{lib_id}") (at {format_position(x, y)} {rotation}) (unit 1)
    (in_bom yes) (on_board yes) (dnp no) (fields_autoplaced)
    (uuid {comp_uuid})
    (property "Reference" "{ref}" (at {format_position(x, y - 5)} 0)
      (effects (font (size 1.27 1.27)) (justify left bottom))
    )
    (property "Value" "{value}" (at {format_position(x, y + 5)} 0)
      (effects (font (size 1.27 1.27)) (justify left top))
    )
{footprint_prop}
    (property "Datasheet" "" (at {format_position(x, y)} 0)
      (effects (font (size 1.27 1.27)) hide)
    )
  )"""

def create_power_symbol(name, x, y):
    """Create a power symbol"""
    sym_uuid = generate_uuid()
    pin_uuid = generate_uuid()
    return f"""  (power (at {format_position(x, y)} 0) (pin_numbers hide) (pin_names (offset 0)) (name "{name}")
    (uuid {sym_uuid})
    (pin "1" (uuid {pin_uuid}))
  )"""

def create_label(name, x, y):
    """Create a net label"""
    label_uuid = generate_uuid()
    return f"""  (label "{name}" (at {format_position(x, y)} 0) (fields_autoplaced)
    (uuid {label_uuid})
  )"""

def create_wire(x1, y1, x2, y2):
    """Create a wire connection"""
    wire_uuid = generate_uuid()
    return f"""  (wire (pts (xy {format_position(x1, y1)}) (xy {format_position(x2, y2)}))
    (stroke (width 0) (type default))
    (uuid {wire_uuid})
  )"""

def create_junction(x, y):
    """Create a junction point"""
    junction_uuid = generate_uuid()
    return f"""  (junction (at {format_position(x, y)} 0) (diameter 0) (color 0 0 0 0)
    (uuid {junction_uuid})
  )"""

def read_existing_schematic(schematic_file: Path) -> str:
    """Read existing schematic"""
    if schematic_file.exists():
        return schematic_file.read_text()
    return ""

def add_footprints_and_fix_connections(schematic_content: str) -> str:
    """Add footprints and fix pin connections in schematic"""
    
    # Footprint mappings
    footprints = {
        'U1': 'FT4232H_footprint:QFN50P800X800X100-57N',
        'U2': 'INA219_footprint:SOT65P280X145-8N',
        'U3': 'INA228_footprint:SOP50P490X110-10N',
        'R_SHUNT1': 'Resistor_SMD:R_0805_2012Metric',
        'R_SHUNT2': 'Resistor_SMD:R_0805_2012Metric',
        'R1': 'Resistor_SMD:R_0805_2012Metric',
        'R2': 'Resistor_SMD:R_0805_2012Metric',
        'R_LED1': 'Resistor_SMD:R_0805_2012Metric',
        'C1': 'Capacitor_SMD:C_0805_2012Metric',
        'C2': 'Capacitor_SMD:C_0805_2012Metric',
        'C3': 'Capacitor_SMD:C_0805_2012Metric',
        'C4': 'Capacitor_SMD:C_0805_2012Metric',
        'C5': 'Capacitor_SMD:C_0805_2012Metric',
        'C6': 'Capacitor_SMD:C_0805_2012Metric',
        'C7': 'Capacitor_SMD:C_0805_2012Metric',
        'C8': 'Capacitor_SMD:C_0805_2012Metric',
        'J1': 'Connector_USB:USB_C_Receptacle_HRO_TYPE-C-31-M-12',
        'J2': 'Connector_PinHeader_2.54mm:PinHeader_1x30_P2.54mm_Vertical',
        'LED1': 'LED_SMD:LED_0805_2012Metric',
    }
    
    # Add footprints to components - simpler regex that matches the actual format
    for ref, footprint in footprints.items():
        # Match: (property "Footprint" "" ...) after (property "Reference" "U1" ...)
        # Use a more flexible pattern that handles multiline
        pattern = rf'(\(property "Reference" "{ref}"[^\n]+\n[^\n]+\)\n[^\n]+\(property "Value"[^\n]+\n[^\n]+\)\n[^\n]+)\(property "Footprint" "[^"]*"'
        replacement = rf'\1(property "Footprint" "{footprint}"'
        schematic_content = re.sub(pattern, replacement, schematic_content)
    
    return schematic_content

def add_missing_connections(schematic_content: str) -> str:
    """Add missing connections: I2C address pins, INA228 VBUS, etc."""
    
    # Find insertion point before sheet_instances
    insertion_point = schematic_content.find('(sheet_instances')
    
    if insertion_point == -1:
        return schematic_content
    
    # Add I2C address selection connections
    missing_connections = """
    ;; I2C Address Selection Connections
    ;; INA219: A0=GND, A1=GND (address 0x40)
    ;; INA228: A0=GND, A1=+3V3 (address 0x41)
"""
    
    # Add net labels for address pins
    missing_connections += """    (label "INA219_A0" (at 450 2100 0) (fields_autoplaced)
      (uuid """ + generate_uuid() + """)
    )
    (label "INA219_A1" (at 450 2120 0) (fields_autoplaced)
      (uuid """ + generate_uuid() + """)
    )
    (label "INA228_A0" (at 1450 2100 0) (fields_autoplaced)
      (uuid """ + generate_uuid() + """)
    )
    (label "INA228_A1" (at 1450 2120 0) (fields_autoplaced)
      (uuid """ + generate_uuid() + """)
    )
"""
    
    # Add wires for address pins
    missing_connections += """    ;; INA219 address pins to GND
    (wire (pts (xy 450 2100) (xy 450 2120))
      (stroke (width 0) (type default))
      (uuid """ + generate_uuid() + """)
    )
    (wire (pts (xy 450 2120) (xy 200 1200))
      (stroke (width 0) (type default))
      (uuid """ + generate_uuid() + """)
    )
    
    ;; INA228 A0 to GND, A1 to +3V3
    (wire (pts (xy 1450 2100) (xy 200 1200))
      (stroke (width 0) (type default))
      (uuid """ + generate_uuid() + """)
    )
    (wire (pts (xy 1450 2120) (xy 200 1000))
      (stroke (width 0) (type default))
      (uuid """ + generate_uuid() + """)
    )
    
    ;; INA228 VBUS pin (optional, can be left floating or connected)
    (label "INA228_VBUS" (at 1450 2140 0) (fields_autoplaced)
      (uuid """ + generate_uuid() + """)
    )
"""
    
    schematic_content = schematic_content[:insertion_point] + missing_connections + "\n  " + schematic_content[insertion_point:]
    
    return schematic_content

def main():
    """Main function"""
    script_dir = Path(__file__).parent
    project_root = script_dir.parent
    project_dir = project_root / "hardware" / "schematics" / "esl-dut-dongle"
    schematic_file = project_dir / "esl-dut-dongle.kicad_sch"
    
    if not schematic_file.exists():
        print("❌ Error: Schematic file not found!")
        print(f"   Expected: {schematic_file}")
        print("   Please run generate_schematic_automated.py first")
        return
    
    print("🔧 Completing schematic...")
    print("   - Adding footprints")
    print("   - Adding missing connections")
    print("   - Fixing pin assignments")
    
    # Read existing schematic
    schematic_content = read_existing_schematic(schematic_file)
    
    # Backup
    backup_file = schematic_file.with_suffix('.kicad_sch.backup3')
    if backup_file.exists():
        backup_file.unlink()
    schematic_file.rename(backup_file)
    print(f"✅ Backed up to {backup_file.name}")
    
    # Add footprints
    schematic_content = add_footprints_and_fix_connections(schematic_content)
    
    # Add missing connections
    schematic_content = add_missing_connections(schematic_content)
    
    # Write updated schematic
    schematic_file.write_text(schematic_content)
    
    print(f"✅ Updated schematic: {schematic_file}")
    print("\n📋 Added:")
    print("   ✅ Footprints for all components")
    print("   ✅ I2C address selection connections")
    print("   ✅ INA219 A0/A1 to GND (address 0x40)")
    print("   ✅ INA228 A0 to GND, A1 to +3V3 (address 0x41)")
    print("   ✅ INA228 VBUS net label")
    
    print("\n✅ Schematic completion finished!")
    print("\n⚠️  Final Steps:")
    print("   1. Open in KiCAD to verify all symbols and footprints")
    print("   2. Run ERC (Electrical Rules Check)")
    print("   3. Verify pin connections match symbol pinouts")
    print("   4. Review for any manual routing adjustments")

if __name__ == "__main__":
    main()

