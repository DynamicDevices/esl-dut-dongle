# Setting Up OAuth 2.0 Credentials (Required)

**Important:** The export script needs **OAuth 2.0 credentials**, not just an API key. API keys are for public data, but Google Docs requires OAuth for accessing user documents.

## Quick Setup Guide

### Step 1: Enable Google Docs API

1. Go to: https://console.cloud.google.com/apis/library
2. Search for **"Google Docs API"**
3. Click on it and click **"Enable"**

### Step 2: Configure OAuth Consent Screen

1. Go to: https://console.cloud.google.com/apis/credentials/consent
2. Select **"External"** (unless you have Google Workspace)
3. Click **"Create"**
4. Fill in:
   - **App name:** ESL DUT Dongle Export
   - **User support email:** Your email
   - **Developer contact:** Your email
5. Click **"Save and Continue"**
6. **Scopes:** Click **"Add or Remove Scopes"**
   - Search for: `https://www.googleapis.com/auth/documents.readonly`
   - Check the box
   - Click **"Update"**
   - Click **"Save and Continue"**
7. **Test users:** Add your email (and your colleague's email)
   - Click **"Add Users"**
   - Enter email addresses
   - Click **"Add"**
   - Click **"Save and Continue"**
8. Click **"Back to Dashboard"**

### Step 3: Create OAuth 2.0 Client ID

1. Go to: https://console.cloud.google.com/apis/credentials
2. Click **"+ CREATE CREDENTIALS"** at the top
3. Select **"OAuth client ID"**
4. If prompted about consent screen, you should have already configured it
5. Select:
   - **Application type:** Desktop app
   - **Name:** ESL DUT Dongle Export
6. Click **"Create"**
7. **IMPORTANT:** Click **"Download JSON"** button
8. Save the file as `credentials.json` in the `scripts/` directory

### Step 4: Verify File Location

The file should be at:
```
esl-dut-dongle/scripts/credentials.json
```

### Step 5: Test the Setup

```bash
cd esl-dut-dongle
export GOOGLE_DOC_ID='your-document-id'
python3 scripts/export_google_doc.py
```

First run will open a browser for authentication.

## Direct Links

- **APIs Library:** https://console.cloud.google.com/apis/library
- **OAuth Consent Screen:** https://console.cloud.google.com/apis/credentials/consent
- **Credentials:** https://console.cloud.google.com/apis/credentials

## Troubleshooting

### "API not enabled"
- Make sure you enabled "Google Docs API" in Step 1

### "Access denied" or "User not authorized"
- Make sure you added your email as a test user in OAuth consent screen
- Make sure you're using the same Google account

### "Invalid credentials"
- Make sure you downloaded the OAuth 2.0 credentials (not API key)
- Make sure the file is named exactly `credentials.json`
- Make sure it's in the `scripts/` directory

## What You Should Have

After setup, you should have:
- ✅ Google Docs API enabled
- ✅ OAuth consent screen configured
- ✅ OAuth 2.0 Client ID created (Desktop app type)
- ✅ `credentials.json` file in `scripts/` directory

## Next Steps

Once you have `credentials.json`:
1. Create a Google Doc with the questionnaire
2. Get the document ID from the URL
3. Run the export script

