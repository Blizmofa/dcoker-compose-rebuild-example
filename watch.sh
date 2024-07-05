#!/bin/bash

# Define the path to the directory to watch
path="/path/to/app"

echo "Watching for changes in $path..."

# Event loop
while true; do
    # Use inotifywait to watch for modifications to Python files
    inotifywait -e modify,create,delete,move "$path"/*.py
    
    # Print a message indicating a change was detected
    echo "Change detected. Rebuilding Docker container..."
    
    # Run the Docker Compose command to rebuild and start the container
    docker-compose up --build
done
