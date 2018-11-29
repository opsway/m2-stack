FROM alpine:3.7

ENV STORAGE=malloc
ENV STORAGE_SIZE=2G

RUN apk update && \
    apk upgrade && \
    apk add varnish && \
    mkdir -p /var/lib/varnish/
ADD default.vcl /etc/varnish/
ADD devicedetect.vcl /etc/varnish/
# ADD secret /etc/varnish/

ADD start.sh /start.sh
RUN chmod 0755 /start.sh

EXPOSE 80

CMD ["/start.sh"]
