#!/bin/bash
echo "$CRON_TIME /backup.sh >> /dev/stdout" > /var/spool/cron/crontabs/root

exec "$@"