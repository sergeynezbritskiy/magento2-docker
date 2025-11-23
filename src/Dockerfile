ARG PHP_VERSION="8.1"
FROM php:${PHP_VERSION}-fpm
LABEL maintaner="Sergey Nezbritskiy"

ENV DEBIAN_FRONTEND="noninteractive"

RUN PHP_VERSION_ID=$(php -r "echo PHP_VERSION_ID;") && \
    if [ "$PHP_VERSION_ID" -lt 80000 ]; then \
      sed -i 's|deb.debian.org/debian|archive.debian.org/debian|g' /etc/apt/sources.list && \
      sed -i 's|security.debian.org/debian-security|archive.debian.org/debian-security|g' /etc/apt/sources.list && \
      echo 'Acquire::Check-Valid-Until "false";' > /etc/apt/apt.conf.d/99disable-check-valid; \
    fi

RUN apt-get update && apt-get upgrade --yes

# install usefull utilities
RUN apt-get install --yes --no-install-recommends \
    cron \
    curl \
    default-mysql-client \
    git \
    gzip \
    htop \
    mailutils \
    nano \
    postfix \
    procps \
    rsync \
    sudo \
    unzip \
    vim \
    wget \
    zip \
    openssh-client \
    && rm -rf /var/lib/apt/lists/*

ADD --chmod=0755 https://github.com/mlocati/docker-php-extension-installer/releases/latest/download/install-php-extensions /usr/local/bin/

RUN install-php-extensions @composer redis ssh2 xdebug bcmath intl zip ftp gd pdo_mysql soap xsl sockets

COPY /utils /utils
RUN chmod -R +x /utils && ln -s /utils/restart.sh /usr/bin/restart && ln -s /utils/xdebug.sh /usr/bin/xdebug && ln -s /utils/profiler.sh /usr/bin/profiler

RUN export XDEBUG_INI="/usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini" && \
    echo 'xdebug.max_nesting_level = -1' >> ${XDEBUG_INI} && \
    echo 'xdebug.mode=develop,coverage,debug' >> ${XDEBUG_INI} && \
    echo 'xdebug.client_host=172.18.0.1' >> ${XDEBUG_INI} && \
    echo 'xdebug.client_port=9003' >> ${XDEBUG_INI} && \
    echo 'xdebug.start_with_request=yes' >> ${XDEBUG_INI} && \
    echo 'xdebug.idekey="PHPSTORM"' >> ${XDEBUG_INI} && \
    echo 'xdebug.discover_client_host=1' >> ${XDEBUG_INI} && \
    cp ${XDEBUG_INI} ${XDEBUG_INI}.tmpl && \
    xdebug off

RUN groupadd magento && \
    useradd -m -d /home/magento -s /bin/bash -g magento magento && \
    usermod -aG sudo magento && \
    echo 'magento ALL=(ALL) NOPASSWD:ALL' > /etc/sudoers.d/magento && \
    chmod 0440 /etc/sudoers.d/magento


ENV PHP_IDE_CONFIG="serverName=php.magento2"

RUN export WWW_CONF="/usr/local/etc/php-fpm.d/www.conf" && \
    echo "env[PHP_IDE_CONFIG]=\"${PHP_IDE_CONFIG}\"" >> ${WWW_CONF} && \
    sed -i "s/user = .*/user = magento/g" ${WWW_CONF} && \
    sed -i "s/group = .*/group = magento/g"  ${WWW_CONF}

USER magento

ENV TERM=xterm

WORKDIR /var/www/html

EXPOSE 9000

CMD ["/utils/start.sh"]
