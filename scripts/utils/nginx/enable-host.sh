#!/bin/bash

test $# -eq 1 || exit

HOST_NAME=$1

if [ ! -f /etc/nginx/conf.d/"${HOST_NAME}".conf ]; then
    ln -sf /etc/nginx/sites-available/"${HOST_NAME}".conf /etc/nginx/conf.d/"${HOST_NAME}".conf
fi

service php5-fpm reload
service nginx    reload
