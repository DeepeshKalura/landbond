

import firebase_admin
from firebase_admin import credentials, firestore, auth
import random
import string
import datetime

cred = credentials.Certificate("serviceAccountKey.json") 
firebase_admin.initialize_app(cred)

db = firestore.client()

users_data = [
    {
       "id": "b3II1OGO9IgxSOcTl3WsZuUF7Np2",
       "name": "John Doe",
        "type": "dealer",
        "phoneNumber": "+1234567890",
        "profilePhotoUrl": "https://images.pexels.com/photos/2955375/pexels-photo-2955375.jpeg",
        "email": "johndoe@test.com",
        "timezone": "UTC-5",
        "isVerified": True,
        "verificationDocuments": ["doc1.pdf", "doc2.pdf"],
        "createdAt": "2022-01-15T08:00:00Z",
        "updatedAt": "2023-01-15T08:00:00Z",
        "verifiedAt": "2022-02-01T08:00:00Z"
    },
    {
        "id": "BHWXQ8GnsugwQ2F5O3z6sbjVwEm2",
        "name": "Jane Smith",
        "type": "agent",
        "phoneNumber": "+1987654321",
        "profilePhotoUrl": "https://images.pexels.com/photos/3760263/pexels-photo-3760263.jpeg",
        "email": "jane.smith@example.com",
        "timezone": "UTC+1",
        "isVerified": False,
        "verificationDocuments": ["doc3.pdf"],
        "createdAt": "2022-03-10T08:00:00Z",
        "updatedAt": "2023-03-10T08:00:00Z",
        "verifiedAt": None
    },
    {
        "id": "bPuaQd0kEETyISbknGjEUIdfT6h1",
        "name": "Carlos Rodriguez",
        "type": "owner",
        "phoneNumber": "+1123456789",
        "profilePhotoUrl": "https://images.pexels.com/photos/3778680/pexels-photo-3778680.jpeg",
        "email": "carlos.rodriguez@example.com",
        "timezone": "UTC-3",
        "isVerified": True,
        "verificationDocuments": ["doc4.pdf", "doc5.pdf", "doc6.pdf"],
        "createdAt": "2022-05-20T08:00:00Z",
        "updatedAt": "2023-05-20T08:00:00Z",
        "verifiedAt": "2022-06-01T08:00:00Z"
    },
    {
        "id": "25jQZ12aoebDorYQfrjY0jm7VcX2",
        "name": "Aisha Khan",
        "type": "dealer",
        "phoneNumber": "+4432109876",
        "profilePhotoUrl": "https://images.pexels.com/photos/3760514/pexels-photo-3760514.jpeg",
        "email": "aisha.khan@example.com",
        "timezone": "UTC+3",
        "isVerified": False,
        "verificationDocuments": ["doc7.pdf"],
        "createdAt": "2022-08-15T08:00:00Z",
        "updatedAt": "2023-08-15T08:00:00Z",
        "verifiedAt": "2022-08-15T08:00:00Z",
    }
]


def generate_auth_credentials(name):
    password = ''.join(random.choices(string.ascii_letters + string.digits, k=10))
    return password

def to_firestore_timestamp(date_str):
    if date_str:
        return datetime.datetime.fromisoformat(date_str.replace("Z", "+00:00"))
    return None










for user in users_data:
    password = generate_auth_credentials(user['name'])
    
    user_data = {
        "id": user["id"],
        "name": user["name"],
        "type": user["type"],
        "phoneNumber": user["phoneNumber"],
        "profilePhotoUrl": user["profilePhotoUrl"],
        "email": user["email"],
        "timezone": user["timezone"],
        "isVerified": user["isVerified"],
        "verificationDocuments": user["verificationDocuments"],
        "createdAt": to_firestore_timestamp(user["createdAt"]),
        "updatedAt": to_firestore_timestamp(user["updatedAt"]),
        "verifiedAt": to_firestore_timestamp(user["verifiedAt"]),
    }
    
    doc_ref = db.collection("producers").document(user["id"])
    doc_ref.set(user_data)

    print(f"Stored user {user['name']} with username: {user['name']} and password: {password}")
