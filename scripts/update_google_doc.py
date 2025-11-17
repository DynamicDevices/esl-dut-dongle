#!/usr/bin/env python3
"""
Update Google Docs with Design Specification Changes

This script updates specific answers in the Google Doc design specification.

Requirements:
    pip install google-api-python-client google-auth-httplib2 google-auth-oauthlib

Setup:
    Same as export_google_doc.py - uses same credentials
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

# Write scope (needed to update document)
SCOPES = ['https://www.googleapis.com/auth/documents']

# Path to credentials file
SCRIPT_DIR = Path(__file__).parent
CREDENTIALS_FILE = SCRIPT_DIR / 'credentials.json'
TOKEN_FILE = SCRIPT_DIR / 'token.pickle'

# Google Doc ID
DOCUMENT_ID = os.getenv('GOOGLE_DOC_ID', '12w-ATIUjoMkCtFAFUkjTBkfv4HUu7c-wLK_IJ3z1I_o')


def get_credentials():
    """Get valid user credentials from storage or prompt for authorization."""
    creds = None
    
    # Load existing token
    if TOKEN_FILE.exists():
        with open(TOKEN_FILE, 'rb') as token:
            creds = pickle.load(token)
    
    # If there are no (valid) credentials available, let the user log in.
    if not creds or not creds.valid:
        if creds and creds.expired and creds.refresh_token:
            creds.refresh(Request())
        else:
            if not CREDENTIALS_FILE.exists():
                print(f"Error: {CREDENTIALS_FILE} not found.")
                print("Please download credentials from Google Cloud Console:")
                print("1. Go to https://console.cloud.google.com/")
                print("2. Create a project (or select existing)")
                print("3. Enable Google Docs API")
                print("4. Create OAuth 2.0 credentials")
                print(f"5. Download as JSON and save as '{CREDENTIALS_FILE}'")
                sys.exit(1)
            
            flow = InstalledAppFlow.from_client_secrets_file(str(CREDENTIALS_FILE), SCOPES)
            creds = flow.run_local_server(port=0)
        
        # Save credentials for next run
        with open(TOKEN_FILE, 'wb') as token:
            pickle.dump(creds, token)
    
    return creds


def find_text_in_document(service, document_id, search_text):
    """Find text in document and return its start/end indices."""
    doc = service.documents().get(documentId=document_id).execute()
    content = doc.get('body', {}).get('content', [])
    
    for element in content:
        if 'paragraph' in element:
            paragraph = element['paragraph']
            elements = paragraph.get('elements', [])
            
            for elem in elements:
                if 'textRun' in elem:
                    text_run = elem['textRun']
                    text = text_run.get('content', '')
                    
                    if search_text in text:
                        start_index = elem.get('startIndex', 0)
                        end_index = elem.get('endIndex', 0)
                        return start_index, end_index
    
    return None, None


def update_text_in_document(service, document_id, old_text, new_text):
    """Update text in Google Doc by replacing old_text with new_text."""
    # Find the text
    start_index, end_index = find_text_in_document(service, document_id, old_text)
    
    if start_index is None:
        print(f"Warning: Could not find '{old_text}' in document")
        return False
    
    # Create request to replace text
    requests = [{
        'deleteContentRange': {
            'range': {
                'startIndex': start_index,
                'endIndex': end_index
            }
        }
    }, {
        'insertText': {
            'location': {
                'index': start_index
            },
            'text': new_text
        }
    }]
    
    try:
        service.documents().batchUpdate(
            documentId=document_id,
            body={'requests': requests}
        ).execute()
        return True
    except HttpError as error:
        print(f"Error updating document: {error}")
        return False


def update_design_spec():
    """Update Q4 and Q5 answers in Google Doc."""
    creds = get_credentials()
    service = build('docs', 'v1', credentials=creds)
    
    # Based on exported doc format: "Q4 - ..." and "Q5 - 0.01 ohm"
    updates = [
        {
            'old': 'Q4 -',
            'new': 'Q4 - Dual range (INA219 + INA228)',
            'search_context': 'Q4'
        },
        {
            'old': 'Q5 - 0.01 ohm',
            'new': 'Q5 - Dual shunts: 10Ω (INA219) + 0.01Ω (INA228)',
            'search_context': 'Q5'
        },
        {
            'old': 'Q5 - 0.01Ω',
            'new': 'Q5 - Dual shunts: 10Ω (INA219) + 0.01Ω (INA228)',
            'search_context': 'Q5'
        }
    ]
    
    print(f"Updating Google Doc: {DOCUMENT_ID}")
    print()
    
    # First, get the document to find exact text
    doc = service.documents().get(documentId=DOCUMENT_ID).execute()
    content = doc.get('body', {}).get('content', [])
    
    # Find Q4 and Q5 sections
    q4_text = None
    q5_text = None
    
    for element in content:
        if 'paragraph' in element:
            paragraph = element['paragraph']
            elements = paragraph.get('elements', [])
            
            for elem in elements:
                if 'textRun' in elem:
                    text_run = elem['textRun']
                    text = text_run.get('content', '')
                    
                    if 'Q4 -' in text and len(text.strip()) < 100:
                        q4_text = text.strip()
                    elif 'Q5 -' in text and '0.01' in text:
                        q5_text = text.strip()
    
    print(f"Found Q4: {q4_text}")
    print(f"Found Q5: {q5_text}")
    print()
    
    # Update Q4 if found
    if q4_text and 'Q4 -' in q4_text:
        if 'Dual range' not in q4_text:
            print(f"Updating Q4: '{q4_text}' → 'Q4 - Dual range (INA219 + INA228)'")
            if update_text_in_document(service, DOCUMENT_ID, q4_text, 'Q4 - Dual range (INA219 + INA228)'):
                print("  ✓ Updated")
            else:
                print("  ✗ Failed")
        else:
            print("  ✓ Q4 already updated")
    
    # Update Q5 if found
    if q5_text and 'Q5 -' in q5_text:
        if 'Dual shunts' not in q5_text:
            print(f"Updating Q5: '{q5_text}' → 'Q5 - Dual shunts: 10Ω (INA219) + 0.01Ω (INA228)'")
            if update_text_in_document(service, DOCUMENT_ID, q5_text, 'Q5 - Dual shunts: 10Ω (INA219) + 0.01Ω (INA228)'):
                print("  ✓ Updated")
            else:
                print("  ✗ Failed")
        else:
            print("  ✓ Q5 already updated")
    
    print()
    print("Update complete!")
    print(f"View document: https://docs.google.com/document/d/{DOCUMENT_ID}/edit")


if __name__ == '__main__':
    if not DOCUMENT_ID:
        print("Error: GOOGLE_DOC_ID environment variable not set.")
        print("Set it with: export GOOGLE_DOC_ID='your-document-id'")
        sys.exit(1)
    
    update_design_spec()

