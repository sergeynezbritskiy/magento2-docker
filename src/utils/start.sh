#!/bin/bash

if [[ ${PHP_XDEBUG} -eq "1" ]]; then
   xdebug on
else
  xdebug off
fi

# TODO implement handling of PHP_XDEBUG_CONNECT_BACK_HOST that defaults to "172.18.0.1"

sudo sed -i "s/env\[PHP_IDE_CONFIG\]=.*/env[PHP_IDE_CONFIG]=\"${PHP_IDE_CONFIG}\"/g" /usr/local/etc/php-fpm.d/www.conf

# TODO implement handling of
#      - SMTP_HOST=${PROJECT_NAME}-mailpit
#      - SMTP_PORT=1025
#      - SMTP_MYHOSTNAME=${DOMAIN}
#      - SMTP_MYDESTINATION=localhost
#      - UID=${DOCKER_UID}
#      - GID=${DOCKER_GID}

sudo /usr/sbin/postfix start
sudo /usr/local/sbin/php-fpm -F -c /usr/local/etc/php/php.ini
