FROM t1nkl/php-alpine:fpm-8.2-arm64v8

# Swoole
ARG SWOOLE_VERSION="5.0.2"

RUN docker-php-ext-install -j$(nproc) \
            sockets \
            sysvmsg \
            sysvsem \
            sysvshm \
        && docker-php-source extract

RUN apk add --no-cache --virtual .build-deps $PHPIZE_DEPS pcre-dev && \
    docker-php-source extract && \
    mkdir /usr/src/php/ext/swoole && \
    curl -sfL https://github.com/swoole/swoole-src/archive/v${SWOOLE_VERSION}.tar.gz -o swoole.tar.gz && \
    tar xfz swoole.tar.gz --strip-components=1 -C /usr/src/php/ext/swoole && \
    docker-php-ext-configure swoole \
        --enable-mysqlnd \
        --enable-openssl \
        --enable-sockets \
        --enable-swoole-curl && \
    docker-php-ext-install -j$(nproc) swoole && \
    rm -rf swoole.tar.gz $HOME/.composer/*-old.phar && \
    docker-php-ext-enable swoole && \
    apk del .build-deps

# Clear build-dependencies
RUN rm -rf /var/www/html/* /var/cache/apk/* /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/doc/*
