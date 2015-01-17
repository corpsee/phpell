#!/bin/bash

SCRIPT_DIR=$1
SERVER_TYPE=$2

cp -v "${SCRIPT_DIR}/scripts/utils/${SERVER_TYPE}/create-host.sh" /usr/bin/create-host
chmod 755 /usr/bin/create-host

cp -v "${SCRIPT_DIR}/scripts/utils/${SERVER_TYPE}/disable-host.sh" /usr/bin/disable-host
chmod 755 /usr/bin/disable-host

cp -v "${SCRIPT_DIR}/scripts/utils/${SERVER_TYPE}/enable-host.sh" /usr/bin/enable-host
chmod 755 /usr/bin/enable-host

cp -v "${SCRIPT_DIR}/scripts/utils/extract.sh" /usr/bin/extract
chmod 755 /usr/bin/extract

cp -v "${SCRIPT_DIR}/scripts/utils/mysql-backup.sh" /usr/bin/mysql-backup
chmod 755 /usr/bin/mysql-backup

cp -v "${SCRIPT_DIR}/scripts/utils/postgres-backup.sh" /usr/bin/postgres-backup
chmod 755 /usr/bin/postgres-backup

cp -v "${SCRIPT_DIR}/scripts/utils/create-web-user.sh" /usr/bin/create-web-user
chmod 755 /usr/bin/create-web-user

cp -v "${SCRIPT_DIR}/scripts/utils/create-postgres-db.sh" /usr/bin/create-postgres-db
chmod 755 /usr/bin/create-postgres-db

cp -v "${SCRIPT_DIR}/scripts/utils/create-mysql-db.sh" /usr/bin/create-mysql-db
chmod 755 /usr/bin/create-mysql-db