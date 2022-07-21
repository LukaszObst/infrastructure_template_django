#!/bin/bash

python manage.py collectstatic --noinput

if [ ${DJANGO_SUPERUSER_USERNAME} ]
then
  echo "Creating superuser"
  python manage.py createsuperuser --noinput || true
fi

exit 0