# Magento 2 docker stack

It is universal docker stack for running magento 2. There are source files for php, nginx, varnish. Also few examples for running different variants magento 2.

## php
you can use next env var for php image
NEWRELIC_LICENSE - license key for new relic agent <br>
NEWRELIC_APPNAME - new relic application name (for displaing in new relic dashbourd ) <br>
XDEBUG - enabla xdebug ( set "YES" )
XDEBUG_REMOTE_PORT - port which your IDE listen for xdebug (default 9001) <br> 
XDEBUG_REMOTE_HOST - IDE IP. ( see XDEBUG section )
XDEBUG_REMOTE_AUTOSTART 
SSH_SERVER - enable SSH_SERVER in php container
DEV_ENV - set dev mode fot php 
COMPOSER_USERNAME - user name and password for auth.json 
COMPOSER_PASSWORD - 

### XDEBUG
__local usage__ <br>
you need set next env vars 
XDEBUG="yes"
XDEBUG_REMOTE_HOST - set IP local address, ( e.g. 192.168.0.10 )
XDEBUG_REMOTE_AUTOSTART="yes"

__remote usage__ <br>
first of all you have to set up SSH for php. Than enable xdebug by adding env var XDEBUG="yes". Last step setup tunnel <br>
ssh -R localhost:9001:localhost:9001 www-data@%REMOTE_SERVER% -p %PORT%

### SSH
you can use SSH for connecting to container: 
- SSH_SERVER="yes" 
- add volume with files contains ssh open keys -<br>authorized_keys:/home/www-data/.ssh/authorized_keys
- set port mapping - 2222:22

ssh -p 2222 www-data@SERVER_IP 


## nginx
DOC_ROOT nginx document root param (default /app/current) <br>
UPSTREAM upstream for php-fpm (default app)

## varnish 
STORAGE ( file | malloc ) default=malloc
STORAGE_SIZE default=2G

