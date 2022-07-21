#!/bin/bash

echo "Initializing db..."

while ! nc -z ${DJANGO_DB_HOST} ${DJANGO_DB_PORT}; do
  sleep 1
  echo "Waiting for db..."
done

echo "database has initialized successfully"

gunicorn ${DJANGO_PROJECT_SUBDIR}.wsgi:application --bind 0.0.0.0:${WEBAPP_PORT}