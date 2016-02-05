#!/bin/bash

source /usr/bin/functions

_help() {
    echo "How to use enable-host:"
    echo "Available params:"
    echo "-h|--host - Host name"
    echo
    exit 0
}

if ! [ $(id -u -n) = "root" ]; then
   echo "Please, run script with sudo!"
   exit 1
fi

test $# -gt 0 || _help

while [ 1 ]; do
    if [ "$1" == "-y" ]; then
        pYes=1
    elif processShortParam "-h" "$1" "$2"; then
        pHost="${cRes}"; shift
    elif processLongParam "--host" "$1"; then
        pHost="${cRes}"
    elif [ -z "$1" ]; then
        break
    else
        _help
    fi

    shift
done

checkParam "${pHost}" '$pHost'

if [ "${pYes}" != "1" ]; then
    confirmation "Enable host '${pHost}'?" || exit 1
fi

if [ ! -f /etc/nginx/sites-enabled/"${pHost}".conf ]; then
    ln -sf /etc/nginx/sites-available/"${pHost}".conf /etc/nginx/sites-enabled/"${pHost}".conf
fi

service php5-fpm restart
service nginx    restart
