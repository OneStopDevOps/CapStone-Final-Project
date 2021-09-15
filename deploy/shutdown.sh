#!/bin/sh

# Use for stopping the docker container and removing the docker image
docker container stop $(docker ps -a -q)

docker rm $(docker ps --filter status=exited -q)

docker rmi $(docker images -a -q)