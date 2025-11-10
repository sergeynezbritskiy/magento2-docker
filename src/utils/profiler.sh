#!/bin/bash

RED='\033[0;31m'
NC='\033[0m' # No Color
GREEN='\033[0;32m'

answer=$1

XDEBUG_CONF_FILE='/usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini'
if [ ! -f "${XDEBUG_CONF_FILE}" ]; then
  if [[ "$answer" = "" ]]; then
    echo -e "${RED}Xdebug extension not enabled${NC}"
    exit;
  else
    echo -e "${RED}Xdebug not enabled, enabling xdebug first${NC}"
    xdebug on > /dev/null
  fi
fi

if grep -q '^xdebug\.mode=.*profile' "${XDEBUG_CONF_FILE}"; then
    is_enabled=1
else
    is_enabled=0
fi

if [[ "$answer" = "on" ]]; then

    if [[ "$is_enabled" -eq 1 ]]; then
        echo -e "${GREEN}Nothing to do, profiler is already enabled${NC}"
    else

        mkdir -p /var/www/html/var/profiler

        sudo sed -i \
            -e 's/^xdebug.mode=.*/xdebug.mode=profile/' \
            -e 's/^xdebug.start_with_request=.*/xdebug.start_with_request=trigger/' \
            -e '/^xdebug.output_dir=.*/d' \
            "${XDEBUG_CONF_FILE}"

        echo 'xdebug.output_dir=/var/www/html/var/profiler' | sudo tee -a "${XDEBUG_CONF_FILE}"
        echo -e "${GREEN}Xdebug Profiler enabled${NC}"
        sudo /usr/bin/restart
    fi

elif [[ "$answer" = "off"  ]]; then

    if [[ "$is_enabled" -eq 1 ]]; then
        xdebug off > /dev/null
        xdebug on > /dev/null
        echo -e "${RED}Profiler disabled${NC}"
    else
        echo -e "${RED}Nothing to do, Xdebug Profiler is already disabled${NC}"
    fi

else

    if [[ "$is_enabled" -eq 1 ]]; then
        echo -e "${GREEN}Xdebug Profiler is enabled${NC}"
    else
        echo -e "${RED}Xdebug Profiler is disabled${NC}"
    fi
    echo -e "${GREEN}Use command \"profiler on\" to enable or \"profiler off\" to disable Xdebug Profiler${NC}"

fi
