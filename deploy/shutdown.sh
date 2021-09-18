#!/bin/sh

# Use for stopping the docker container and removing the docker image
sudo docker container stop $(sudo docker ps -a -q)

sudo docker rm $(sudo docker ps --filter status=exited -q)

sudo docker rmi $(sudo docker images -a -q)