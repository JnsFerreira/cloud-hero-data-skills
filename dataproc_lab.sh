#!/bin/sh
# Disable dataproc API
gcloud services disable dataproc.googleapis.com

# Enable dataproc API
gcloud services enable dataproc.googleapis.com

# Evironment Variables
export CLUSTER_NAME=example-cluster
export PROJECT_ID=$(gcloud config list project --format "value(core.project)")

# Create Cluster
gcloud dataproc clusters create $CLUSTER_NAME \
	 --region us-central1 \
	 --zone us-central1-a \
	 --master-machine-type n1-standard-4 \
	 --master-boot-disk-size 500 \
	 --num-workers 2 \
	 --worker-machine-type n1-standard-4 \
	 --worker-boot-disk-size 500 \
	 --image-version 2.0-debian10 \
	 --project $PROJECT_ID

# Running spark job
gcloud dataproc jobs submit spark \
	--cluster $CLUSTER_NAME \
	--class org.apache.spark.examples.SparkPi \
	--region us-central1 \
	--jars file:///usr/lib/spark/examples/jars/spark-examples.jar \
	-- 1000

# Update Cluster workers
gcloud dataproc clusters update $CLUSTER_NAME --region=us-central1 --num-workers=4
