#!/bin/bash

DB_NAME=$1
DB_USER=$2
DB_PASSWORD=$3
BACKUP_DIR=$4

CURRENT_DATE=`date +%Y-%m-%d`

[ ! -d "$BACKUP_DIR" ] && mkdir -p "$BACKUP_DIR"

sudo chgrp -R www-data    "$BACKUP_DIR"
sudo chmod -R go=rX,u=rwX "$BACKUP_DIR"

cd "$BACKUP_DIR"

COMMAND="pg_dump -O -F p -U ${DB_USER} -W ${DB_PASSWORD} -d ${DB_NAME} | gzip -c > ./${DB_NAME}_${CURRENT_DATE}.sql.gz"
eval "${COMMAND}"