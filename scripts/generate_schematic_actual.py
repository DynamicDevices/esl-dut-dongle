#!/usr/bin/env python3
"""
Generate KiCAD Schematic Based on Actual Design Decisions
Updated to reflect confirmed design specification
"""

import uuid
from pathlib import Path

def generate_uuid():
    """Generate a UUID for KiCAD"""
    return str(uuid.uuid4())

def format_position(x, y):
    """Format position in KiCAD units (0.1mm)"""
    return f"{x} {y}"

def create_component(ref, value, lib_id, x, y, rotation=0):
    """Create a component symbol"""
    comp_uuid = generate_uuid()
    return f"""  (symbol (lib_id "{lib_id}") (at {x} {y} {rotation})
    (unit 1)
    (in_bom yes)
    (on_board yes)
    (uuid {comp_uuid})
    (property "Reference" "{ref}" (at {x} {y-20} 0)
      (effects (font (size 1.27 1.27)) (justify left bottom))
    )
    (property "Value" "{value}" (at {x} {y+20} 0)
      (effects (font (size 1.27 1.27)) (justify left top))
    )
    (property "Footprint" "" (at {x} {y} 0)
      (effects (font (size 1.27 1.27)) hide)
    )
    (property "Datasheet" "" (at {x} {y} 0)
      (effects (font (size 1.27 1.27)) hide)
    )
  )"""

def create_power_symbol(name, x, y):
    """Create a power symbol"""
    power_uuid = generate_uuid()
    pin_uuid = generate_uuid()
    return f"""  (power
    (uuid {power_uuid})
    (at {x} {y} 0)
    (pin_names (offset 1.016))
    (name "{name}")
    (pin "{name}" (uuid {pin_uuid}))
  )"""

def create_label(name, x, y):
    """Create a net label"""
    label_uuid = generate_uuid()
    return f"""  (label "{name}" (at {x} {y} 0)
    (fields_autoplaced)
    (effects (font (size 1.27 1.27)) (justify left bottom))
    (uuid {label_uuid})
  )"""

def generate_schematic():
    """Generate the complete schematic based on actual design decisions"""
    
    schematic = """(kicad_sch (version 20231120) (generator "schematic_generator_actual")
  (uuid """ + generate_uuid() + """)
  (paper "A4")
  (title_block
    (title "ESL DUT Dongle - Example Design (Actual Decisions)")
    (date "2025-11-17")
    (rev "0.2")
    (company "Active Edge Solutions")
    (comment 1 "Example/Investigation Project")
    (comment 2 "Based on Actual Design Decisions")
    (comment 3 "FT4232H + INA219 + 0.01Ω shunt")
    (comment 4 "NOT the actual hardware design")
  )
  (lib_symbols)
  (junction (uuid """ + generate_uuid() + """) (at 0 0) (diameter 0) (color 0 0 0 0) (pin_names (offset 0)) (name "")
    (fields_autoplaced))
"""
    
    # Main ICs
    schematic += "\n  ;; Main ICs\n"
    schematic += create_component("U1", "FT4232H-56Q-REEL", "FT4232H:FT4232H-56Q-REEL", 100, 100) + "\n"
    schematic += create_component("U2", "INA219", "INA219:module_ina219", 50, 200) + "\n"
    
    # Connectors
    schematic += "\n  ;; Connectors\n"
    schematic += create_component("J1", "USB-C", "Connector:Conn_01x06_Male", 100, 50) + "\n"
    schematic += create_component("J2", "Header_20pin", "Connector_Generic:Conn_01x20_Male", 100, 300) + "\n"
    
    # Decoupling Capacitors
    schematic += "\n  ;; Decoupling Capacitors\n"
    schematic += create_component("C1", "0.1uF", "Device:C", 80, 100) + "\n"
    schematic += create_component("C2", "0.1uF", "Device:C", 120, 100) + "\n"
    schematic += create_component("C3", "0.1uF", "Device:C", 100, 80) + "\n"
    schematic += create_component("C4", "0.1uF", "Device:C", 40, 200) + "\n"
    schematic += create_component("C5", "0.1uF", "Device:C", 60, 200) + "\n"
    schematic += create_component("C6", "10uF", "Device:C", 100, 60) + "\n"
    
    # I2C Pull-up Resistors
    schematic += "\n  ;; I2C Pull-up Resistors\n"
    schematic += create_component("R1", "10k", "Device:R", 70, 250) + "\n"
    schematic += create_component("R2", "10k", "Device:R", 130, 250) + "\n"
    
    # Power Monitoring Components
    schematic += "\n  ;; Power Monitoring\n"
    schematic += create_component("R_SHUNT", "0.01R", "Device:R", 30, 250) + "\n"
    
    # Optional LED
    schematic += "\n  ;; Optional LED\n"
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
    
    # Net Labels - I2C
    schematic += "\n  ;; I2C Net Labels\n"
    schematic += create_label("I2C_SCL", 90, 250) + "\n"
    schematic += create_label("I2C_SDA", 110, 250) + "\n"
    
    # Net Labels - UART (4 channels)
    schematic += "\n  ;; UART Net Labels\n"
    uart_labels = [
        ("UART1_TX", 90, 280), ("UART1_RX", 90, 290),
        ("UART2_TX", 100, 280), ("UART2_RX", 100, 290),
        ("UART3_TX", 110, 280), ("UART3_RX", 110, 290),
        ("UART4_TX", 120, 280), ("UART4_RX", 120, 290),
    ]
    for name, x, y in uart_labels:
        schematic += create_label(name, x, y) + "\n"
    
    # Net Labels - GPIO
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
    schematic += create_label("VDD_IN", 25, 260) + "\n"
    schematic += create_label("VDD_OUT", 35, 260) + "\n"
    
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
    project_dir = project_root / "hardware" / "examples" / "pcb-design-investigation" / "kicad-project"
    schematic_file = project_dir / "esl-dut-dongle-example.kicad_sch"
    
    # Backup existing schematic
    if schematic_file.exists():
        backup_file = schematic_file.with_suffix('.kicad_sch.backup')
        schematic_file.rename(backup_file)
        print(f"✅ Backed up existing schematic to {backup_file.name}")
    
    # Generate new schematic
    schematic_content = generate_schematic()
    schematic_file.write_text(schematic_content)
    
    print(f"✅ Generated schematic: {schematic_file}")
    print("\n📋 Components:")
    print("   ✅ FT4232H (U1) - USB bridge")
    print("   ✅ INA219 (U2) - Power monitor")
    print("   ✅ 0.01Ω shunt resistor")
    print("   ✅ USB-C connector")
    print("   ✅ 2.54mm headers")
    print("\n📋 Features:")
    print("   ✅ 4 UART channels")
    print("   ✅ 4 boot mode GPIOs")
    print("   ✅ 1 reset GPIO")
    print("   ✅ I2C power monitoring")
    print("\n⚠️  Note: Open in KiCAD to verify and add wire connections")

if __name__ == "__main__":
    main()

