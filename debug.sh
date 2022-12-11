#!/bin/bash

set -e # exit when any command fails

docker build -t sergeynezbritskiy/php-magento2:test ./src
docker rm -f php-magento2-test
docker run -dti -e XDEBUG_ENABLED=1 -v "${PWD}":/var/www/html --name php-magento2-test sergeynezbritskiy/php-magento2:test
docker exec -it php-magento2-test bash -c "bash tests/run.sh"
docker exec -it php-magento2-test bash