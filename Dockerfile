FROM php:8.1-cli
LABEL maintaner="Sergey Nezbritskiy"

RUN apt update
RUN apt install cron libfreetype6-dev libicu-dev libjpeg62-turbo-dev libmcrypt-dev libxslt1-dev zip unzip git mariadb-client-10.5 libonig-dev libzip-dev --yes
RUN docker-php-ext-install bcmath gd intl mbstring pdo_mysql soap sockets xsl zip

#install composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

ENTRYPOINT ["docker-php-entrypoint"]
CMD ["php", "-a"]