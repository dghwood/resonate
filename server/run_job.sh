#!/bin/bash

# Exit immediately if a command exits with a non-zero status.
set -e
# Set up env feature flags 
set -a
source features.dev.env
# source twilio.test.env
set +a

# Gave up trying to impersonate, given timeouts.
export GOOGLE_APPLICATION_CREDENTIALS=$(pwd)/creds.json

go run jobs/podcasts/main.go