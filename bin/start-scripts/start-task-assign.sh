#!/bin/bash
cd task-assignment-service &&
ls &&
pipenv run python manage.py runserver localhost:8001
