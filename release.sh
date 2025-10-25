#!/bin/bash

PHP=$1
if [ -z "${PHP}" ]; then
  # shellcheck disable=SC2162
  read -p "Specify PHP version (in dot separated format, e.g. 8.1, 8.2, 8.3): " PHP
fi

TAG=$2
if [ -z "${TAG}" ]; then
  # shellcheck disable=SC2162
  read -p "Specify release tag: " TAG
fi

echo "Releasing tag \`${TAG}\` for PHP ${PHP}"

IMAGE_NAME=$(echo "${PHP}" | tr -cd '[:digit:]')
IMAGE_NAME="sergeynezbritskiy/magento2-php${IMAGE_NAME}"

docker build --build-arg PHP_VERSION="${PHP}" ./src --tag=${IMAGE_NAME}:"${TAG}"
docker push ${IMAGE_NAME}:"${TAG}"

docker build --build-arg PHP_VERSION=${PHP} ./src --tag=${IMAGE_NAME}:"latest"
docker push ${IMAGE_NAME}:"latest"
