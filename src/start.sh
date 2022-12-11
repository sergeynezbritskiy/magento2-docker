#!/bin/bash

if [ "${XDEBUG_ENABLED}" == '1' ]; then
  sudo cp /docker-php-ext-xdebug.ini /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini
else
  sudo rm -f /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini
fi

sudo /usr/local/sbin/php-fpm
/bin/bash
