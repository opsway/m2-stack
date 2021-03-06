FROM php:5.6-fpm-alpine
LABEL maintainer="OpsWay Team"

# env for php.ini
ENV XDEBUG_REMOTE_PORT=9001
ENV XDEBUG_REMOTE_HOST=127.0.0.1
ENV XDEBUG_REMOTE_AUTOSTART="off"

ENV NEWRELIC_VERSION php5-8.6.0.238
ENV NR_INSTALL_SILENT yes

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
        g++ \
        make 

        # Prepare PHP extensions and configs 
RUN  wget http://downloads3.ioncube.com/loader_downloads/ioncube_loaders_lin_x86-64.tar.gz -P /tmp/ \    
    && tar -xvzf /tmp/ioncube_loaders_lin_x86-64.tar.gz -C /tmp/ \
    && mkdir -p /usr/local/php/ext/ioncube \
    && cp /tmp/ioncube/ioncube_loader_lin_7.1.so /usr/local/php/ext/ioncube/ioncube_loader.so \
    && rm -r /tmp/ioncube /tmp/ioncube_loaders_lin_x86-64.tar.gz \
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
        xdebug \
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
        make \
        g++ \
    && apk del .build-deps \
    && rm -rf /var/cache/apk/* \
    && ls -A1 /tmp | xargs rm -rf \
    # Install Composer
    && curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer \
    && composer global require hirak/prestissimo \
    && cp -r /root/.composer /home/www-data/.composer \
    && chown -R www-data /home/www-data \
    # Install N98-Magerun
    && curl -O https://files.magerun.net/n98-magerun.phar \
        && mv ./n98-magerun.phar /usr/local/bin/n98-magerun \
        && chmod +x /usr/local/bin/n98-magerun

# Install newrelic        
RUN mkdir -p /tmp/install \
    && cd /tmp/install \
    && curl -L -o newrelic.tar.gz "https://download.newrelic.com/php_agent/release/newrelic-$NEWRELIC_VERSION-linux-musl.tar.gz" \
    && tar -xzvf newrelic.tar.gz \
    && cd "./newrelic-$NEWRELIC_VERSION-linux-musl" \
    && ./newrelic-install install 
#    && rm -Rf /tmp/install     

COPY www.conf /usr/local/etc/php-fpm.d/
COPY php.ini /usr/local/etc/php/conf.d
COPY docker-entrypoint.sh /entrypoint.sh

RUN  /usr/bin/ssh-keygen -A
COPY sshd_config /etc/ssh/

RUN chmod a+x /entrypoint.sh \
    && mkdir -p /var/run/php

COPY crontab-www-data /var/spool/cron/crontabs/www-data

WORKDIR /app/current
CMD ["php-fpm"]
ENTRYPOINT ["/entrypoint.sh"]

