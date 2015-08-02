#!/bin/bash

#!/bin/bash

source /usr/bin/functions

_help() {
    echo "How to use create-postgres-db:"
    echo "Available params:"
    echo "-d|--database - Database name"
    echo "-u|--user     - User/Database owner"
    echo "-p|--password - User/Database owner password"
    echo
    exit 0
}

if ! [ $(id -u -n) = "root" ]; then
   echo "Please, run script with sudo!"
   exit 1
fi

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
    confirmation "Create PostgreSQL database '${pDatabase}' with owner ${pUser}/${pPassword}?" || exit 1
fi

sudo -u postgres psql -c "CREATE USER \"${pUser}\" WITH PASSWORD '${pPassword}';"
sudo -u postgres psql -c "CREATE DATABASE \"${pDatabase}\";"
sudo -u postgres psql -c "GRANT ALL PRIVILEGES ON DATABASE \"${pDatabase}\" TO \"${pUser}\";"

# sudo -u ${pDatabase} psql -d ${pUser}
