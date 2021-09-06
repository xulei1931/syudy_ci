#!/bin/bash

set -eo pipefail

IMAGE_PREFIX='x1x1'
STABLE_TAG='0.3'

DOCKERHUB_USERNAME='1142051133' 
DOCKERHUB_PASSWORD='xulei123456'

TAG="${STABLE_TAG}.${CIRCLE_BUILD_NUM}"
ROOT_DIR="$(pwd)"
SVC_DIR="${ROOT_DIR}"

cd $SVC_DIR
docker login -u $DOCKERHUB_USERNAME --password-stdin $DOCKERHUB_PASSWORD
# docker login -u 1142051133 -p xulei123456

UNTAGGED_IMAGE=$(echo "${IMAGE_PREFIX}/delinkcious-1" | sed -e 's/_/-/g' -e 's/-service//g')
STABLE_IMAGE="${UNTAGGED_IMAGE}:${STABLE_TAG}"
IMAGE="${UNTAGGED_IMAGE}:${TAG}"
echo "image: $IMAGE"
echo "stable image: ${STABLE_IMAGE}"
docker build -t "$IMAGE" .
docker tag "${IMAGE}" "${STABLE_IMAGE}"
docker push "${IMAGE}"
docker push "${STABLE_IMAGE}"