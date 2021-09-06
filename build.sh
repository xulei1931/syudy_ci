#!/bin/bash

set -eo pipefail

IMAGE_PREFIX='1142051133'
STABLE_TAG='0.3'

DOCKERHUB_USERNAME='1142051133' 

TAG="${STABLE_TAG}.${CIRCLE_BUILD_NUM}"
ROOT_DIR="$(pwd)"

#docker login -u $DOCKERHUB_USERNAME --password-stdin $DOCKERHUB_PASSWORD
docker login -u $DOCKERHUB_USERNAME  --password-stdin < ./my_password

UNTAGGED_IMAGE=$(echo "${IMAGE_PREFIX}/cricile" | sed -e 's/_/-/g' -e 's/-service//g')
STABLE_IMAGE="${UNTAGGED_IMAGE}:${STABLE_TAG}"
IMAGE="${UNTAGGED_IMAGE}:${TAG}"
echo "image: $IMAGE"
echo "stable image: ${STABLE_IMAGE}"
docker build -t "$IMAGE" .
docker tag "${IMAGE}" "${STABLE_IMAGE}"
docker push "${IMAGE}"
