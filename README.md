# Magento 2 docker stack

It is universal docker stack for running magento 2. There are source files for php, nginx, varnish. Also few examples for running different variants of magento 2.

## php
you can use next env var for php image
**NEWRELIC_LICENSE** - license key for new relic agent <br>
**NEWRELIC_APPNAME** - new relic application name (for displaing in new relic dashbourd ) <br>
**XDEBUG** - enable xdebug ( set "YES" )<br>
**XDEBUG_REMOTE_PORT** - port which your IDE listen for xdebug (default 9001) <br> 
**XDEBUG_REMOTE_HOST** - IDE IP. ( see XDEBUG section )<br>
**XDEBUG_REMOTE_AUTOSTART** <br>
**SSH_SERVER** - enable SSH_SERVER in php container<br>
**DEV_ENV** - set dev mode fot php <br>
**COMPOSER_USERNAME** - user name and password for auth.json <br>
**COMPOSER_PASSWORD** <br>

### XDEBUG
__local usage__ <br>
you need set next env vars <br>
**XDEBUG**="yes"<br>
**XDEBUG_REMOTE_HOST** - set IP local address, ( e.g. 192.168.0.10 )<br>
**XDEBUG_REMOTE_AUTOSTART**="yes"<br>

__remote usage__ <br>
first of all you have to set up SSH for php. Than enable xdebug by adding env var XDEBUG="yes". Last step setup tunnel <br>
ssh -R localhost:9001:localhost:9001 www-data@%REMOTE_SERVER% -p %PORT% 

### SSH
you can use SSH for connecting to container: 
- SSH_SERVER="yes" <br>
- add volume with files contains ssh open keys authorized_keys:/home/www-data/.ssh/authorized_keys<br>
- set port mapping - 2222:22<br>

ssh -p 2222 www-data@SERVER_IP 

## cron
for running crond I have to just run php container with next params <br>
 - entrypoint /sbin/tini
 - command /entrypoint.sh /usr/sbin/crond -f -L /dev/stdout

## nginx
**DOC_ROOT** nginx document root param (default /app/current) <br>
**UPSTREAM** upstream for php-fpm (default app)

## varnish 
**STORAGE** ( file | malloc ) default=malloc<br>
**STORAGE_SIZE** default=2G
**EXTRA_PARAMS** extra varnish params. E.g. "-p default_ttl=86400"

