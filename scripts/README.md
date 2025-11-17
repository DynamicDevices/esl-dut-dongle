# Scripts

Utility scripts for the ESL DUT dongle project.

## export_google_doc.py

Exports a Google Doc to markdown format for the design specification answers.

### Setup

1. **Install dependencies:**
   ```bash
   pip install google-api-python-client google-auth-httplib2 google-auth-oauthlib
   ```

2. **Create Google Cloud project:**
   - Go to https://console.cloud.google.com/
   - Create a new project (or select existing)
   - Enable "Google Docs API"

3. **Create OAuth credentials:**
   - Go to "Credentials" → "Create Credentials" → "OAuth client ID"
   - Choose "Desktop app"
   - Download JSON file
   - Save as `credentials.json` in this directory

4. **Get Google Doc ID:**
   - Open your Google Doc
   - Copy the document ID from the URL:
     `https://docs.google.com/document/d/DOCUMENT_ID/edit`
   - Set environment variable:
     ```bash
     export GOOGLE_DOC_ID='your-document-id'
     ```

### Usage

```bash
export GOOGLE_DOC_ID='your-document-id'
python3 scripts/export_google_doc.py
```

First run will open a browser for authentication. After that, it will export automatically.

### Output

The script exports the Google Doc to:
`docs/requirements/DESIGN_SPEC_ANSWERS.md`

You can then commit this file to the repository.

