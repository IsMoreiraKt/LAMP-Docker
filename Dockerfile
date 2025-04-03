FROM php:8.2-apache

RUN docker-php-ext-install pdo pdo_mysql mysqli
RUN a2enmod rewrite

COPY app/ /var/www/html/
RUN chown -R www-data:www-data /var/www/html

COPY ./mysql/ssl /etc/ssl/certs/mysql
