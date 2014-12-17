#!/bin/bash

test $# -eq 1 || exit

rm -f /etc/nginx/conf.d/"$1".conf
rm -f /etc/apache2/sites-enabled/"$1".conf

service apache2 reload
service nginx   reload