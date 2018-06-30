FROM php:7.1-fpm-alpine
LABEL maintainer="OpsWay Team"

# Install libs
RUN apk upgrade --update \
    && apk add --no-cache --virtual .build-deps $PHPIZE_DEPS \
    && apk add --no-cache \
        bash \
        git \
        zip \
        unzip \
        mysql-client \
        icu-dev \
        libmcrypt-dev \
        freetype-dev \
        libjpeg-turbo-dev \
        libxml2-dev \
        libpng-dev \
        zlib-dev \
        libpng \
        libjpeg-turbo \
        libmcrypt \
        freetype \
        icu-libs \
        libxslt-dev \
        libxslt \
        openssh \
        # Prepare PHP extensions and configs
    && docker-php-ext-configure gd --with-gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ --with-png-dir=/usr/include/ \
    && docker-php-ext-install \ 
        gd \
        intl \
        mbstring \
        mcrypt \
        opcache \
#        pdo \
        pdo_mysql \
        soap \
        sockets \
        zip \
        xsl \
        bcmath \
    && pecl install \
        redis-3.1.6 \
    && docker-php-ext-enable redis \
    && docker-php-source delete \
    && rm -Rf /usr/local/etc/php-fpm.d/zz-docker.conf \
    # Cleanup to keep the images size small
    && apk del --no-cache \
        icu-dev \
        libxslt-dev \
#        libxml2-dev \
#        libmcrypt-dev \
#        freetype-dev \
#        libjpeg-turbo-dev \
        libpng-dev \
        zlib-dev \
    && apk del .build-deps \
    && rm -rf /var/cache/apk/* \
    && ls -A1 /tmp | xargs rm -rf \
    # Install Composer
    && curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer \
    && composer global require hirak/prestissimo \
    && cp -r /root/.composer /home/www-data/.composer \
    && chown -R www-data /home/www-data \
    # Install N98-Magerun
    && curl -O https://files.magerun.net/n98-magerun2.phar \
        && mv ./n98-magerun2.phar /usr/local/bin/n98-magerun2 \
        && chmod +x /usr/local/bin/n98-magerun2

COPY www.conf /usr/local/etc/php-fpm.d/
COPY php.ini /usr/local/etc/php/conf.d
COPY docker-entrypoint.sh /entrypoint.sh

RUN  /usr/bin/ssh-keygen -A
COPY sshd_config /etc/ssh/

RUN chmod a+x /entrypoint.sh \
    && mkdir -p /var/run/php

WORKDIR /app/current
CMD ["php-fpm"]
ENTRYPOINT ["/entrypoint.sh"]

