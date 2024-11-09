import os
import uuid
import json
from datetime import datetime
import firebase_admin
from firebase_admin import credentials, storage, firestore

cred = credentials.Certificate("serviceAccountKey.json") 
firebase_admin.initialize_app(cred, options={'storageBucket': 'realestate-a695d.appspot.com'})

db = firestore.client()
bucket = storage.bucket()

data = [
    {
        "name": "Indore",
        "state": "Madhya Pradesh",
        "imageUrl": "city/indore.png",
        "coordinates": {
            "latitude": 22.7196,
            "longitude": 75.8577
        },
        "isActive": True
    }
]

def upload_image_to_firebase(image_path, city_name):
    blob = bucket.blob(f"city/{city_name}_{uuid.uuid4()}.png")
    blob.upload_from_filename(image_path)
    blob.make_public()
    return blob.public_url

class Coordinates:
    def __init__(self, latitude, longitude):
        self.latitude = latitude
        self.longitude = longitude

    def to_dict(self):
        return {
            "latitude": self.latitude,
            "longitude": self.longitude
        }

class Cities:
    def __init__(self, name, state, imageUrl, coordinates, isActive=True):
        self.id = str(uuid.uuid4())
        self.name = name
        self.state = state
        self.imageUrl = imageUrl  
        self.coordinates = Coordinates(**coordinates)
        self.isActive = isActive
        self.createdAt = datetime.utcnow().isoformat() + 'Z'
        self.updatedAt = datetime.utcnow().isoformat() + 'Z'

    def to_dict(self):
        return {
            "id": self.id,
            "name": self.name,
            "imageUrl": self.imageUrl,
            "coordinates": self.coordinates.to_dict(),
            "state": self.state,
            "isActive": self.isActive,
            "createdAt": self.createdAt,
            "updatedAt": self.updatedAt
        }

for city in data:
    image_path = city["imageUrl"]
    image_url = upload_image_to_firebase(image_path, city["name"])
    
    city_obj = Cities(
        name=city["name"],
        state=city["state"],
        imageUrl=image_url, 
        coordinates=city["coordinates"],
        isActive=city.get("isActive", True)
    )
    
    db.collection("cities").document(city_obj.id).set(city_obj.to_dict())
    print(f"Uploaded and stored city data for {city['name']}.")

print("All city data has been processed and uploaded.")
