#!/bin/bash

# Exit immediately if a command exits with a non-zero status.
set -e
sh web.sh; 
gcloud auth application-default login --impersonate-service-account localtesting@level-prism-477102-p5.iam.gserviceaccount.com;
go run .