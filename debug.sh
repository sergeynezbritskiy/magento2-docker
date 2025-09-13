#!/bin/bash

set -e # exit when any command fails

docker build --build-arg PHP_VERSION=8.3 -t sergeynezbritskiy/php-magento2:test ./src --debug

docker rm -f php-magento2-test
docker run -dti -v "${PWD}":/var/www/html --name php-magento2-test sergeynezbritskiy/php-magento2:test
docker exec -it php-magento2-test bash -c "bash tests/run.sh"