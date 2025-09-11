#!/bin/bash

sudo /usr/sbin/postfix start
sudo /usr/local/sbin/php-fpm -F -c /usr/local/etc/php/php.ini
