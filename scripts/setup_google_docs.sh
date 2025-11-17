#!/bin/bash
# Setup script for Google Docs export functionality

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

echo "Setting up Google Docs export workflow..."
echo ""

# Check Python
if ! command -v python3 &> /dev/null; then
    echo "Error: python3 not found. Please install Python 3.8 or later."
    exit 1
fi

echo "✓ Python found: $(python3 --version)"

# Check pip
if ! command -v pip3 &> /dev/null; then
    echo "Error: pip3 not found. Please install pip."
    exit 1
fi

echo "✓ pip found: $(pip3 --version)"
echo ""

# Install Python packages
echo "Installing required Python packages..."
pip3 install --user google-api-python-client google-auth-httplib2 google-auth-oauthlib

echo ""
echo "✓ Python packages installed"
echo ""

# Create credentials directory
CREDENTIALS_DIR="$SCRIPT_DIR"
echo "Credentials will be stored in: $CREDENTIALS_DIR"
echo ""

# Check if credentials.json exists
if [ -f "$CREDENTIALS_DIR/credentials.json" ]; then
    echo "✓ credentials.json found"
else
    echo "⚠ credentials.json not found"
    echo ""
    echo "To get credentials:"
    echo "1. Go to https://console.cloud.google.com/"
    echo "2. Create a new project (or select existing)"
    echo "3. Enable 'Google Docs API':"
    echo "   - Go to 'APIs & Services' → 'Library'"
    echo "   - Search for 'Google Docs API'"
    echo "   - Click 'Enable'"
    echo "4. Create OAuth 2.0 credentials:"
    echo "   - Go to 'APIs & Services' → 'Credentials'"
    echo "   - Click 'Create Credentials' → 'OAuth client ID'"
    echo "   - Application type: 'Desktop app'"
    echo "   - Name: 'ESL DUT Dongle Export'"
    echo "   - Click 'Create'"
    echo "5. Download JSON file"
    echo "6. Save as: $CREDENTIALS_DIR/credentials.json"
    echo ""
fi

# Create .gitignore entry for credentials
GITIGNORE="$PROJECT_ROOT/.gitignore"
if ! grep -q "credentials.json" "$GITIGNORE" 2>/dev/null; then
    echo "" >> "$GITIGNORE"
    echo "# Google API credentials (keep private)" >> "$GITIGNORE"
    echo "scripts/credentials.json" >> "$GITIGNORE"
    echo "scripts/token.pickle" >> "$GITIGNORE"
    echo "✓ Added credentials to .gitignore"
fi

echo ""
echo "Setup complete!"
echo ""
echo "Next steps:"
echo "1. Get Google API credentials (see instructions above if needed)"
echo "2. Create a Google Doc with the design specification questionnaire"
echo "3. Get the document ID from the URL"
echo "4. Export the document:"
echo "   export GOOGLE_DOC_ID='your-document-id'"
echo "   python3 $SCRIPT_DIR/export_google_doc.py"
echo ""

