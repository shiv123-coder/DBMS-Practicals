# Car Management System (Flask + SQLite)

## Overview
Simple CRUD web app to manage Customers, Cars and Services.
Built with Flask and SQLite for easy setup.

## Run locally
1. (Optional) create a virtualenv:
   python -m venv venv
   source venv/bin/activate  # Linux/macOS
   venv\Scripts\activate   # Windows

2. Install requirements:
   pip install -r requirements.txt

3. Initialize database and run:
   python app.py

4. Open http://127.0.0.1:5000 in your browser.

## Project structure
- app.py                # main Flask app
- models.py             # SQLAlchemy models
- templates/            # HTML templates (Jinja2)
- static/               # static files (optional)
- requirements.txt
