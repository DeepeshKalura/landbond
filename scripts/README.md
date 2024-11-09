## Landbond Scripts 

This repository contains scripts for the landbond project. In this repo you will fill and run scripts that will help you to automate the data to `firebase`.

### Installation 

1. Create a virtual environment 

```bash
python3 -m venv .venv
```

2. Activate the virtual environment 

```bash
source .venv/bin/activate
```

3. Install the requirements

```bash

pip install -r requirements.txt
```

## Prerequisites

You will need to create the json file. 

1. Create a `serviceAccountKey.json` file in the root of the project: It should be created from the firebase console.

## Usage & Warning

This is a script that automate the process of uploading data to firebase but most of them not working as expected. I manually change it to work with the current dummy data. So make sure to check the data and it should be work with the current data.

**Note:** 
```bash
python --version
Python 3.10.12
```