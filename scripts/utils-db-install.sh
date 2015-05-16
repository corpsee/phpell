#!/bin/bash

SCRIPT_DIR=$1
DB_TYPE=$2

cp -v "${SCRIPT_DIR}/scripts/utils/${DB_TYPE}-backup.sh" "/usr/bin/${DB_TYPE}-backup"
chmod 755 /usr/bin/${DB_TYPE}-backup

cp -v "${SCRIPT_DIR}/scripts/utils/create-${DB_TYPE}-db.sh" "/usr/bin/create-${DB_TYPE}-db"
chmod 755 "/usr/bin/create-${DB_TYPE}-db"
