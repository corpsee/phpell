#!/bin/bash

test $# -eq 1 || exit

rm -f /etc/nginx/sites-enabled/"$1"
a2dissite "$1"

/etc/init.d/apache2 reload
/etc/init.d/nginx   reload