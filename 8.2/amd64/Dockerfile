FROM php:8.2.4-fpm-alpine3.17

# Set timezone
ENV TZ=UTC

# Install system dependencies
RUN apk upgrade --update && apk add --no-cache \
        gcc \
        g++ \
        make \
        bash \
        nano \
        git \
        libzip \
        libpng \
        libxml2 \
        postgresql \
        oniguruma \
        imap \
        openssl \
        krb5 \
        curl \
        zlib \
        libffi \
        gmp \
        supervisor

# Install build dependencies
RUN apk add --no-cache --virtual .build-deps \
        $PHPIZE_DEPS \
        imap-dev \
        libpng-dev \
        libxml2-dev \
        postgresql-dev \
        libzip-dev \
        openssl-dev \
        krb5-dev \
        curl-dev \
        zlib-dev \
        libffi-dev \
        gmp-dev

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
    && pecl install redis \
    && docker-php-ext-enable redis \
    && rm -rf /tmp/pear

# Composer
RUN curl -s https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer \
    && composer self-update --2 -q;

# Supervisor
RUN apk add --no-cache supervisor

# PHP.ini
COPY /8.2/amd64/php.ini $PHP_INI_DIR/php.ini

# Clear build-dependencies
RUN rm -rf /var/www/html/* /var/cache/apk/* /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/doc/*
