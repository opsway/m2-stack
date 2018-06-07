FROM alpine
 
RUN apk update && \
    apk upgrade && \
    apk add varnish && \
    mkdir -p /var/lib/varnish/
# ADD default.vcl /etc/varnish/
# ADD secret /etc/varnish/

ADD start.sh /start.sh
RUN chmod 0755 /start.sh

CMD ["/start.sh"]
