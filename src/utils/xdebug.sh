#!/bin/bash

RED='\033[0;31m'
NC='\033[0m' # No Color
GREEN='\033[0;32m'

answer=$1

if php -m | grep -q xdebug
then
    is_enabled=1
else
    is_enabled=0
fi


if [[ "$answer" = "on" ]]
then

    if [[ "$is_enabled" -eq 1 ]]
    then
        echo -e "${GREEN}Nothing to do, Xdebug is already enabled${NC}"
    else
        sudo cp /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini.tmpl /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini
        sudo /usr/bin/restart
        echo -e "${GREEN}Xdebug enabled${NC}"
    fi

elif [[ "$answer" = "off"  ]]
then

    if [[ "$is_enabled" -eq 1 ]]
    then
        sudo rm -f /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini
        sudo /usr/bin/restart
        echo -e "${RED}Xdebug disabled${NC}"
    else
        echo -e "${RED}Nothing to do, Xdebug is already disabled${NC}"
    fi

else

    if [[ "$is_enabled" -eq 1 ]]
    then
        echo -e "${GREEN}Xdebug is enabled${NC}"
    else
        echo -e "${RED}Xdebug is disabled${NC}"
    fi
    echo -e "${GREEN}Use command \"xdebug on\" to enable or \"xdebug off\" to disable Xdebug${NC}"

fi

