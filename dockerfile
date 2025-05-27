# this extend the official php image so that the dockerfile installs the necessary extensions using docker-php-ext-install.
# use docker-compose up --build
FROM php:8.1-apache


# Install system dependencies required by PHP extensions
RUN apt-get update && apt-get install -y \
    libpng-dev \
    libjpeg-dev \
    libonig-dev \
    libxml2-dev \
    libzip-dev \
    zip \
    unzip \
    libpq-dev \
    default-mysql-client \
    && docker-php-ext-install mysqli pdo pdo_mysql

# Optional: Enable Apache mod_rewrite (commonly used)
RUN a2enmod rewrite

#RUN apt update
#RUN apt install mysql-client mysqldump