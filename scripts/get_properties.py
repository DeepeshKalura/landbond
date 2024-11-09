import json
import uuid
from firebase_admin import credentials, firestore, initialize_app

cred = credentials.Certificate("serviceAccountKey.json")
initialize_app(cred, {
    'storageBucket': 'realestate-a695d.appspot.com'
})
db = firestore.client()

file_path = "properties.json"
with open(file_path, "r") as f:
    properties_list = json.load(f)

for property_data in properties_list:
    property_id = uuid.uuid4()
    property_data["id"] = str(property_id) 
    
    db.collection("properties").document(str(property_id)).set(property_data)
    print(f"Uploaded property: {property_data['name']} with ID: {property_id}")
