FROM t1nkl/php-alpine:fpm-8.2-debug

# Xdebug
ARG XDEBUG_VERSION=3.2.1
RUN mkdir /var/www/html/xdebug \
  && touch /var/www/html/xdebug/xdebug.log \
  && chmod 0777 /var/www/html/xdebug/xdebug.log
RUN apk --no-cache add --virtual .build-deps \
        g++ \
        autoconf \
        make && \
    pecl install xdebug-${XDEBUG_VERSION} && \
    docker-php-ext-enable xdebug && \
    apk del .build-deps && \
    rm -r /tmp/pear/* && \
    echo -e "xdebug.mode=debug,develop,profile\n\
        xdebug.start_with_request=trigger\n\
        xdebug.discover_client_host=1\n\
        xdebug.client_host=host.docker.internal\n\
        xdebug.client_port=9003\n\
        xdebug.log=/var/www/html/xdebug/xdebug.log" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini

# Clear build-dependencies
RUN rm -rf /tmp/*
