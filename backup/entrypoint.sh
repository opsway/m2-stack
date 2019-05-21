#!/bin/bash
echo "$CRON_TIME /backup.sh >> /dev/stdout" > /var/spool/cron/crontabs/root

if [[ $SAVE_ON_START = "yes" ]];
then
    /backup.sh
fi

exec "$@"