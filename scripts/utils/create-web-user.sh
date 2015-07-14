#!/bin/bash

source /usr/bin/functions

_help() {
    echo "How to use create-web-user:"
    echo "Available params:"
    echo "-u|--user     - User name"
    echo "-p|--password - User password"
    echo
    exit 0
}

test $# -gt 0 || _help

while [ 1 ]; do
    if [ "$1" = "-y" ] ; then
        pYes=1
    elif processShortParam "-u" "$1" "$2"; then
        pUser="${cRes}"; shift
    elif processLongParam "--user" "$1"; then
        pUser="${cRes}"
    elif processShortParam "-p" "$1" "$2"; then
        pPassword="${cRes}"; shift
    elif processLongParam "--password" "$1"; then
        pPassword="${cRes}"
    elif [ -z "$1" ]; then
        break
    else
        _help
    fi

    shift
done

checkParam "${pUser}"     '$pUser'
checkParam "${pPassword}" '$pPassword'

if [ "${pYes}" != "1" ]; then
    confirmation "Create web user ${pUser}/${pPassword}?" || exit 1
fi

useradd -g www-data -d /home/"${pUser}" -m -s /bin/bash "${pUser}"
echo "${pUser}:${pPassword}" | chpasswd

usermod -a -G sudo "${pUser}"
