#!/bin/bash

VERSION=$1

if [ -z "${VERSION}" ]; then
  # shellcheck disable=SC2162
  read -p "Specify release version: " VERSION
fi

echo "Releasing version \`${VERSION}\`"

docker build . --tag=sergeynezbritskiy/php-magento2:"${VERSION}"
docker push sergeynezbritskiy/php-magento2:"${VERSION}"