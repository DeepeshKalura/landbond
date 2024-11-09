import requests
import uuid
import datetime
from firebase_admin import credentials, firestore, initialize_app, storage

# Initialize Firebase Admin SDK and Storage
cred = credentials.Certificate("serviceAccountKey.json")  # Path to your service account key
initialize_app(cred, {
    'storageBucket': 'realestate-a695d.appspot.com'
})
db = firestore.client()
bucket = storage.bucket()

# Generate a unique folder name and file path
name_folder = f"property/{uuid.uuid4()}.jpg"

# Download the image from the provided URL
image_url = "https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fwww.vardhmangrandeur.com%2Fassets%2Fproject%2F2.jpg&f=1&nofb=1&ipt=e4287519469db98484f82958e965cc21ffb0791a6b2df757d40a886919473377&ipo=images"
response = requests.get(image_url)

# Check if the request was successful
if response.status_code == 200:
    image_data = response.content
    
    # Upload image to Firebase Storage
    blob = bucket.blob(name_folder)
    blob.upload_from_string(image_data, content_type="image/jpeg")

    # Generate a signed download URL for the uploaded image
    download_url = blob.generate_signed_url(datetime.timedelta(seconds=300), method='GET')
    print(f"Image uploaded successfully. Download URL: {download_url}")
else:
    print("Failed to download the image. Status code:", response.status_code)
