FROM quay.io/opsway/m2-php

ENV CRON_TIME="0 3 * * *"
ENV DB_BACKUP_STORE_DAYS=7
ENV MEDIA_BACKUP_STORE_DAYS=7
ENV BASE_PATH=/app/current
ENV SAVE_DB=yes
ENV SAVE_MEDIA=yes
ENV SAVE_ON_START=yes

RUN  apk add --update rsync 

ADD backup.sh /backup.sh
ADD entrypoint.sh /entrypoint.sh
RUN rm /var/spool/cron/crontabs/www-data

RUN chmod +x /backup.sh /entrypoint.sh

CMD ["/usr/sbin/crond","-f","-L","/dev/stdout"]
ENTRYPOINT ["/entrypoint.sh"]

