#!/bin/bash

if [ "${XDEBUG_ENABLED}" == '1' ]; then
  sudo cp /docker-xdebug.ini /usr/local/etc/php/conf.d/docker-xdebug.ini
else
  sudo rm -f /usr/local/etc/php/conf.d/docker-xdebug.ini
fi

sudo /usr/sbin/php-fpm
/bin/bash