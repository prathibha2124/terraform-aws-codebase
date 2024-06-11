#!/bin/bash

# Variables
ECR_REGISTRY=$1
ECR_REPOSITORY=$2
IMAGE_TAG=$3

# Authenticate Docker to ECR
$(aws ecr get-login --no-include-email --region us-east-1)

# Build the Docker image
docker build -t ${ECR_REPOSITORY}:${IMAGE_TAG} .

# Tag the image for ECR
docker tag ${ECR_REPOSITORY}:${IMAGE_TAG} ${ECR_REGISTRY}/${ECR_REPOSITORY}:${IMAGE_TAG}

# Push the image to ECR
docker push ${ECR_REGISTRY}/${ECR_REPOSITORY}:${IMAGE_TAG}
