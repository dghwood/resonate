# Deploying the podcast job to cloud run jobs

# Exit immediately if a command exits with a non-zero status.
set -e

gcloud builds submit \
  --pack=env=GOOGLE_BUILDABLE="./jobs/podcasts/main.go",image="northamerica-northeast1-docker.pkg.dev/resonates-xyz/cloud-run-source-deploy/rxyz-podcasts" \
  --project=resonates-xyz

gcloud run jobs deploy rxyz-podcasts \
    --region="northamerica-northeast1" \
    --image="northamerica-northeast1-docker.pkg.dev/resonates-xyz/cloud-run-source-deploy/rxyz-podcasts" \
    --env-vars-file features.prod.env \
    --project=resonates-xyz