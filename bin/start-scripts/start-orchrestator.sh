#!/bin/bash
cd orchestrator-and-auth &&
pipenv shell python manage.py runserver localhost:8000
