# Contributing to ESL DUT Dongle

Thank you for your interest in contributing to the ESL DUT Dongle project!

## Development Process

1. **Create a branch** from `main` for your work
2. **Make changes** following our coding standards
3. **Test thoroughly** before submitting
4. **Submit a pull request** with a clear description

## Coding Standards

### Hardware Design
- Follow KiCad design rules and best practices
- Document all design decisions in commit messages
- Include design review checklist before committing

### Software/Firmware
- Follow language-specific style guides (PEP 8 for Python, etc.)
- Add comments for complex logic
- Include unit tests where applicable

## Commit Messages

Use clear, descriptive commit messages:
- Start with a verb in imperative mood
- Keep first line under 72 characters
- Add detailed description if needed

Example:
```
Add INA219 power monitoring driver

Implements basic I2C communication with INA219 via FTDI MPSSE.
Supports voltage, current, and power reading.
```

## Pull Request Process

1. Ensure all tests pass
2. Update documentation if needed
3. Request review from maintainers
4. Address feedback promptly

## Hardware Design Guidelines

- Review schematics before PCB layout
- Run DRC (Design Rule Check) before committing
- Document component selection rationale
- Include assembly notes for complex sections

## Questions?

Feel free to open an issue for questions or discussions.

