# Quick Start: Google Docs Export

## Prerequisites Setup (One Time)

### 1. Run Setup Script

```bash
cd esl-dut-dongle
bash scripts/setup_google_docs.sh
```

This will:
- Check Python installation
- Install required packages
- Guide you through getting credentials

### 2. Get Google API Credentials

Follow the instructions in `scripts/GET_GOOGLE_CREDENTIALS.md`

**Quick version:**
1. Go to https://console.cloud.google.com/
2. Create project
3. Enable "Google Docs API"
4. Create OAuth credentials (Desktop app)
5. Download as `scripts/credentials.json`

## Using the Export Script

### 1. Create Google Doc

Create a Google Doc with your design specification questionnaire answers.

### 2. Get Document ID

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

First time will open browser for authentication. After that, it's automatic.

### 4. Review and Commit

```bash
# Review the exported file
cat docs/requirements/DESIGN_SPEC_ANSWERS.md

# Commit to repository
git add docs/requirements/DESIGN_SPEC_ANSWERS.md
git commit -m "Update design spec answers from Google Docs"
git push
```

## Example Workflow

```bash
# 1. Set document ID
export GOOGLE_DOC_ID='1a2b3c4d5e6f7g8h9i0j'

# 2. Export (first time will authenticate)
python3 scripts/export_google_doc.py

# 3. Review changes
git diff docs/requirements/DESIGN_SPEC_ANSWERS.md

# 4. Commit
git add docs/requirements/DESIGN_SPEC_ANSWERS.md
git commit -m "Update design spec answers"
git push
```

## Troubleshooting

### "credentials.json not found"
- Follow `GET_GOOGLE_CREDENTIALS.md` to get credentials
- Make sure file is at `scripts/credentials.json`

### "GOOGLE_DOC_ID not set"
- Set the environment variable: `export GOOGLE_DOC_ID='your-id'`
- Or edit the script to set `DOCUMENT_ID` directly

### Authentication issues
- Delete `scripts/token.pickle` and run again
- Make sure you're using the same Google account
- Check that OAuth consent screen is configured

