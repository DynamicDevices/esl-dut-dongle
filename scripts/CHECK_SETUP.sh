#!/bin/bash
# Check if Google Docs export is properly set up

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "Checking Google Docs export setup..."
echo ""

# Check Python packages
echo "Checking Python packages..."
if python3 -c "import googleapiclient.discovery" 2>/dev/null; then
    echo "✓ Google API Python client installed"
else
    echo "✗ Google API Python client NOT installed"
    echo "  Run: pip3 install --user google-api-python-client google-auth-httplib2 google-auth-oauthlib"
fi

# Check credentials file
echo ""
echo "Checking credentials..."
if [ -f "$SCRIPT_DIR/credentials.json" ]; then
    echo "✓ credentials.json found"
    
    # Check if it's OAuth credentials (not API key)
    if grep -q '"installed"' "$SCRIPT_DIR/credentials.json" || grep -q '"client_id"' "$SCRIPT_DIR/credentials.json"; then
        echo "✓ File appears to be OAuth credentials (correct)"
    else
        echo "⚠ File may not be OAuth credentials - should contain 'client_id' and 'client_secret'"
        echo "  Make sure you downloaded OAuth 2.0 credentials, not just an API key"
    fi
else
    echo "✗ credentials.json NOT found"
    echo ""
    echo "To create credentials:"
    echo "1. Go to: https://console.cloud.google.com/apis/credentials"
    echo "2. Click '+ CREATE CREDENTIALS' → 'OAuth client ID'"
    echo "3. Application type: 'Desktop app'"
    echo "4. Download JSON and save as: $SCRIPT_DIR/credentials.json"
    echo ""
    echo "See SETUP_OAUTH_CREDENTIALS.md for detailed instructions"
fi

# Check token file
echo ""
echo "Checking authentication..."
if [ -f "$SCRIPT_DIR/token.pickle" ]; then
    echo "✓ Authentication token found (already authenticated)"
else
    echo "⚠ No authentication token (will authenticate on first run)"
fi

echo ""
echo "Setup check complete!"

