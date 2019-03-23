#!/bin/bash

if [ -n "${NEWRELIC_LICENSE}" ];
then
    rm -Rf "$PHP_INI_DIR/conf.d/100-newrelic.ini"
    docker-php-ext-enable --ini-name 100-newrelic.ini newrelic.so
    echo "[newrelic]" > "$PHP_INI_DIR/conf.d/100-newrelic.ini"
    echo "newrelic.license = \"${NEWRELIC_LICENSE}\"" >> "$PHP_INI_DIR/conf.d/newrelic.ini"
    echo "newrelic.appname = \"${NEWRELIC_APPNAME:-PHPapp}\"" >> "$PHP_INI_DIR/conf.d/newrelic.ini"
    newrelic-daemon --pidfile /var/run/newrelic-daemon.pid
fi

if [ -n "${XDEBUG}" ];
then
    docker-php-ext-enable xdebug.so
    echo "xdebug.remote_port = $XDEBUG_REMOTE_PORT" > /usr/local/etc/php/conf.d/xdebug.ini
    echo "xdebug.remote_host = $XDEBUG_REMOTE_HOST" >> /usr/local/etc/php/conf.d/xdebug.ini
    echo "xdebug.remote_autostart = $XDEBUG_REMOTE_AUTOSTART" >> /usr/local/etc/php/conf.d/xdebug.ini
    echo "xdebug.extended_info=1" >> /usr/local/etc/php/conf.d/xdebug.ini
    echo "xdebug.remote_enable = 1" >> /usr/local/etc/php/conf.d/xdebug.ini
fi

if [ ! -z "${SSH_SERVER}" ];
then
    deluser www-data
    delgroup www-data
    addgroup -g 82 www-data 
    adduser -u 82 -D -s /bin/bash -G www-data www-data
    www_data_passwd=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 12 | head -n 1)
    echo -e "${www_data_passwd}\n${www_data_passwd}\n" | passwd www-data

    apk add --update sudo 
    echo "www-data ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/www-data

    /usr/sbin/sshd || true
fi

if [ ! -z "${DEV_ENV}" ];
then
    echo "opcache.enable = off" > /usr/local/etc/php/conf.d/dev-env.ini
    echo "memory_limit"
fi

# if [ ! -z "${IONCUBE}" ];
# then
#     echo "zend_extension = /usr/local/php/ext/ioncube/ioncube_loader.so" > /usr/local/etc/php/conf.d/00-ioncube.ini
#     echo "ioncube.loader.key.ionparam = ${IONCUBE_KEY}" >> /usr/local/etc/php/conf.d/00-ioncube.ini
# fi   

if [ ! -z "${COMPOSER_USERNAME}" ];
then
    echo '{ "http-basic": { "repo.magento.com": { "username": "'$COMPOSER_USERNAME'", "password": "'$COMPOSER_PASSWORD'" } } }' > /home/www-data/.composer/auth.json
fi

exec "$@"