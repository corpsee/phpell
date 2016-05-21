#!/bin/bash

source /usr/bin/functions

_help() {
    echo "How to use delete-host:"
    echo "Available params:"
    echo "-h|--host     - Host/owner name"
    echo
    exit 0
}

test $# -gt 0 || _help

if ! [ $(id -u -n) = "root" ]; then
   echo "Please, run script with sudo!"
   exit 1
fi

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
    confirmation "Delete host '${pHost}' with owner ${pHost}?" || exit 1
fi

disable-host -h "${pHost}" -y

userdel "${pHost}"
