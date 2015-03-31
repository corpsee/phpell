#!/bin/bash

test $# -eq 1 || exit

HOST_NAME=$1

if [ ! -f /etc/nginx/sites-enabled/"${HOST_NAME}".conf ]; then
    ln -sf /etc/nginx/sites-available/"${HOST_NAME}".conf /etc/nginx/sites-enabled/"${HOST_NAME}".conf
fi

service php5-fpm restart
service nginx    reload
