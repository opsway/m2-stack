FROM nginx:1.12.2-alpine
LABEL maintainer="OpsWay Team"

ENV DOC_ROOT=/app/current
ENV UPSTREAM=app

RUN rm /etc/nginx/conf.d/default.conf

ADD default.conf /etc/nginx/conf.d/

RUN set -x ; \
  addgroup -g 82 -S www-data ; \
  adduser -u 82 -D -S -G www-data www-data && exit 0 ; exit 1
  
ADD nginx.conf /etc/nginx/nginx.conf
ADD entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

WORKDIR /app

CMD ["nginx", "-g", "daemon off;"]

ENTRYPOINT ["/entrypoint.sh"]

