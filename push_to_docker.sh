#!/bin/bash
# Build as the same docker user the compose files use
source /hp/docker/.env
docker build --no-cache --build-arg DOCKER_UID="$DOCKER_UID" --build-arg DOCKER_GID="$DOCKER_GID" \
    -t localhost:5000/hlds-cs1.6 /hp/hlds
docker push localhost:5000/hlds-cs1.6
