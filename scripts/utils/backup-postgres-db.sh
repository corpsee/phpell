#!/bin/bash

source /usr/bin/functions

_help() {
    echo "How to use backup-postgres-db:"
    echo "Available params:"
    echo "-d|--database - Database name"
    echo "-u|--user     - User/Database owner"
    echo
    exit 0
}

test $# -gt 0 || _help

while [ 1 ]; do
    if [ "$1" = "-y" ] ; then
        pYes=1
    elif processShortParam "-d" "$1" "$2"; then
        pDatabase="${cRes}"; shift
    elif processLongParam "--database" "$1"; then
        pDatabase="${cRes}"
    elif processShortParam "-u" "$1" "$2"; then
        pUser="${cRes}"; shift
    elif processLongParam "--user" "$1"; then
        pUser="${cRes}"
    elif [ -z "$1" ]; then
        break
    else
        _help
    fi

    shift
done

if ! [ $(id -u -n) = "${pUser}" ]; then
   echo "Please, run script from ${pUser}!"
   exit 1
fi

checkParam "${pDatabase}" '$pDatabase'
checkParam "${pUser}"     '$pUser'

if [ "${pYes}" != "1" ]; then
    confirmation "Backup PostgreSQL database '${pDatabase}'?" || exit 1
fi

CURRENT_DATE=`date +%Y-%m-%d`

cd /var/backups/"${pUser}"

COMMAND="pg_dump -O --column-inserts -F p -U ${pUser} -d ${pDatabase} | gzip > ./${pDatabase}_${CURRENT_DATE}.sql.gz"
eval "${COMMAND}"

#psql -U ${pUser} -d ${pDatabase} < ./path/to/dump.sql
