#!/bin/bash

# Exit immediately if a command exits with a non-zero status.
set -e
# Set up env feature flags 
set -a
source features.dev.env
# source twilio.test.env
set +a
# Start set nginx for local dev
sudo nginx -s quit 
sudo nginx -c $(pwd)/nginx.config
# Gave up trying to impersonate, given timeouts.
export GOOGLE_APPLICATION_CREDENTIALS=$(pwd)/creds.json
# Get creds for cloud 
# gcloud auth application-default login --impersonate-service-account 433084662574-compute@developer.gserviceaccount.com;
# export GOOGLE_OAUTH_ACCESS_TOKEN=$(gcloud auth print-access-token --impersonate-service-account=433084662574-compute@developer.gserviceaccount.com)
# Run the server
go run .