#!/bin/bash

if [[ ${PHP_XDEBUG} -eq "1" ]]; then
   xdebug on
else
  xdebug off
fi

sudo /usr/sbin/postfix start
sudo /usr/local/sbin/php-fpm -F -c /usr/local/etc/php/php.ini
