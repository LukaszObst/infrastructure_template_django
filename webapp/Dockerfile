FROM python:3.10.5-slim-buster as build

ARG CONTAINER_WEBAPP_WORKDIR

# set work directory
WORKDIR ${CONTAINER_WEBAPP_WORKDIR} 

# set environment variables
# sent output directly to container log w/o being buffered first
ENV PYTHONUNBUFFERED 1

# create venv
RUN python -m venv ./venv
ENV PATH="${CONTAINER_WEBAPP_WORKDIR}/venv/bin:$PATH"

# upgrade pip
RUN pip install --upgrade pip

# copy & install requirements
COPY ./requirements.txt requirements.txt
RUN pip install -r requirements.txt

#######################################
############# MAIN STAGE  #############
#######################################

FROM python:3.10.5-slim-buster

ARG CONTAINER_WEBAPP_WORKDIR
ARG WEBAPP_PORT

# run as non-root
RUN groupadd --gid 1002 webapp && useradd -u 1002 -g webapp -s /bin/bash webapp

# install nc
RUN apt-get update && apt-get install -y netcat

# set work directory
RUN mkdir -p ${CONTAINER_WEBAPP_WORKDIR}
RUN mkdir -p ${CONTAINER_WEBAPP_WORKDIR}/staticfiles
RUN chown webapp:webapp ${CONTAINER_WEBAPP_WORKDIR}
RUN chown webapp:webapp ${CONTAINER_WEBAPP_WORKDIR}/staticfiles
WORKDIR ${CONTAINER_WEBAPP_WORKDIR}

# copy venv from build-stage
COPY --chown=webapp:webapp --from=build ${CONTAINER_WEBAPP_WORKDIR}/venv ./venv

# copy code
COPY --chown=webapp:webapp ./entrypoint.sh ${CONTAINER_WEBAPP_WORKDIR}
COPY --chown=webapp:webapp ./migrate.sh ${CONTAINER_WEBAPP_WORKDIR}
COPY --chown=webapp:webapp ./collectstatic.sh ${CONTAINER_WEBAPP_WORKDIR}
COPY --chown=webapp:webapp ./${DJANGO_PROJECT_SUBDIR} ${CONTAINER_WEBAPP_WORKDIR}/${DJANGO_PROJECT_SUBDIR}
COPY --chown=webapp:webapp ./manage.py ${CONTAINER_WEBAPP_WORKDIR}

USER webapp

ENV PATH="${CONTAINER_WEBAPP_WORKDIR}/venv/bin:$PATH"
ENV PYTHONPATH="${CONTAINER_WEBAPP_WORKDIR}/webapp:$PYTHONPATH"

EXPOSE ${WEBAPP_PORT}
ENTRYPOINT [ "bash", "-c", "${CONTAINER_WEBAPP_WORKDIR}/entrypoint.sh" ] 