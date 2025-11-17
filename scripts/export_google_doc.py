#!/usr/bin/env python3
"""
Export Google Docs to Markdown for Design Specification Answers

This script uses the Google Docs API to export a Google Doc to markdown format
and save it to the repository.

Requirements:
    pip install google-api-python-client google-auth-httplib2 google-auth-oauthlib

Setup:
    1. Create Google Cloud project
    2. Enable Google Docs API
    3. Create OAuth 2.0 credentials
    4. Download credentials JSON file
    5. Run script (will open browser for authentication)
"""

import os
import sys
from pathlib import Path

try:
    from google.oauth2.credentials import Credentials
    from google_auth_oauthlib.flow import InstalledAppFlow
    from google.auth.transport.requests import Request
    from googleapiclient.discovery import build
    from googleapiclient.errors import HttpError
    import pickle
except ImportError:
    print("Error: Required packages not installed.")
    print("Install with: pip install google-api-python-client google-auth-httplib2 google-auth-oauthlib")
    sys.exit(1)

# If modifying these scopes, delete the file token.pickle.
SCOPES = ['https://www.googleapis.com/auth/documents.readonly']

# Path to credentials file (download from Google Cloud Console)
CREDENTIALS_FILE = 'credentials.json'
TOKEN_FILE = 'token.pickle'

# Google Doc ID (found in the document URL)
# Example: https://docs.google.com/document/d/DOCUMENT_ID/edit
DOCUMENT_ID = os.getenv('GOOGLE_DOC_ID', '')

# Output file
OUTPUT_FILE = Path(__file__).parent.parent / 'docs' / 'requirements' / 'DESIGN_SPEC_ANSWERS.md'


def get_credentials():
    """Get valid user credentials from storage or prompt for authorization."""
    creds = None
    
    # Load existing token
    if os.path.exists(TOKEN_FILE):
        with open(TOKEN_FILE, 'rb') as token:
            creds = pickle.load(token)
    
    # If there are no (valid) credentials available, let the user log in.
    if not creds or not creds.valid:
        if creds and creds.expired and creds.refresh_token:
            creds.refresh(Request())
        else:
            if not os.path.exists(CREDENTIALS_FILE):
                print(f"Error: {CREDENTIALS_FILE} not found.")
                print("Please download credentials from Google Cloud Console:")
                print("1. Go to https://console.cloud.google.com/")
                print("2. Create a project (or select existing)")
                print("3. Enable Google Docs API")
                print("4. Create OAuth 2.0 credentials")
                print("5. Download as JSON and save as 'credentials.json'")
                sys.exit(1)
            
            flow = InstalledAppFlow.from_client_secrets_file(CREDENTIALS_FILE, SCOPES)
            creds = flow.run_local_server(port=0)
        
        # Save credentials for next run
        with open(TOKEN_FILE, 'wb') as token:
            pickle.dump(creds, token)
    
    return creds


def export_document_to_markdown(document_id, output_file):
    """Export Google Doc to markdown format."""
    creds = get_credentials()
    
    try:
        service = build('docs', 'v1', credentials=creds)
        
        # Get document content
        doc = service.documents().get(documentId=document_id).execute()
        
        # Convert to markdown (basic conversion)
        markdown_content = convert_to_markdown(doc)
        
        # Write to file
        output_file.parent.mkdir(parents=True, exist_ok=True)
        with open(output_file, 'w', encoding='utf-8') as f:
            f.write(markdown_content)
        
        print(f"Successfully exported to {output_file}")
        return True
        
    except HttpError as error:
        print(f"An error occurred: {error}")
        return False


def convert_to_markdown(doc):
    """Convert Google Doc structure to markdown."""
    content = doc.get('body', {}).get('content', [])
    markdown = []
    
    # Add title
    if 'title' in doc:
        markdown.append(f"# {doc['title']}\n")
    
    # Process content
    for element in content:
        if 'paragraph' in element:
            markdown.append(process_paragraph(element['paragraph']))
        elif 'table' in element:
            markdown.append(process_table(element['table']))
    
    return '\n'.join(markdown)


def process_paragraph(paragraph):
    """Process a paragraph element."""
    text = ''
    elements = paragraph.get('elements', [])
    
    for elem in elements:
        if 'textRun' in elem:
            text_run = elem['textRun']
            content = text_run.get('content', '')
            
            # Apply formatting
            style = text_run.get('textStyle', {})
            if style.get('bold'):
                content = f"**{content}**"
            if style.get('italic'):
                content = f"*{content}*"
            
            text += content
    
    # Check paragraph style
    style = paragraph.get('paragraphStyle', {})
    named_style = style.get('namedStyleType', '')
    
    if named_style == 'HEADING_1':
        return f"# {text.strip()}\n"
    elif named_style == 'HEADING_2':
        return f"## {text.strip()}\n"
    elif named_style == 'HEADING_3':
        return f"### {text.strip()}\n"
    else:
        return text


def process_table(table):
    """Process a table element (basic conversion)."""
    # Basic table conversion - can be enhanced
    return "\n[Table content - may need manual formatting]\n"


if __name__ == '__main__':
    if not DOCUMENT_ID:
        print("Error: GOOGLE_DOC_ID environment variable not set.")
        print("Set it with: export GOOGLE_DOC_ID='your-document-id'")
        print("Or edit the script to set DOCUMENT_ID directly")
        sys.exit(1)
    
    print(f"Exporting Google Doc: {DOCUMENT_ID}")
    print(f"Output file: {OUTPUT_FILE}")
    
    success = export_document_to_markdown(DOCUMENT_ID, OUTPUT_FILE)
    
    if success:
        print("\nExport complete!")
        print(f"File saved to: {OUTPUT_FILE}")
        print("\nNext steps:")
        print("1. Review the exported markdown file")
        print("2. Commit to git: git add docs/requirements/DESIGN_SPEC_ANSWERS.md")
        print("3. Commit: git commit -m 'Update design spec answers from Google Docs'")
    else:
        print("\nExport failed. Check error messages above.")
        sys.exit(1)

