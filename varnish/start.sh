#!/bin/sh

if [ $STORAGE = "file" ] ; then
    STORAGE_PATH=",/var/lib/varnish/varnish_storage.bin"
fi

varnishd -F -a :80 \
   -f /etc/varnish/default.vcl \
   -p http_resp_hdr_len=131072 -p http_resp_size=131072 \
   -s $STORAGE$STORAGE_PATH,$STORAGE_SIZE 

echo "$STORAGE$STORAGE_PATH,$STORAGE_SIZE"

tail -f /dev/null
