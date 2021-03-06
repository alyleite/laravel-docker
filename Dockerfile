FROM php:7.3.6-fpm-alpine3.9
RUN apk add bash mysql-client
RUN docker-php-ext-install pdo pdo_mysql

WORKDIR /var/www
RUN rm -rf /var/www/html

COPY . /var/www
COPY .env.example .env

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

RUN composer install  && php artisan key:generate && php artisan config:cache

RUN ln -s public html

RUN chown -R www-data:www-data /var/www

EXPOSE 9000
ENTRYPOINT ["php-fpm"]
