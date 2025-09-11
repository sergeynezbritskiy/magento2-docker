ARG PHP_VERSION="8.1"
FROM php:${PHP_VERSION}-fpm
LABEL maintaner="Sergey Nezbritskiy"

ENV DEBIAN_FRONTEND="noninteractive"

RUN apt update && apt upgrade --yes

# install usefull utilities
RUN apt install --yes --no-install-recommends \
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
    && rm -rf /var/lib/apt/lists/*

ADD --chmod=0755 https://github.com/mlocati/docker-php-extension-installer/releases/latest/download/install-php-extensions /usr/local/bin/

RUN install-php-extensions @composer

RUN install-php-extensions redis

RUN install-php-extensions ssh2

RUN install-php-extensions xdebug

RUN install-php-extensions bcmath

RUN install-php-extensions intl

RUN install-php-extensions zip

RUN install-php-extensions ftp

RUN install-php-extensions gd

RUN install-php-extensions pdo_mysql

RUN install-php-extensions soap

RUN install-php-extensions xsl

RUN install-php-extensions sockets

COPY /utils /utils
RUN chmod -R +x /utils && ln -s /utils/restart.sh /usr/bin/restart && ln -s /utils/xdebug.sh /usr/bin/xdebug

ENV PHP_IDE_CONFIG="serverName=php.magento2"

RUN export XDEBUG_INI="/usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini" && \
    echo 'xdebug.max_nesting_level = -1' >> ${XDEBUG_INI} && \
    echo 'xdebug.mode=develop,coverage,debug' >> ${XDEBUG_INI} && \
    echo 'xdebug.client_host=172.18.0.1' >> ${XDEBUG_INI} && \
    echo 'xdebug.client_port=9003' >> ${XDEBUG_INI} && \
    echo 'xdebug.start_with_request=yes' >> ${XDEBUG_INI} && \
    echo 'xdebug.idekey="PHPSTORM"' >> ${XDEBUG_INI} && \
    echo 'xdebug.discover_client_host=1' >> ${XDEBUG_INI} && \
    echo 'env[PHP_IDE_CONFIG]="magento"' >> /usr/local/etc/php-fpm.d/www.conf && \
    cp ${XDEBUG_INI} ${XDEBUG_INI}.tmpl && \
    xdebug off

RUN groupadd magento && \
    useradd -m -d /home/magento -s /bin/bash -g magento magento && \
    usermod -aG sudo magento && \
    echo 'magento ALL=(ALL) NOPASSWD:ALL' > /etc/sudoers.d/magento && \
    chmod 0440 /etc/sudoers.d/magento

USER magento

ENV TERM=xterm

WORKDIR /var/www/html

EXPOSE 9000

CMD ["/utils/start.sh"]
