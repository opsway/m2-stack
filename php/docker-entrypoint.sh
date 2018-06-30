#!/bin/bash

if [ -n "${NEWRELIC_LICENSE}" ];
then
    rm -Rf "$PHP_INI_DIR/conf.d/100-newrelic.ini"
    docker-php-ext-enable --ini-name 100-newrelic.ini newrelic.so
    echo "[newrelic]" >> "$PHP_INI_DIR/conf.d/100-newrelic.ini"
    echo "newrelic.license = \"${NEWRELIC_LICENSE}\"" >> "$PHP_INI_DIR/conf.d/100-newrelic.ini"
    echo "newrelic.appname = \"${NEWRELIC_APPNAME:-CastroLive}\"" >> "$PHP_INI_DIR/conf.d/100-newrelic.ini"
    newrelic-daemon --pidfile /var/run/newrelic-daemon.pid
fi

if [ -n "${XDEBUG}" ];
then
    docker-php-ext-enable xdebug.so
fi

if [ ! -z "${SSH_SERVER}" ];
then
    deluser www-data
    delgroup www-data
    addgroup -g 82 www-data 
    adduser -u 82 -D -s /bin/bash -G www-data www-data
    www_data_passwd=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 12 | head -n 1)
    echo -e "${www_data_passwd}\n${www_data_passwd}\n" | passwd www-data

    apk add --update sudo openssh
    echo "www-data ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/www-data

    /usr/sbin/sshd || true
fi

exec "$@"