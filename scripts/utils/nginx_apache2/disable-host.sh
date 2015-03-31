#!/bin/bash

test $# -eq 1 || exit

HOST_NAME=$1

rm -f /etc/nginx/sites-enabled/"${HOST_NAME}".conf
rm -f /etc/apache2/sites-enabled/"${HOST_NAME}".conf

service apache2 reload
service nginx   reload
