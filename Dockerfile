FROM php:8.1-fpm
LABEL maintaner="Sergey Nezbritskiy"

RUN apt update
RUN apt upgrade --yes

RUN apt install -y --no-install-recommends \
  apt-utils \
  sendmail-bin \
  sendmail \
  sudo \
  iproute2 \
  git \
  gnupg2 \
  ca-certificates \
  lsb-release \
  software-properties-common \
  libbz2-dev \
  libjpeg62-turbo-dev \
  libpng-dev \
  libfreetype6-dev \
  libgeoip-dev \
  wget \
  libgmp-dev \
  libgpgme11-dev \
  libmagickwand-dev \
  libmagickcore-dev \
  libc-client-dev \
  libkrb5-dev \
  libicu-dev \
  libldap2-dev \
  libpspell-dev \
  librecode0 \
  librecode-dev \
  libtidy-dev \
  libxslt1-dev \
  libyaml-dev \
  libzip-dev \
  zip \
  libwebp-dev \
  libonig-dev \
  && rm -rf /var/lib/apt/lists/*


RUN docker-php-ext-configure gd --enable-gd --with-freetype --with-jpeg --with-webp
RUN docker-php-ext-configure imap --with-kerberos --with-imap-ssl
RUN docker-php-ext-configure opcache --enable-opcache
RUN docker-php-ext-configure zip --with-zip

RUN docker-php-ext-install intl mbstring pdo_mysql soap sockets xsl zip
RUN docker-php-ext-install bcmath


# install composer
RUN curl -sS https://getcomposer.org/installer | php -- --version="2.2.18" --install-dir=/usr/local/bin --filename=composer

# increase php memory limit
RUN echo 'memory_limit=2G' >> /usr/local/etc/php/conf.d/docker-php-ram-limit.ini

RUN docker-php-ext-configure gd --enable-gd --with-freetype --with-jpeg --with-webp
RUN docker-php-ext-install gd

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


#RUN apt install sudo cron nano vi libfreetype6-dev libpng-dev libwebp-dev libicu-dev libjpeg62-turbo-dev libmcrypt-dev libxslt1-dev zip unzip git mariadb-client-10.5 libonig-dev libzip-dev --yes

#RUN docker-php-ext-install bcmath
#RUN docker-php-ext-install intl mbstring pdo_mysql soap sockets xsl zip

#RUN apt update
#RUN apt install sudo
#
#RUN apt install libfreetype6-dev libpng-dev libwebp-dev libicu-dev libjpeg62-turbo-dev --yes
#RUN docker-php-ext-configure gd --enable-gd --with-freetype --with-jpeg --with-webp
#RUN docker-php-ext-install gd

# add apache user
RUN adduser apache
RUN echo '%apache ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
USER apache

ENTRYPOINT ["docker-php-entrypoint"]
CMD ["php-fpm"]
