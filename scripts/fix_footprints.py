#!/usr/bin/env python3
"""
Fix footprints in schematic - simpler direct replacement
"""

from pathlib import Path

def main():
    """Main function"""
    project_dir = Path(__file__).parent.parent / "hardware" / "schematics" / "esl-dut-dongle"
    schematic_file = project_dir / "esl-dut-dongle.kicad_sch"
    
    if not schematic_file.exists():
        print("❌ Schematic not found!")
        return
    
    content = schematic_file.read_text()
    
    # Footprint mappings - direct string replacement
    replacements = [
        ('(property "Reference" "U1"', '(property "Footprint" "FT4232H_footprint:QFN50P800X800X100-57N" (at 1000 1000 0)\n      (effects (font (size 1.27 1.27)) hide)\n    )\n    (property "Reference" "U1"'),
        ('(property "Reference" "U2"', '(property "Footprint" "INA219_footprint:SOT65P280X145-8N" (at 500 2000 0)\n      (effects (font (size 1.27 1.27)) hide)\n    )\n    (property "Reference" "U2"'),
        ('(property "Reference" "U3"', '(property "Footprint" "INA228_footprint:SOP50P490X110-10N" (at 1500 2000 0)\n      (effects (font (size 1.27 1.27)) hide)\n    )\n    (property "Reference" "U3"'),
    ]
    
    # Better approach: find and replace footprint property lines directly
    import re
    
    # Pattern to match footprint property and replace it
    footprint_replacements = {
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
    
    # Find each component block and update its footprint
    for ref, footprint in footprint_replacements.items():
        # Find the component block starting with Reference
        pattern = rf'(\(property "Reference" "{ref}"[^\n]+\n[^\n]+\n[^\n]+\)\n[^\n]+\(property "Value"[^\n]+\n[^\n]+\n[^\n]+\)\n[^\n]+)\(property "Footprint" "([^"]*)"'
        
        def replace_footprint(match):
            prefix = match.group(1)
            return f'{prefix}(property "Footprint" "{footprint}"'
        
        content = re.sub(pattern, replace_footprint, content)
    
    # Write back
    backup = schematic_file.with_suffix('.kicad_sch.backup4')
    if backup.exists():
        backup.unlink()
    schematic_file.rename(backup)
    
    schematic_file.write_text(content)
    
    print(f"✅ Updated footprints in {schematic_file}")
    print(f"   Backup: {backup.name}")

if __name__ == "__main__":
    main()

