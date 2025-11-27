#!/bin/bash

# Exit immediately if a command exits with a non-zero status.
set -e

# Build the web directory 
flutter build web --$1

# upload to storage 
# gcloud storage rsync ../app/build/web gs://rxyz-app-static/v0 --recursive
# I ended up doing this in the UI actually.
# gcloud storage buckets add-iam-policy-binding  gs://rxyz-app-static --member=allUsers --role=roles/storage.objectViewer
# This needs to be changed.. 
# gcloud storage buckets update gs://rxyz-app-static --cors-file=cors.cfg

# Use firebase hosting (not app hosting)
firebase deploy --only hosting