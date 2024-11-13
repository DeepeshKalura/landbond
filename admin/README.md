# Property & Producer Management System

A FastAPI-based web application for managing real estate properties and producers with Firebase integration.

## 🛠️ Technology Stack

- **Backend**: FastAPI (Python)
- **Database**: Firebase Firestore
- **Frontend**: Jinja2 Templates, TailwindCSS
- **Authentication**: Firebase Auth
- **Deployment**: Any WSGI server (Uvicorn recommended)

## 📋 Prerequisites

- Python 3.8 or higher
- Firebase project with Firestore database
- NodeJS (for TailwindCSS compilation, optional)
- Git (for version control)

## ⚙️ Installation



1. Create and activate a virtual environment
```bash
python -m venv .venv
source venv/bin/activate  # On Windows, use: venv\Scripts\activate
```

3. Install required dependencies
```bash
pip install -r requirements.txt
```

4. Set up Firebase credentials
   - Create a new Firebase project in the Firebase Console
   - Generate a new service account key (JSON file)
   - Save it as `serviceAccountKey.json` in the project root

5. Create required directories
```bash
mkdir templates
```

## 📁 Project Structure

```
property-producer-management/
├── src
|    ├── app.py           
├── requirements.txt         
├── serviceAccountKey.json   
├── templates/              
│   ├── home.html
│   ├── properties.html
│   └── producers.html
└── README.md
```

## 🚀 Running the Application

1. Start the FastAPI server
```bash
uvicorn src/app:app --reload
```

2. Access the application
- Open your browser and navigate to `http://localhost:8000`
- The home page will show options for managing properties and producers

## 📝 API Endpoints

### Properties
- `GET /properties` - List all properties
- `POST /properties/create` - Create new property
- `POST /properties/update/{property_id}` - Update property
- `GET /api/properties/{property_id}` - Get property details

### Producers
- `GET /producers` - List all producers
- `POST /producers/create` - Create new producer
- `POST /producers/update/{producer_id}` - Update producer
- `GET /api/producers/{producer_id}` - Get producer details



## 🤝 Acknowledgments

* FastAPI team for the excellent framework
* Firebase team for the robust backend services
* TailwindCSS team for the utility-first CSS framework