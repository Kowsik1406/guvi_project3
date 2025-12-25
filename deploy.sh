#!/bin/bash
compose_file="Docker-compose.yml"

echo "Deploying react app using Docker compose file"

# Stop and remove old containers
docker-compose -f $COMPOSE_FILE down

# Start containers in detached mode
docker-compose -f $compose_file up -d 

# Check if deployment succeeded
if [ $? -eq 0 ]; then
    echo "Deployment successful! Your app should be running on http://localhost"
else
    echo "Deployment failed!"
    exit 1
fi