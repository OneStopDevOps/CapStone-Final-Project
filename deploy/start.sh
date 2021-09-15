# Deployment script for production 
DOCKER_IMAGE=onestopdevops/capstone-final-project:${BUILD_TAG}

echo "Pulling inventory-service from Docker Hub repo"
sudo docker pull $DOCKER_IMAGE

echo "Stop existing container if exists"
sudo docker ps -q --filter ancestor=$DOCKER_IMAGE | xargs -r docker stop

echo "Execute the image container"
sudo docker run -d -p 8081:8081 $DOCKER_IMAGE