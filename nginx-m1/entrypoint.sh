#!/bin/sh

CONF_FILE=/etc/nginx/conf.d/default.conf

sed -i 's#${DOC_ROOT}#'$DOC_ROOT'#g' "$CONF_FILE"
sed -i 's#${UPSTREAM}#'$UPSTREAM'#g' "$CONF_FILE"

exec "$@"