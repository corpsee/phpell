#!/bin/bash

cp -v "${SCRIPT_DIR}/scripts/utils/backup-${DB_TYPE}-db.sh" "/usr/bin/backup-${DB_TYPE}-db"
chmod 755 /usr/bin/backup-${DB_TYPE}-db

cp -v "${SCRIPT_DIR}/scripts/utils/create-${DB_TYPE}-db.sh" "/usr/bin/create-${DB_TYPE}-db"
chmod 755 "/usr/bin/create-${DB_TYPE}-db"
