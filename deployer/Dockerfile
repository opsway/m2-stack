FROM php:7.1.5-alpine

MAINTAINER herloct <herloct@gmail.com>
    
ENV DEPLOYER_VERSION=6.4.3

RUN apk update --no-cache \
    && apk add --no-cache \
        openssh-client

RUN curl -L https://deployer.org/releases/v$DEPLOYER_VERSION/deployer.phar > /usr/local/bin/dep \
    && chmod +x /usr/local/bin/dep
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
RUN composer global require deployer/recipes
ADD php.ini /usr/local/etc/php/conf.d/php.ini

ADD entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

VOLUME ["/project", "$HOME/.ssh"]
WORKDIR /project

ENTRYPOINT ["/entrypoint.sh"]


