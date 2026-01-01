# Deploying the podcast job to cloud run jobs 
# 
# This was particularly painful, since the job is in a subdirectory 
# of the repository
# 
# So I need to write out a temporary project.toml file for the build process 
# to register to tell it to build the jobs directory
# cat << EOF > project.toml; 
# [[build.env]]
# name = "GOOGLE_BUILDABLE"
# value = "./jobs/podcasts/main.go"
# EOF

# Exit immediately if a command exits with a non-zero status.
set -e

gcloud builds submit --pack \
  env=GOOGLE_BUILDABLE="./jobs/podcasts/main.go" \
  image="northamerica-northeast1-docker.pkg.dev/level-prism-477102-p5/cloud-run-source-deploy/rxyz-podcasts"

gcloud run jobs deploy rxyz-podcasts \
    --region="northamerica-northeast1" \
    --image="northamerica-northeast1-docker.pkg.dev/level-prism-477102-p5/cloud-run-source-deploy/rxyz-podcasts"