# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- Review package for hardware engineering review
- Comprehensive design review documentation

## [0.2.0] - 2025-11-18

### Added
- Complete schematic design (19 components, 93 connections)
- Custom symbol libraries (FT4232H, INA219, INA228)
- Custom footprints for all main components
- Automated schematic generation scripts
- Complete netlist documentation
- Design review package (`docs/REVIEW_FOR_MICHAEL.md`)
- KiCAD project files (schematic, PCB template)

### Changed
- Updated README with current project status
- Updated design specification with final decisions
- BOM updated to reflect dual-range power monitoring

### Fixed
- Schematic generation with proper component placement
- Wire connections automated
- Power symbol formatting corrected

## [0.1.0] - 2024-11-17

### Added
- Initial project structure and documentation
- Research on FTDI FT2232H/FT4232H solutions
- Research on CP2108 alternative
- Power monitoring analysis (INA219, INA228)
- BOM and cost analysis
- Supplier availability research
- Open-source project research (Tigard, Bus Pirate)
- Project reorganization following hardware development best practices
- Design specification (26 questions answered)

