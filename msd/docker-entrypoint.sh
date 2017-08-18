#!/bin/sh

set -e

if [ "$NAMESERVERS" == "" ]; then
    export NAMESERVERS=$(cat /etc/resolv.conf | grep "nameserver" | awk '{print $2}' | tr '\n' ' ')
fi

envsubst '$NAMESERVERS' < /etc/nginx/nginx.conf.template > /etc/nginx/nginx.conf

# start php-fpm
/usr/bin/php-fpm

exec nginx -g "daemon off;" "$@"