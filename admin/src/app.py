from http.client import HTTPException
from pydantic import BaseModel
from typing import List, Optional
from fastapi import FastAPI, Request, Form, Depends
from fastapi.responses import RedirectResponse
from fastapi.templating import Jinja2Templates
from firebase_admin.auth import verify_id_token
from firebase_admin import auth as firebase_auth
from datetime import datetime
import json
import firebase_admin
from firebase_admin import credentials, auth, firestore

app = FastAPI()
templates = Jinja2Templates(directory="templates")



# Initialize Firebase app
cred = credentials.Certificate("serviceAccountKey.json")
firebase_admin.initialize_app(cred)

# Initialize Firestore
db = firestore.client()


# Firebase utility to authenticate admin users
def authenticate_user(id_token: str):
    try:
        decoded_token = verify_id_token(id_token)
        return decoded_token
    except Exception as e:
        return None




class PropertyModel(BaseModel):
    id: str
    name: str
    propertyType: str
    status: str
    dealType: str
    price: float
    currency: str
    address: str
    size: float
    sizeUnit: str
    year: int
    description: str
    rating: float
    facilities: List[str]
    features: List[str]
    createdAt: datetime
    updatedAt: datetime

@app.get("/")
async def home(request: Request):
    return templates.TemplateResponse("home.html", {"request": request})

# List Properties
@app.get("/properties")
async def list_properties(request: Request):
    properties_ref = db.collection("properties").stream()
    properties = [doc.to_dict() for doc in properties_ref]
    return templates.TemplateResponse("properties.html", {"request": request, "properties": properties})

# Create Property
@app.post("/properties/create")
async def create_property(
    request: Request,
    name: str = Form(...),
    price: float = Form(...),
    currency: str = Form(...),
    address: str = Form(...),
    size: float = Form(...),
    sizeUnit: str = Form(...),
    description: str = Form(...),
):
    new_property = {
        "name": name,
        "price": price,
        "currency": currency,
        "address": address,
        "size": size,
        "sizeUnit": sizeUnit,
        "description": description,
        "createdAt": datetime.now(),
        "updatedAt": datetime.now(),
    }
    db.collection("properties").add(new_property)
    return RedirectResponse(url="/properties", status_code=303)

# Update Property
@app.post("/properties/update/{property_id}")
async def update_property(
    property_id: str,
    request: Request,
    name: str = Form(...),
    price: float = Form(...),
    currency: str = Form(...),
):
    property_ref = db.collection("properties").document(property_id)
    property_ref.update({
        "name": name,
        "price": price,
        "currency": currency,
        "updatedAt": datetime.now(),
    })
    return RedirectResponse(url="/properties", status_code=303)

# Delete Property
@app.post("/properties/delete/{property_id}")
async def delete_property(property_id: str):
    db.collection("properties").document(property_id).delete()
    return RedirectResponse(url="/properties", status_code=303)

class PropertyUpdate(BaseModel):
    name: Optional[str] = None
    propertyType: Optional[str] = None
    status: Optional[str] = None
    dealType: Optional[str] = None
    price: Optional[float] = None
    currency: Optional[str] = None
    verificationStatus: Optional[str] = None
    updatedAt: Optional[datetime] = None

@app.put("/api/properties/{property_id}")
async def update_property(property_id: str, property_data: PropertyUpdate):
    try:
        property_ref = db.collection("properties").document(property_id)
        update_data = {k: v for k, v in property_data.dict().items() if v is not None}
        property_ref.update(update_data)
        return {"message": "Property updated successfully"}
    except Exception as e:
        raise HTTPException(status_code=400, detail=str(e))


class ProducerModel(BaseModel):
    id: Optional[str]
    name: str
    type: str
    phoneNumber: str
    email: str
    profilePhotoUrl: str
    timezone: str
    isVerified: bool = False
    verificationDocuments: List[str]
    createdAt: datetime
    updatedAt: datetime
    verifiedAt: Optional[datetime]

@app.get("/producers")
async def list_producers(request: Request):
    producers_ref = db.collection("producers").stream()
    producers = [doc.to_dict() | {"id": doc.id} for doc in producers_ref]
    return templates.TemplateResponse(
        "producers.html", 
        {"request": request, "producers": producers}
    )

@app.get("/api/properties/{property_id}")
async def get_property(property_id: str):
    try:
        doc = db.collection("properties").document(property_id).get()
        if doc.exists:
            property_data = doc.to_dict()
            property_data["id"] = doc.id
            return property_data
        raise HTTPException(status_code=404, detail="Property not found")
    except Exception as e:
        raise HTTPException(status_code=400, detail=str(e))

@app.get("/api/producers/{producer_id}")
async def get_producer(producer_id: str):
    try:
        doc = db.collection("producers").document(producer_id).get()
        if doc.exists:
            producer_data = doc.to_dict()
            producer_data["id"] = doc.id
            return producer_data
        raise HTTPException(status_code=404, detail="Producer not found")
    except Exception as e:
        raise HTTPException(status_code=400, detail=str(e))

# Update the existing update endpoints to handle JSON data
@app.post("/properties/update/{property_id}")
async def update_property(property_id: str, property_data: dict):
    try:
        property_ref = db.collection("properties").document(property_id)
        property_data["updatedAt"] = datetime.now()
        property_ref.update(property_data)
        return {"message": "Property updated successfully"}
    except Exception as e:
        raise HTTPException(status_code=400, detail=str(e))

@app.post("/producers/update/{producer_id}")
async def update_producer(producer_id: str, producer_data: dict):
    try:
        producer_ref = db.collection("producers").document(producer_id)
        producer_data["updatedAt"] = datetime.now()
        producer_ref.update(producer_data)
        return {"message": "Producer updated successfully"}
    except Exception as e:
        raise HTTPException(status_code=400, detail=str(e))



