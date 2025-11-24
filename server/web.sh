#!/bin/bash

# Exit immediately if a command exits with a non-zero status.
set -e

echo "Starting Flutter web build process..."
echo "-------------------------------------"

cd ../app
flutter build web --release
cd ../server

echo "-------------------------------------"
echo "Build complete."

rm -rf ./web 
cp -r ../app/build/web .

echo "-------------------------------------"
echo "Moved code locally"