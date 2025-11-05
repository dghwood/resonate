gcloud run deploy rxyz \
--source . \
--region northamerica-northeast1 \
--env-vars-file=server.env \
--min-instances=0 \
--max-instances=1 \
--allow-unauthenticated