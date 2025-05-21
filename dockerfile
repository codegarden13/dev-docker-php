# this extend the official php image so that the dockerfile installs the necessary extensions using docker-php-ext-install.
# use docker-compose up --build
FROM php:8.1-apache

# Install required PHP extensions
RUN docker-php-ext-install mysqli pdo pdo_mysql

# Optional: Enable Apache mod_rewrite (commonly used)
RUN a2enmod rewrite