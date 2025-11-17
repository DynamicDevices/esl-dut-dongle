# Next Steps: Export Google Docs

## Current Status ✅

- ✅ Python packages installed
- ✅ OAuth credentials configured
- ✅ Export script ready

## Step-by-Step Instructions

### Step 1: Create or Open Your Google Doc

1. **Create a new Google Doc** (or use existing one)
2. **Copy the questionnaire** from `docs/requirements/DESIGN_SPEC_ANSWERS.md` into the Google Doc
3. **Share with your colleague** for collaboration
4. **Fill in the answers** together

### Step 2: Get the Document ID

From your Google Doc URL:
```
https://docs.google.com/document/d/1a2b3c4d5e6f7g8h9i0j/edit
                                    ^^^^^^^^^^^^
                                    This is the Document ID
```

**Copy the Document ID** (the long string between `/d/` and `/edit`)

### Step 3: Export the Document

Run the export script:

```bash
cd /home/ajlennon/data_drive/esl/esl-dut-dongle

# Set the document ID
export GOOGLE_DOC_ID='your-document-id-here'

# Run the export
python3 scripts/export_google_doc.py
```

**First time:** A browser window will open for authentication:
- Sign in with your Google account
- Click "Allow" to grant permissions
- The script will continue automatically

**Subsequent runs:** Will work automatically without browser.

### Step 4: Review the Exported File

The script exports to:
```
docs/requirements/DESIGN_SPEC_ANSWERS.md
```

Review it:
```bash
cat docs/requirements/DESIGN_SPEC_ANSWERS.md
# or
less docs/requirements/DESIGN_SPEC_ANSWERS.md
```

### Step 5: Commit to Repository

```bash
# Check what changed
git diff docs/requirements/DESIGN_SPEC_ANSWERS.md

# Add and commit
git add docs/requirements/DESIGN_SPEC_ANSWERS.md
git commit -m "Update design spec answers from Google Docs"
git push
```

## Example Workflow

```bash
# 1. Set document ID (replace with your actual ID)
export GOOGLE_DOC_ID='1a2b3c4d5e6f7g8h9i0j'

# 2. Export (first time opens browser)
python3 scripts/export_google_doc.py

# 3. Review
git diff docs/requirements/DESIGN_SPEC_ANSWERS.md

# 4. Commit
git add docs/requirements/DESIGN_SPEC_ANSWERS.md
git commit -m "Update design spec answers"
git push
```

## Troubleshooting

### "Document not found"
- Check that GOOGLE_DOC_ID is correct
- Make sure the document is shared with your Google account
- Make sure you're signed in with the correct Google account

### "Access denied"
- Make sure you added your email as a test user in OAuth consent screen
- Make sure the document is shared with your Google account
- Try deleting `scripts/token.pickle` and running again

### "API not enabled"
- Go to https://console.cloud.google.com/apis/library
- Enable "Google Docs API"

### Browser doesn't open
- Check that you have a browser available
- Try running from a terminal with display access
- Or manually authenticate and copy the token

## Quick Reference

**Document ID location:**
```
https://docs.google.com/document/d/[DOCUMENT_ID]/edit
```

**Export command:**
```bash
export GOOGLE_DOC_ID='your-id'
python3 scripts/export_google_doc.py
```

**Output file:**
```
docs/requirements/DESIGN_SPEC_ANSWERS.md
```

## After Export

Once you have the answers in `DESIGN_SPEC_ANSWERS.md`, I can:
1. Read the file automatically
2. Validate that all questions are answered
3. Generate the detailed design specification document
4. Flag any missing critical information

Just let me know when the file is ready!

