FROM php:8.1-fpm
LABEL maintaner="Sergey Nezbritskiy"

RUN apt update
RUN apt upgrade --yes

# install usefull utilities
RUN apt install --yes --no-install-recommends sudo cron nano htop vim wget git zip unzip git mariadb-client-10.5

# install composer
RUN curl -sS https://getcomposer.org/installer | php -- --version="2.2.18" --install-dir=/usr/local/bin --filename=composer

# increase php memory limit
RUN echo 'memory_limit=2G' >> /usr/local/etc/php/conf.d/docker-php-ram-limit.ini

# install xdebug extension
RUN pecl install xdebug
RUN docker-php-ext-enable xdebug
ADD docker-php-ext-xdebug.ini /docker-php-ext-xdebug.ini
ARG XDEBUG_ENABLED
ENV XDEBUG_ENABLED ${XDEBUG_ENABLED}
ENV PHP_IDE_CONFIG "serverName=php.magento2"

# install gd extension
RUN apt install libfreetype6-dev libpng-dev libwebp-dev libicu-dev libjpeg62-turbo-dev --yes
RUN docker-php-ext-configure gd --enable-gd --with-freetype --with-jpeg --with-webp
RUN docker-php-ext-install gd

# install zip extension
RUN apt install --yes --no-install-recommends libzip-dev
RUN docker-php-ext-install zip

# install soap extension
RUN apt install --yes --no-install-recommends libxml2-dev
RUN docker-php-ext-install soap

# install xsl extension
RUN apt install --yes --no-install-recommends libxslt1-dev
RUN docker-php-ext-install xsl

# install intl extension
RUN docker-php-ext-install intl

# install bcmatch extension
RUN docker-php-ext-install bcmath

# install sockets extension
RUN docker-php-ext-install sockets

# install pdo_mysql extension
RUN docker-php-ext-install pdo_mysql

#RUN apt install --yes --no-install-recommends apt-utils
#RUN apt install --yes --no-install-recommends sendmail-bin
#RUN apt install --yes --no-install-recommends sendmail
#RUN apt install --yes --no-install-recommends iproute2
#RUN apt install --yes --no-install-recommends gnupg2
#RUN apt install --yes --no-install-recommends ca-certificates
#RUN apt install --yes --no-install-recommends lsb-release
#RUN apt install --yes --no-install-recommends software-properties-common
#RUN apt install --yes --no-install-recommends libbz2-dev
#RUN apt install --yes --no-install-recommends libgeoip-dev
#RUN apt install --yes --no-install-recommends libgmp-dev
#RUN apt install --yes --no-install-recommends libgpgme11-dev
#RUN apt install --yes --no-install-recommends libmagickwand-dev
#RUN apt install --yes --no-install-recommends libmagickcore-dev
#RUN apt install --yes --no-install-recommends libc-client-dev
#RUN apt install --yes --no-install-recommends libkrb5-dev
#RUN apt install --yes --no-install-recommends libldap2-dev
#RUN apt install --yes --no-install-recommends libpspell-dev
#RUN apt install --yes --no-install-recommends librecode0
#RUN apt install --yes --no-install-recommends librecode-dev
#RUN apt install --yes --no-install-recommends libtidy-dev
#RUN apt install --yes --no-install-recommends libxslt1-dev
#RUN apt install --yes --no-install-recommends libyaml-dev
#RUN apt install --yes --no-install-recommends libzip-dev
#RUN apt install --yes --no-install-recommends libonig-dev

#RUN pecl install -o -f \
##  geoip-1.1.1 \
#  gnupg \
#  igbinary \
#  imagick \
#  mailparse \
#  msgpack \
#  oauth \
#  pcov \
#  propro \
#  raphf \
#  redis \
#  xdebug-3.1.2 \
#  yaml

# Install required PHP extensions
#RUN docker-php-ext-install -j$(nproc) \
#  bcmath \
#  bz2 \
#  calendar \
#  exif \
#  gd \
#  gettext \
#  gmp \
#  imap \
#  intl \
#  mysqli \
#  opcache \
#  pdo_mysql \
#  pspell \
#  shmop \
#  soap \
#  sockets \
#  sysvmsg \
#  sysvsem \
#  sysvshm \
#  tidy \
#  xmlrpc \
#  xsl \
#  zip \
#  pcntl


#RUN apt install vi libmcrypt-dev libxslt1-dev libonig-dev libzip-dev --yes

#RUN docker-php-ext-install bcmath
#RUN docker-php-ext-install intl mbstring pdo_mysql soap sockets xsl zip

# remove redundand apt artifacts
RUN rm -rf /var/lib/apt/lists/*

# add apache user
RUN adduser apache
RUN echo '%apache ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
RUN sed -i "s/user =.*/user = apache/" /usr/local/etc/php-fpm.d/www.conf
RUN sed -i "s/group =.*/group = apache/" /usr/local/etc/php-fpm.d/www.conf
USER apache

# run the container
ADD start.sh /start.sh
RUN sudo chmod +x /start.sh
CMD ["/start.sh"]
