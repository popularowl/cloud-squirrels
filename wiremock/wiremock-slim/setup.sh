#!/bin/sh

# steps to build and publish Docker image
echo "Starting image build.."

TAG="2.23.2"
echo "Using tag: $TAG"

docker build -t popularowl/wiremock-slim:$TAG . &&

echo "Image is built, uploading to Dockerhub"

docker push popularowl/wiremock-slim:$TAG &&

echo "Completed."
