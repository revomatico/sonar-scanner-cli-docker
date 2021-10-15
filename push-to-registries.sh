#!/bin/bash

DOCKER_IMAGE=revomatico/sonar-scanner
SONAR_SCANNER_VERSION=${SONAR_SCANNER_VERSION:-`git tag | sort -n | tail -n1`}

docker build --build-arg SONAR_SCANNER_VERSION=$SONAR_SCANNER_VERSION --tag $DOCKER_IMAGE 4

docker login -u ${DOCKER_HUB_USERNAME:-`read -p 'Docker Hub Username: ' U; echo "$U"`} --password-stdin < ~/.ssh/docker-hub-pat
docker tag $DOCKER_IMAGE $DOCKER_IMAGE:$SONAR_SCANNER_VERSION
docker push revomatico/${DOCKER_IMAGE##*/}
