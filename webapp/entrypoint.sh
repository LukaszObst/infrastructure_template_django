#!/bin/bash

echo "Initializing postgres db..."

while ! nc -z ${DJANGO_DB_HOST} ${DJANGO_DB_PORT}; do
  sleep 1
done

echo "postgres database has initialized successfully"

python manage.py makemigrations
python manage.py migrate --noinput
python manage.py collectstatic --noinput

if [ ${DJANGO_SUPERUSER_USERNAME} ]
then
  echo "Creating superuser"
  python manage.py createsuperuser --noinput 
fi

gunicorn ${DJANGO_PROJECT_SUBDIR}.wsgi:application --bind 0.0.0.0:${WEBAPP_PORT}
#exec "$@"