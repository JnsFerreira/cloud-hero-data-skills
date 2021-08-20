#!/bin/sh
# criar dataset - check
bq mk taxirides

# Criar tabela - check
bq mk \
--time_partitioning_field timestamp \
--schema ride_id:string,point_idx:integer,latitude:float,longitude:float,\
timestamp:timestamp,meter_reading:float,meter_increment:float,ride_status:string,\
passenger_count:integer -t taxirides.realtime

# criar bucket - bucket
export PROJECT_ID=
export BUCKET_NAME=$PROJECT_ID-bucket
gsutil mb gs://$BUCKET_NAME/

# Runs Dataflow Job
gcloud dataflow jobs run cloud-hero-job --gcs-location gs://dataflow-templates-us-central1/latest/PubSub_to_BigQuery --region us-central1 --staging-location gs://$BUCKET_NAME/tmp/ --parameters inputTopic=projects/pubsub-public-data/topics/taxirides-realtime,outputTableSpec=$PROJECT_ID:taxirides.realtime