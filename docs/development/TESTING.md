# Testing Guidelines

## Hardware Testing

### Power-On Testing
- [ ] Verify power supply voltages
- [ ] Check for shorts
- [ ] Measure quiescent current
- [ ] Verify USB enumeration

### Functional Testing
- [ ] UART communication test
- [ ] GPIO control test
- [ ] Power monitoring accuracy test
- [ ] OpenOCD integration test

### Power Monitoring Testing
- [ ] Calibrate INA219/INA228
- [ ] Test at various current levels
- [ ] Verify nanoamp measurements (if applicable)
- [ ] Compare with reference meter

### Integration Testing
- [ ] Test with i.MX8M Mini board
- [ ] Test with i.MX93 board
- [ ] Test boot mode control
- [ ] Test reset functionality
- [ ] Test automated flashing

## Software Testing

### Unit Tests
- Test individual functions
- Mock hardware interfaces
- Verify error handling

### Integration Tests
- Test with actual hardware
- Verify end-to-end functionality
- Test error recovery

### Performance Tests
- Measure response times
- Test sampling rates
- Verify real-time capabilities

## Test Equipment

### Required
- Multimeter
- Oscilloscope (for signal verification)
- Power supply (for testing)
- Reference power meter (for calibration)

### Optional
- Logic analyzer
- Network analyzer (for USB)
- Thermal camera (for thermal testing)

## Test Procedures

### Power Monitoring Calibration
1. Connect known current source
2. Measure with reference meter
3. Read INA219/INA228 value
4. Calculate correction factor
5. Apply correction in software

### GPIO Testing
1. Set GPIO high
2. Measure voltage
3. Set GPIO low
4. Measure voltage
5. Verify timing

### UART Testing
1. Send test pattern
2. Receive and verify
3. Test at various baud rates
4. Verify flow control

## Test Results Documentation

Document all test results:
- Test date and conditions
- Equipment used
- Results and observations
- Issues found and resolutions

## Continuous Testing

- Run tests before committing
- Automated tests in CI/CD (future)
- Regular regression testing
- User acceptance testing

