FROM nginx:1.12.2-alpine
LABEL maintainer="OpsWay Team"

RUN rm /etc/nginx/conf.d/default.conf

ADD default.conf /etc/nginx/conf.d/

RUN set -x ; \
  addgroup -g 82 -S www-data ; \
  adduser -u 82 -D -S -G www-data www-data && exit 0 ; exit 1
  
ADD nginx.conf /etc/nginx/nginx.conf

WORKDIR /app