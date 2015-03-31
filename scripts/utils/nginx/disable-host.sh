#!/bin/bash

test $# -eq 1 || exit

HOST_NAME=$1

rm -f /etc/nginx/conf.d/"${HOST_NAME}".conf

service php5-fpm reload
service nginx    reload
