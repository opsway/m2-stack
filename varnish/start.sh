#!/bin/sh

varnishd -F -a :80 \
   -f /etc/varnish/default.vcl \
   -p http_resp_hdr_len=131072 -p http_resp_size=131072
   -s file,/var/lib/varnish/varnish_storage.bin,2G 

tail -f /dev/null
