#!/bin/bash

# Exit immediately if a command exits with a non-zero status.
set -e

sh web.sh release; 

cat << EOF > project.toml; 
#[[build.env]]
#name = "GOOGLE_BUILDABLE"
#value = "./jobs/podcasts/main.go"
EOF

gcloud run deploy rxyz-app \
--source . \
--region northamerica-northeast1 \
--min-instances=0 \
--max-instances=1 \
--no-invoker-iam-check

echo "-------------------------------------"
echo "deployed"