#!/bin/bash
set -e
source /hp/scripts/functions.sh
# Build as the same docker user the compose files use
source /hp/docker/.env
quiet docker build --no-cache --build-arg DOCKER_UID="$DOCKER_UID" --build-arg DOCKER_GID="$DOCKER_GID" \
    -t localhost:5000/hlds-cs1.6 /hp/hlds
quiet docker push localhost:5000/hlds-cs1.6
echo "OK: hlds built and pushed"
