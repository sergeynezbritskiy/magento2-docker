#!/bin/bash

echo "Releasing version \`latest\` without pushing it to docker hub"

docker build --build-arg PHP_VERSION=8.3 ./src --tag=sergeynezbritskiy/magento2-php83:"latest"
