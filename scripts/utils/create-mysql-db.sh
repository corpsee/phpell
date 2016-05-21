#!/bin/bash

source /usr/bin/functions

_help() {
    echo "How to use create-mysql-db:"
    echo "Available params:"
    echo "-d|--database - Database name"
    echo "-u|--user     - User/Database owner"
    echo "-p|--password - User/Database owner password"
    echo "-r|--root     - MySQL root password"
    echo
    exit 0
}

test $# -gt 0 || _help

while [ 1 ]; do
    if [ "$1" == "-y" ] ; then
        pYes=1
    elif processShortParam "-d" "$1" "$2"; then
        pDatabase="${cRes}"; shift
    elif processLongParam "--database" "$1"; then
        pDatabase="${cRes}"
    elif processShortParam "-u" "$1" "$2"; then
        pUser="${cRes}"; shift
    elif processLongParam "--user" "$1"; then
        pUser="${cRes}"
    elif processShortParam "-p" "$1" "$2"; then
        pPassword="${cRes}"; shift
    elif processLongParam "--password" "$1"; then
        pPassword="${cRes}"
    elif processShortParam "-r" "$1" "$2"; then
        pRoot="${cRes}"; shift
    elif processLongParam "--root" "$1"; then
        pRoot="${cRes}"
    elif [ -z "$1" ]; then
        break
    else
        _help
    fi

    shift
done

checkParam "${pDatabase}" '$pDatabase'
checkParam "${pUser}"     '$pUser'
checkParam "${pPassword}" '$pPassword'
checkParam "${pRoot}"     '$pRoot'

if [ "${pYes}" != "1" ]; then
    confirmation "Create MySQL database '${pDatabase}' with owner ${pUser}/${pPassword}?" || exit 1
fi

mysql -u root -p"${pRoot}" -e "CREATE DATABASE \`${pDatabase}\`;"
mysql -u root -p"${pRoot}" -e "GRANT ALL ON \`${pDatabase}\`.* TO '${pUser}'@localhost IDENTIFIED BY '${pPassword}';"
mysql -u root -p"${pRoot}" -e "FLUSH PRIVILEGES;"

# mysql -u ${pUser} -p${pPassword} -D ${pDatabase}
