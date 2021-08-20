export PROJECT_ID=
export BUCKET_NAME=$PROJECT_ID-bucket
gsutil mb gs://$PROJECT_ID-bucket/
echo $BUCKET_NAME