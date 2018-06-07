#!/bin/sh

varnishd -F -a :80 \
   -f /etc/varnish/default.vcl \
   -s file,/var/lib/varnish/varnish_storage.bin,2G 

tail -f /dev/null
