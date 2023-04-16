FROM php:8.2.4-fpm-alpine3.17

# Variables
ENV TZ=UTC
ENV BUILD_DEPS \
        libzip-dev \
        libpng-dev \
        libxml2-dev \
        postgresql-dev \
        oniguruma-dev \
        imap-dev \
        openssl-dev \
        krb5-dev \
        curl-dev \
        zlib-dev \
        libffi-dev \
        gmp-dev \
        rabbitmq-c-dev

# Install system dependencies
RUN apk upgrade --update && apk add --no-cache \
        $BUILD_DEPS \
        autoconf \
        g++ \
        gcc \
        git \
        make \
        bash \
        nano \
        libzip \
        libpng \
        libxml2 \
        postgresql \
        oniguruma \
        openssl \
        krb5 \
        curl \
        zlib \
        libffi \
        gmp \
        rabbitmq-c \
        supervisor

# Install PHP extensions
RUN docker-php-ext-install -j$(nproc) \
        imap \
        bcmath \
        intl \
        mysqli \
        pdo_mysql \
        pdo_pgsql \
        opcache \
        zip \
        pcntl \
        gd \
        sockets \
        gmp \
        ffi \
    && rm -rf /tmp/pear

# Amqp
RUN pecl install amqp \
    && docker-php-ext-enable amqp

# Composer
RUN curl -s https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer \
    && composer self-update --2 -q;

# Redis
RUN pecl install -o -f redis \
    && rm -rf /tmp/pear \
    && docker-php-ext-enable redis

# Supervisor
RUN apk add --no-cache supervisor

# PHP.ini
COPY /8.2/php/amd64/php.ini $PHP_INI_DIR/php.ini

# Clear build-dependencies
RUN rm -rf /var/www/html/* /var/cache/apk/* /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/doc/*
