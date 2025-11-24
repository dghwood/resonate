#!/bin/bash

# Exit immediately if a command exits with a non-zero status.
set -e

echo "Starting Flutter web build process..."
echo "-------------------------------------"

cd ../app
# --ouput=/path/server/web
# --debug 
# --profile 
# --release
# --dart-define-from-file=config.env
flutter build web --$1
cd ../server

echo "-------------------------------------"
echo "Build complete."

rm -rf ./web 
cp -r ../app/build/web .

echo "-------------------------------------"
echo "Moved code locally"