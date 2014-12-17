#!/bin/bash

test $# -eq 1 || exit

if [ ! -f /etc/nginx/conf.d/"$1".conf ]; then
	ln -sf /etc/nginx/sites-available/"$1".conf /etc/nginx/conf.d/"$1".conf
fi

if [ ! -f /etc/apache2/sites-enabled/"$1".conf ]; then
	ln -sf /etc/apache2/sites-available/"$1".conf /etc/apache2/sites-enabled/"$1".conf
fi

/etc/init.d/apache2 reload
/etc/init.d/nginx   reload