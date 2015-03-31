#!/bin/bash

test $# -eq 1 || exit

HOST_NAME=$1

rm -f /etc/nginx/sites-enabled/"${HOST_NAME}".conf

service php5-fpm restart
service nginx    reload
