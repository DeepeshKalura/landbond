import json
import uuid
import requests
from firebase_admin import credentials, firestore, initialize_app, storage
from datetime import datetime

cred = credentials.Certificate("serviceAccountKey.json")
initialize_app(cred, {
    'storageBucket': 'realestate-a695d.appspot.com'
})
db = firestore.client()
bucket = storage.bucket()

def upload_image(image_url):
    response = requests.get(image_url)
    image_data = response.content

    # Generate unique image file name
    file_name = f"property_images/{uuid.uuid4()}.jpg"
    blob = bucket.blob(file_name)
    blob.upload_from_string(image_data, content_type="image/jpeg")
    
    # Make URL accessible
    blob.make_public()
    return blob.public_url

def iso_to_utc_timestamp(iso_string):
    dt = datetime.fromisoformat(iso_string.replace("Z", "+00:00"))
    return int(dt.timestamp())

def upload_properties(file_path):
    with open(file_path, "r") as f:
        properties = json.load(f)

    for property_data in properties:
        
        property_id = str(uuid.uuid4())
        
        uploaded_images = []
        property_data["images"] = uploaded_images

        property_data["createdAt"] = iso_to_utc_timestamp(property_data["createdAt"])
        property_data["updatedAt"] = iso_to_utc_timestamp(property_data["updatedAt"])
        
        if "verifiedAt" in property_data and property_data["verifiedAt"]:
            property_data["verifiedAt"] = iso_to_utc_timestamp(property_data["verifiedAt"])

        db.collection("properties").document(property_id).set(property_data)
        print(f"Uploaded property: {property_data['name']} with ID: {property_id}")

upload_properties("properties.json")
