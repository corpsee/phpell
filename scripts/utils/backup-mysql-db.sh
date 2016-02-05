#!/bin/bash

source /usr/bin/functions

_help() {
    echo "How to use backup-mysql-db:"
    echo "Available params:"
    echo "-d|--database - Database name"
    echo "-u|--user     - User/Database owner"
    echo "-p|--password - User/Database owner password"
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

if [ "${pYes}" != "1" ]; then
    confirmation "Backup MySQL database '${pDatabase}'?" || exit 1
fi

CURRENT_DATE=`date +%Y-%m-%d`

cd /var/backups/"${pUser}"

COMMAND="mysqldump -u ${pUser} -p${pPassword} -f ${pDatabase} | gzip > ./${pDatabase}_${CURRENT_DATE}.sql.gz"
eval "${COMMAND}"

# mysql ${pDatabase} -u${pUser} -p${pPassword} < ./path/to/dump.sql
