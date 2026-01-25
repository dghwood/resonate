#!/bin/bash

# Exit immediately if a command exits with a non-zero status.
set -e

# Get the head git commit and send to build
GIT_COMMIT=$(git rev-parse HEAD)

gcloud run deploy rxyz-app \
--source . \
--region northamerica-northeast1 \
--min-instances=0 \
--max-instances=1 \
--no-invoker-iam-check \
--env-vars-file features.prod.env \
--project=resonates-xyz