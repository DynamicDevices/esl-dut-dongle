#!/usr/bin/env python3
"""
Automated Schematic Generator for ESL DUT Dongle
Uses KiCAD symbol files and design spec to generate complete schematic
"""

import uuid
from pathlib import Path
import re

def generate_uuid():
    """Generate a UUID for KiCAD"""
    return str(uuid.uuid4())

def format_position(x, y):
    """Format position in KiCAD units (1 unit = 0.1mm)"""
    return f"{x * 10} {y * 10}"

def create_component(ref, value, lib_id, x, y, rotation=0):
    """Create a component instance"""
    comp_uuid = generate_uuid()
    return f"""  (symbol (lib_id "{lib_id}") (at {format_position(x, y)} {rotation}) (unit 1)
    (in_bom yes) (on_board yes) (dnp no) (fields_autoplaced)
    (uuid {comp_uuid})
    (property "Reference" "{ref}" (at {format_position(x, y - 5)} 0)
      (effects (font (size 1.27 1.27)) (justify left bottom))
    )
    (property "Value" "{value}" (at {format_position(x, y + 5)} 0)
      (effects (font (size 1.27 1.27)) (justify left top))
    )
    (property "Footprint" "" (at {format_position(x, y)} 0)
      (effects (font (size 1.27 1.27)) hide)
    )
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

def generate_schematic():
    """Generate the complete schematic based on design spec"""
    
    schematic = f"""(kicad_sch (version 20231120) (generator "automated_schematic_generator")
  (uuid {generate_uuid()})
  (paper "A4")
  (title_block
    (title "ESL DUT Dongle")
    (date "2025-11-17")
    (rev "0.1")
    (company "Active Edge Solutions")
    (comment 1 "USB dongle for i.MX8M Mini and i.MX93 development boards")
    (comment 2 "Dual-range power monitoring: INA219 (μA) + INA228 (nA)")
    (comment 3 "4 UARTs + GPIO via FT4232H")
  )
  (lib_symbols
  )
"""
    
    # Component positions (in mm, converted to KiCAD units internally)
    # Main ICs
    schematic += "\n  ;; Main ICs\n"
    schematic += create_component("U1", "FT4232H-56Q-REEL", "FT4232H:FT4232H-56Q-REEL", 100, 100) + "\n"
    schematic += create_component("U2", "INA219BIDCNT", "INA219:INA219BIDCNT", 50, 200) + "\n"
    schematic += create_component("U3", "INA228AIDGSR", "INA228:INA228AIDGSR", 150, 200) + "\n"
    
    # Shunt Resistors
    schematic += "\n  ;; Shunt Resistors\n"
    schematic += create_component("R_SHUNT1", "10R", "Device:R", 30, 250) + "\n"  # 10Ω for INA219
    schematic += create_component("R_SHUNT2", "0.01R", "Device:R", 170, 250) + "\n"  # 0.01Ω for INA228
    
    # Connectors
    schematic += "\n  ;; Connectors\n"
    schematic += create_component("J1", "USB-C", "Connector:Conn_01x06_Male", 100, 50) + "\n"
    schematic += create_component("J2", "Header_30pin", "Connector_Generic:Conn_01x30_Male", 100, 300) + "\n"
    
    # Decoupling Capacitors
    schematic += "\n  ;; Decoupling Capacitors\n"
    schematic += create_component("C1", "0.1uF", "Device:C", 80, 100) + "\n"
    schematic += create_component("C2", "0.1uF", "Device:C", 120, 100) + "\n"
    schematic += create_component("C3", "0.1uF", "Device:C", 100, 80) + "\n"
    schematic += create_component("C4", "0.1uF", "Device:C", 40, 200) + "\n"  # INA219
    schematic += create_component("C5", "0.1uF", "Device:C", 60, 200) + "\n"  # INA219
    schematic += create_component("C6", "0.1uF", "Device:C", 140, 200) + "\n"  # INA228
    schematic += create_component("C7", "0.1uF", "Device:C", 160, 200) + "\n"  # INA228
    schematic += create_component("C8", "10uF", "Device:C", 100, 60) + "\n"  # Bulk cap
    
    # I2C Pull-up Resistors
    schematic += "\n  ;; I2C Pull-up Resistors\n"
    schematic += create_component("R1", "10k", "Device:R", 70, 250) + "\n"  # SCL pull-up
    schematic += create_component("R2", "10k", "Device:R", 130, 250) + "\n"  # SDA pull-up
    
    # Optional LED
    schematic += "\n  ;; Optional Status LED\n"
    schematic += create_component("LED1", "LED", "Device:LED", 180, 100) + "\n"
    schematic += create_component("R_LED1", "1k", "Device:R", 180, 120) + "\n"
    
    # Power Symbols
    schematic += "\n  ;; Power Symbols\n"
    schematic += create_power_symbol("+3V3", 20, 100) + "\n"
    schematic += create_power_symbol("+5V", 20, 80) + "\n"
    schematic += create_power_symbol("GND", 20, 120) + "\n"
    schematic += create_power_symbol("AGND", 20, 140) + "\n"
    
    # Net Labels - Power
    schematic += "\n  ;; Power Net Labels\n"
    schematic += create_label("+3V3", 25, 100) + "\n"
    schematic += create_label("+5V", 25, 80) + "\n"
    schematic += create_label("GND", 25, 120) + "\n"
    schematic += create_label("AGND", 25, 140) + "\n"
    
    # Net Labels - I2C Bus (shared between INA219 and INA228)
    schematic += "\n  ;; I2C Net Labels\n"
    schematic += create_label("I2C_SCL", 90, 250) + "\n"
    schematic += create_label("I2C_SDA", 110, 250) + "\n"
    
    # Net Labels - UART (4 channels from FT4232H)
    schematic += "\n  ;; UART Net Labels\n"
    uart_labels = [
        ("UART1_TX", 90, 280), ("UART1_RX", 90, 290),
        ("UART2_TX", 100, 280), ("UART2_RX", 100, 290),
        ("UART3_TX", 110, 280), ("UART3_RX", 110, 290),
        ("UART4_TX", 120, 280), ("UART4_RX", 120, 290),
    ]
    for name, x, y in uart_labels:
        schematic += create_label(name, x, y) + "\n"
    
    # Net Labels - GPIO (4 boot mode pins + reset)
    schematic += "\n  ;; GPIO Net Labels\n"
    gpio_labels = [
        ("BOOT_MODE_0", 85, 310), ("BOOT_MODE_1", 90, 310),
        ("BOOT_MODE_2", 95, 310), ("BOOT_MODE_3", 100, 310),
        ("RESET", 105, 310),
    ]
    for name, x, y in gpio_labels:
        schematic += create_label(name, x, y) + "\n"
    
    # Net Labels - Power Monitoring
    schematic += "\n  ;; Power Monitoring Net Labels\n"
    schematic += create_label("VDD_IN", 25, 260) + "\n"  # Power input to shunts
    schematic += create_label("VDD_OUT_219", 35, 260) + "\n"  # After INA219 shunt
    schematic += create_label("VDD_OUT_228", 165, 260) + "\n"  # After INA228 shunt
    schematic += create_label("VDD_OUT", 175, 260) + "\n"  # Final output
    
    schematic += """
  (sheet_instances
    (path "/00000000-0000-0000-0000-000000000000" (page "1"))
  )
)"""
    
    return schematic

def main():
    """Main function"""
    script_dir = Path(__file__).parent
    project_root = script_dir.parent
    project_dir = project_root / "hardware" / "schematics" / "esl-dut-dongle"
    schematic_file = project_dir / "esl-dut-dongle.kicad_sch"
    
    # Backup existing schematic
    if schematic_file.exists():
        backup_file = schematic_file.with_suffix('.kicad_sch.backup')
        schematic_file.rename(backup_file)
        print(f"✅ Backed up existing schematic to {backup_file.name}")
    
    # Generate new schematic
    schematic_content = generate_schematic()
    schematic_file.write_text(schematic_content)
    
    print(f"✅ Generated schematic: {schematic_file}")
    print("\n📋 Components Added:")
    print("   ✅ U1: FT4232H (USB bridge)")
    print("   ✅ U2: INA219 (Power monitor - μA range)")
    print("   ✅ U3: INA228 (Power monitor - nA range)")
    print("   ✅ R_SHUNT1: 10Ω (for INA219)")
    print("   ✅ R_SHUNT2: 0.01Ω (for INA228)")
    print("   ✅ J1: USB-C connector")
    print("   ✅ J2: 30-pin header (target board)")
    print("   ✅ Decoupling capacitors")
    print("   ✅ I2C pull-up resistors")
    print("\n📋 Features:")
    print("   ✅ 4 UART channels (UART1-4)")
    print("   ✅ 4 boot mode GPIOs")
    print("   ✅ 1 reset GPIO")
    print("   ✅ Dual I2C power monitoring (INA219 + INA228)")
    print("   ✅ Dual shunt resistors (10Ω + 0.01Ω)")
    print("\n⚠️  Next Steps:")
    print("   1. Open in KiCAD to verify symbols load correctly")
    print("   2. Add wire connections between components")
    print("   3. Run ERC (Electrical Rules Check)")
    print("   4. Assign footprints")

if __name__ == "__main__":
    main()

