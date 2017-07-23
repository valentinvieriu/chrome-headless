# Chromium Headless - docker image

[ ![Codeship Status for valentinvieriu/chrome-headless](https://app.codeship.com/projects/964a0230-51b7-0135-774f-3acbe865a34f/status?branch=master)](https://app.codeship.com/projects/234504)
[![This image on DockerHub](https://img.shields.io/docker/pulls/valentinvieriu/chrome-headless.svg)](https://hub.docker.com/r/valentinvieriu/chrome-headless/)


Make sure you have a .env file created before. Here is an example of the settings that needs to be passed
```
ROOT_FOLDER=/root/dockers
DEBUG_ADDRESS=0.0.0.0
DEBUG_PORT=9222
CHROME_VERSION=59.0.3071.115-1
TLD=yourdomain.com
ENABLE_TRAEFIK=false
DOCKER_NETWORK_NAME=mainframe_default
```

If you change any of those ENV don't forget to update the encrypted ones for the CI `jet encrypt .env env.encrypted`. This is necesarry only if you are using the Codeship CI.

To build your own version: `docker-compose build`

To start `docker-compose up -d`
