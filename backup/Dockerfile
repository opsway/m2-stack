FROM quay.io/opsway/m2-php

ENV CRON_TIME="0 3 * * *"
ENV DB_BACKUP_STORE_DAYS=7
ENV BASE_PATH=/app/current
ENV CREATE_DB=yes
# ENV CREATE_MEDIA=no


ADD backup.sh /backup.sh

RUN  apk add --update rsync \
    && chmod +x /backup.sh

# RUN echo "0 3 * * * /backup.sh >> /backup.log" >> /var/spool/cron/crontabs/root
RUN rm /var/spool/cron/crontabs/root

