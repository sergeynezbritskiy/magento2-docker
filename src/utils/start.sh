#!/bin/bash

#######################
# enable/disable xdebug
#######################

if [[ ${PHP_XDEBUG} -eq "1" ]]; then
  xdebug on
else
  xdebug off
fi

##################
# configure xdebug
##################
# TODO implement handling of PHP_XDEBUG_CONNECT_BACK_HOST that defaults to "172.18.0.1"
sudo sed -i "s/env\[PHP_IDE_CONFIG\]=.*/env[PHP_IDE_CONFIG]=\"${PHP_IDE_CONFIG}\"/g" /usr/local/etc/php-fpm.d/www.conf

############################
# configure file permissions
############################
# TODO implement handling of
#      - UID=${DOCKER_UID}
#      - GID=${DOCKER_GID}

###################
# configure postfix
###################
if [[ -n ${SMTP_HOST} || -n ${SMTP_PORT} ]]; then
  sudo postconf -e "relayhost = [${SMTP_HOST}]:${SMTP_PORT}"
fi
if [[ -n ${SMTP_MYHOSTNAME} ]]; then
  sudo postconf -e "myhostname = ${SMTP_MYHOSTNAME}"
fi
if [[ -n ${SMTP_MYDESTINATION} ]]; then
  sudo postconf -e "mydestination = ${SMTP_MYDESTINATION}"
fi
sudo postconf -e "inet_interfaces = all"
sudo postconf -e "compatibility_level = 2"

###########################
# start postfix and php-fpm
###########################
sudo /usr/sbin/postfix start
sudo /usr/local/sbin/php-fpm -F -c /usr/local/etc/php/php.ini
