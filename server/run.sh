#!/bin/bash

# Exit immediately if a command exits with a non-zero status.
set -e
# Set up env feature flags 
set -a
source features.dev.env
set +a
# Start set nginx for local dev
sudo nginx -s quit 
sudo nginx -c $(pwd)/nginx.config
# Get creds for cloud 
gcloud auth application-default login --impersonate-service-account 433084662574-compute@developer.gserviceaccount.com;
# Run the server
go run .