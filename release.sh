#!/bin/bash

VERSION=$1

if [ -z "${VERSION}" ]; then
  # shellcheck disable=SC2162
  read -p "Specify release version: " VERSION
fi

echo "Releasing version \`${VERSION}\`"

docker build --build-arg PHP_VERSION=8.3 ./src --tag=sergeynezbritskiy/magento2-php83:"${VERSION}"
docker push sergeynezbritskiy/magento2-php83:"${VERSION}"

docker build --build-arg PHP_VERSION=8.3 ./src --tag=sergeynezbritskiy/magento2-php83:"latest"
docker push sergeynezbritskiy/magento2-php83:"latest"
