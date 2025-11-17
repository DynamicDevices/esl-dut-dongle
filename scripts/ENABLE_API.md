# Enable Google Docs API

The export script needs the Google Docs API to be enabled in your Google Cloud project.

## Quick Fix

**Direct link to enable API:**
https://console.developers.google.com/apis/api/docs.googleapis.com/overview?project=944710604130

Or follow these steps:

1. **Go to Google Cloud Console:**
   https://console.cloud.google.com/apis/library?project=944710604130

2. **Search for "Google Docs API"**

3. **Click on "Google Docs API"**

4. **Click "Enable" button**

5. **Wait a few minutes** for the API to be enabled

6. **Try the export again:**
   ```bash
   export GOOGLE_DOC_ID='12w-ATIUjoMkCtFAFUkjTBkfv4HUu7c-wLK_IJ3z1I_o'
   python3 scripts/export_google_doc.py
   ```

## Alternative: Enable via Direct Link

Click this link to enable the API directly:
https://console.developers.google.com/apis/api/docs.googleapis.com/overview?project=944710604130

Then click the "Enable" button.

## After Enabling

Once enabled, wait 1-2 minutes for the change to propagate, then run the export script again.

