#!/bin/bash

test $# -eq 1 || exit

if [ ! -f /etc/apache2/sites-enabled/"$1".conf ]; then
    ln -sf /etc/apache2/sites-available/"$1".conf /etc/apache2/sites-enabled/"$1".conf
fi

service apache2 reload