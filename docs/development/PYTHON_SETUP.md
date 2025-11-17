# Python Setup Summary

## Current Python Installation

### System Python 3.10 ✅
- **Version:** Python 3.10.12
- **Location:** `/usr/bin/python3.10`
- **Status:** Installed and working
- **Pip:** Available (upgraded to 25.3)

### Anaconda Python 3.8.5 (Default)
- **Version:** Python 3.8.5
- **Location:** `/home/ajlennon/anaconda3/bin/python3`
- **Status:** Default `python3` command (via Anaconda)
- **Note:** This is your default Python due to Anaconda being in PATH first

## Using Python 3.10

### Explicit Usage

To use Python 3.10 explicitly, use `python3.10` command:

```bash
# Check version
python3.10 --version
# Output: Python 3.10.12

# Create virtual environment with Python 3.10
python3.10 -m venv myenv

# Run scripts with Python 3.10
python3.10 script.py

# Install packages with pip
python3.10 -m pip install package_name
```

### For KiCAD MCP Installation

The installation script (`scripts/install_kicad_mcp.sh`) now automatically uses Python 3.10:

```bash
./scripts/install_kicad_mcp.sh
```

The script will:
1. Detect Python 3.10 automatically
2. Use it for creating virtual environments
3. Install dependencies with Python 3.10

## Virtual Environments

### Create Virtual Environment with Python 3.10

```bash
# Create venv with Python 3.10
python3.10 -m venv venv_name

# Activate
source venv_name/bin/activate

# Verify Python version in venv
python --version
# Should show: Python 3.10.12
```

### Example: KiCAD MCP Virtual Environment

```bash
cd ~/tools/kicad-mcp
python3.10 -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
```

## Changing Default Python (Optional)

**⚠️ Warning:** Changing the default `python3` may affect Anaconda and other tools.

If you want to prioritize system Python 3.10:

### Option 1: Update PATH (Temporary)

```bash
# Add system Python to PATH before Anaconda
export PATH="/usr/bin:$PATH"

# Verify
which python3
python3 --version
```

### Option 2: Create Alias (Recommended)

Add to `~/.bashrc` or `~/.zshrc`:

```bash
# Alias for Python 3.10
alias python310='/usr/bin/python3.10'
alias pip310='/usr/bin/python3.10 -m pip'
```

Then:
```bash
source ~/.bashrc  # or ~/.zshrc
python310 --version
```

### Option 3: Use pyenv (Advanced)

For managing multiple Python versions:

```bash
# Install pyenv
curl https://pyenv.run | bash

# Install Python 3.10
pyenv install 3.10.12

# Set local version
cd /path/to/project
pyenv local 3.10.12
```

## Recommended Approach

**For this project:** Use `python3.10` explicitly when needed:

1. **KiCAD MCP:** Script handles this automatically
2. **New projects:** Use `python3.10 -m venv` for virtual environments
3. **Existing projects:** Keep using `python3` (Anaconda) unless you need 3.10+

## Verification

```bash
# Check Python 3.10
python3.10 --version
# Expected: Python 3.10.12

# Check pip for Python 3.10
python3.10 -m pip --version
# Expected: pip 25.3 from /usr/lib/python3/dist-packages/pip

# Check default Python
python3 --version
# Expected: Python 3.8.5 (from Anaconda)
```

## Next Steps

1. ✅ Python 3.10 is installed and ready
2. ✅ Installation script updated to use Python 3.10
3. **Install KiCAD MCP:** Run `./scripts/install_kicad_mcp.sh`
4. **Use Python 3.10:** Use `python3.10` command explicitly when needed

## Notes

- Python 3.10 is installed system-wide and available
- Default `python3` still points to Anaconda (Python 3.8.5)
- This is fine - use `python3.10` when you need Python 3.10+
- Virtual environments will use the Python version you specify
- KiCAD MCP installation script uses Python 3.10 automatically

