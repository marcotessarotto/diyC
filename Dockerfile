FROM ubuntu:18.04

USER root

RUN apt-get update \
  && apt-get install -y  python3.8-dev python3.8-venv python3-venv \
    python3.8 python3-pip  \
     build-essential git nano wget unzip libc6-dev \
    binutils \
    ca-certificates \
    openssl \
    make \
    sudo

RUN pip3 install --upgrade pip

RUN pip3 install --upgrade setuptools

RUN pip3 install oauthlib~=3.1.0 msal~=1.4.3 backports.zoneinfo \
dateutils \
firebase-admin \
djangorestframework~=3.11.1 \
django~=3.1 \
python-dateutil~=2.8.1 \
requests~=2.24.0 \
psycopg2-binary \
openpyxl \
djangorestframework_simplejwt \
coreapi \
pyyaml \
uritemplate \
pyjwt \
gunicorn \
setproctitle \
treetaggerwrapper \
nltk \
cherrypy \
SolrClient


RUN adduser utente --gecos "First Last,RoomNumber,WorkPhone,HomePhone" --disabled-password
RUN echo "utente:units" | chpasswd

RUN echo "utente ALL=(ALL:ALL) ALL" | tee -a /etc/sudoers >/dev/null

USER utente



