# Google Docs Export - Ready to Use! ✅

Your OAuth credentials are now set up and ready to use.

## Quick Start

### 1. Create Your Google Doc

Create a Google Doc with the design specification questionnaire answers and share it with your colleague.

### 2. Get the Document ID

From the Google Doc URL:
```
https://docs.google.com/document/d/DOCUMENT_ID/edit
                                    ^^^^^^^^^^^^
                                    Copy this part
```

### 3. Export to Repository

```bash
export GOOGLE_DOC_ID='your-document-id-here'
python3 scripts/export_google_doc.py
```

**First time:** A browser will open for authentication. After that, it's automatic.

### 4. Review and Commit

```bash
# Review the exported file
cat docs/requirements/DESIGN_SPEC_ANSWERS.md

# Commit to repository
git add docs/requirements/DESIGN_SPEC_ANSWERS.md
git commit -m "Update design spec answers from Google Docs"
git push
```

## Example

```bash
# Set document ID (replace with your actual ID)
export GOOGLE_DOC_ID='1a2b3c4d5e6f7g8h9i0j'

# Export (first time will open browser)
python3 scripts/export_google_doc.py

# Review changes
git diff docs/requirements/DESIGN_SPEC_ANSWERS.md

# Commit
git add docs/requirements/DESIGN_SPEC_ANSWERS.md
git commit -m "Update design spec answers"
git push
```

## Troubleshooting

### "API not enabled"
- Go to https://console.cloud.google.com/apis/library
- Enable "Google Docs API"

### "Access denied"
- Make sure you added your email as a test user in OAuth consent screen
- Make sure you're using the same Google account

### "Document not found"
- Check that the GOOGLE_DOC_ID is correct
- Make sure the document is shared with your Google account

## Security Note

✅ Your credentials are saved in `scripts/credentials.json`  
✅ This file is in `.gitignore` and won't be committed  
✅ File permissions are set to 600 (owner read/write only)

