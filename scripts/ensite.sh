#!/bin/sh

test $# -eq 1 || exit

if [ ! -f /etc/nginx/sites-available/"$1" ]
then
	rm -f /etc/nginx/sites-enabled/"$1"
	ln -s /etc/nginx/sites-available/"$1" /etc/nginx/sites-enabled/"$1"
	a2ensite "$1"
fi

/etc/init.d/apache2 reload
/etc/init.d/nginx   reload