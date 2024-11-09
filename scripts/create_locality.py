import json
from firebase_admin import credentials, firestore, initialize_app
from datetime import datetime
import uuid

cred = credentials.Certificate("serviceAccountKey.json")
initialize_app(cred)
db = firestore.client()

def upload_localities(file_path):
    with open(file_path, "r") as f:
        localities = json.load(f)

    for locality in localities:
        locality_id = str(uuid.uuid4())

        locality["createdAt"] = datetime.fromisoformat(locality["createdAt"].replace("Z", "+00:00"))
        locality["updatedAt"] = datetime.fromisoformat(locality["updatedAt"].replace("Z", "+00:00"))

        db.collection("localities").document(locality_id).set(locality)
        print(f"Uploaded locality: {locality['name']} with ID: {locality_id}")

upload_localities("localities.json")
