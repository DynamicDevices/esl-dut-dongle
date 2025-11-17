# Development Environment Setup

## Hardware Requirements

- Linux development machine (recommended) or Windows with WSL
- USB port for connecting dongle
- Target boards (i.MX8M Mini, i.MX93) for testing

## Software Dependencies

### Required

- **Git** - Version control
- **Python 3.8+** - For development tools
- **libftdi** - FTDI device library
  ```bash
  # Ubuntu/Debian
  sudo apt-get install libftdi1-dev
  
  # Or build from source
  ```

- **OpenOCD** - For debugging support
  ```bash
  # Ubuntu/Debian
  sudo apt-get install openocd
  ```

### Optional

- **KiCad** - For hardware design
  ```bash
  # Ubuntu/Debian
  sudo apt-get install kicad
  
  # Verify installation
  kicad --version
  ```
  
  See `docs/development/KICAD_WORKFLOW.md` for detailed setup and workflow guide.
  See `docs/development/KICAD_QUICK_START.md` for quick start checklist.

- **pyftdi** - Python FTDI library
  ```bash
  pip install pyftdi
  ```

- **pyserial** - Serial communication
  ```bash
  pip install pyserial
  ```

## Development Tools

### FTDI Device Access

On Linux, ensure user has access to FTDI devices:
```bash
# Add user to dialout group
sudo usermod -a -G dialout $USER
# Log out and back in for changes to take effect
```

### Testing FTDI Devices

```bash
# List FTDI devices
lsusb | grep FTDI

# Test with libftdi
ftdi_eeprom --help
```

## Project Setup

1. Clone the repository:
   ```bash
   git clone git@github.com:DynamicDevices/esl-dut-dongle.git
   cd esl-dut-dongle
   ```

2. Review documentation:
   - Start with [README.md](../README.md)
   - Review [PROJECT_REFERENCE.md](../requirements/PROJECT_REFERENCE.md)

3. Set up development environment:
   ```bash
   # Create virtual environment (if using Python)
   python3 -m venv venv
   source venv/bin/activate
   
   # Install dependencies (when requirements.txt is added)
   pip install -r requirements.txt
   ```

## Building from Source

### Hardware
- Use KiCad to open schematic/PCB files
- Follow design guidelines in [DESIGN_GUIDELINES.md](DESIGN_GUIDELINES.md)
- Export Gerber files for manufacturing

### Software
- Follow language-specific build instructions
- See `firmware/README.md` for specific build steps

## Troubleshooting

### FTDI Device Not Found
- Check USB connection
- Verify udev rules (Linux)
- Check device permissions

### Permission Denied
- Add user to dialout group (Linux)
- Check USB permissions
- Use sudo if necessary (not recommended for development)

## IDE Setup

### VS Code
- Install Python extension
- Install KiCad extension (for hardware files)
- Configure debugger for firmware development

### Other IDEs
- Follow standard setup for your preferred IDE
- Ensure proper language support

