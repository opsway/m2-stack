#!/bin/bash
echo "$CRON_TIME /backup.sh >> /dev/stdout" > /var/spool/cron/crontabs/root

if [[ $INIT_DB = "yes" ]];
then
    /backup.sh
fi

exec "$@"