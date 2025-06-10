import os
from time import strftime
import json
import base64
from google.oauth2 import service_account
from googleapiclient.discovery import build
from googleapiclient.http import MediaFileUpload

def upload_to_drive(file_path, folder_id, credentials_b64, drive_file_name):
    # Decode the base64 encoded credentials
    credentials_json = base64.b64decode(credentials_b64).decode('utf-8')
    credentials_info = json.loads(credentials_json)

    # Authenticate using the service account credentials
    credentials = service_account.Credentials.from_service_account_info(credentials_info, scopes=['https://www.googleapis.com/auth/drive'])

    # Build the Drive service
    service = build('drive', 'v3', credentials=credentials)

    prefix = strftime("%Y%m%d%H%M%S_")

    # Prepare the file for upload
    file_metadata = {
        'name': prefix + drive_file_name,
        'parents': [folder_id]
    }
    media = MediaFileUpload(file_path, resumable=True)

    # Upload the file
    file = service.files().create(
        body=file_metadata,
        media_body=media,
        fields='id'
    ).execute()

    print(f"File uploaded with ID: {file.get('id')}")

if __name__ == "__main__":
    file_path = os.getenv("FILE_PATH")
    folder_id = os.getenv("FOLDER_ID")
    drive_file_name = os.getenv("DRIVE_FILE_NAME")
    credentials_b64 = os.getenv("GOOGLE_CREDENTIALS")

    upload_to_drive(file_path, folder_id, credentials_b64, drive_file_name)
