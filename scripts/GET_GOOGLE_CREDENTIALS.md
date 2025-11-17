# How to Get Google API Credentials

This guide walks you through getting Google API credentials for the export script.

## Step-by-Step Instructions

### 1. Go to Google Cloud Console

Visit: https://console.cloud.google.com/

### 2. Create or Select a Project

- If you don't have a project, click "Create Project"
- Enter project name: "ESL DUT Dongle" (or any name)
- Click "Create"
- Wait for project creation (may take a minute)

### 3. Enable Google Docs API

1. In the left sidebar, go to **"APIs & Services"** → **"Library"**
2. Search for **"Google Docs API"**
3. Click on **"Google Docs API"**
4. Click the **"Enable"** button
5. Wait for API to be enabled

### 4. Create OAuth 2.0 Credentials

1. Go to **"APIs & Services"** → **"Credentials"**
2. Click **"+ CREATE CREDENTIALS"** at the top
3. Select **"OAuth client ID"**
4. If prompted, configure OAuth consent screen:
   - User Type: **"External"** (unless you have Google Workspace)
   - App name: **"ESL DUT Dongle Export"**
   - User support email: Your email
   - Developer contact: Your email
   - Click **"Save and Continue"**
   - Scopes: Click **"Add or Remove Scopes"**
     - Search for and select: **"https://www.googleapis.com/auth/documents.readonly"**
     - Click **"Update"** → **"Save and Continue"**
   - Test users: Add your email (and colleague's email if needed)
   - Click **"Save and Continue"** → **"Back to Dashboard"**

5. Create OAuth Client ID:
   - Application type: **"Desktop app"**
   - Name: **"ESL DUT Dongle Export"**
   - Click **"Create"**

6. **Download the credentials:**
   - Click **"Download JSON"** button
   - Save the file as `credentials.json`
   - Move it to: `scripts/credentials.json`

### 5. Verify Setup

The file should be at:
```
esl-dut-dongle/scripts/credentials.json
```

**Important:** This file contains sensitive credentials. It's already added to `.gitignore` so it won't be committed to git.

## Quick Reference

- **Google Cloud Console:** https://console.cloud.google.com/
- **APIs & Services Library:** https://console.cloud.google.com/apis/library
- **Credentials:** https://console.cloud.google.com/apis/credentials

## Troubleshooting

### "API not enabled" error
- Make sure you enabled "Google Docs API" in step 3

### "Access denied" error
- Make sure you added your email as a test user in OAuth consent screen
- Make sure you're using the same Google account

### "Invalid credentials" error
- Make sure `credentials.json` is in the `scripts/` directory
- Make sure the file is valid JSON (not corrupted)

## Security Note

- Never commit `credentials.json` to git (already in .gitignore)
- Never share credentials publicly
- If credentials are compromised, revoke them in Google Cloud Console and create new ones

