#!/bin/bash

python manage.py makemigrations
python manage.py migrate --noinput

exit 0