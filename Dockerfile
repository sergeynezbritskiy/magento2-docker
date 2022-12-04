FROM php:8.1-fpm
LABEL maintaner="Sergey Nezbritskiy"

RUN apt update
RUN apt install sudo cron libfreetype6-dev libicu-dev libjpeg62-turbo-dev libmcrypt-dev libxslt1-dev zip unzip git mariadb-client-10.5 libonig-dev libzip-dev --yes
RUN docker-php-ext-install bcmath gd intl mbstring pdo_mysql soap sockets xsl zip

#install composer
RUN curl -sS https://getcomposer.org/installer | php -- --version="2.2.18" --install-dir=/usr/local/bin --filename=composer

#add apache user
RUN adduser apache
RUN echo '%apache ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
USER apache

ENTRYPOINT ["docker-php-entrypoint"]
CMD ["php-fpm"]
