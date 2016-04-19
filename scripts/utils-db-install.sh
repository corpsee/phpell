#!/bin/bash

if [[ "${INSTALL_MARIADB}" == true ]]; then
    cp -v "${SCRIPT_DIR}/scripts/utils/backup-mysql-db.sh" /usr/bin/backup-mysql-db
    chmod 755 /usr/bin/backup-mysql-db

    cp -v "${SCRIPT_DIR}/scripts/utils/create-mysql-db.sh" /usr/bin/create-mysql-db
    chmod 755 /usr/bin/create-mysql-db
elif [ "${INSTALL_MYSQL}" == true ]; then
    cp -v "${SCRIPT_DIR}/scripts/utils/backup-mysql-db.sh" /usr/bin/backup-mysql-db
    chmod 755 /usr/bin/backup-mysql-db

    cp -v "${SCRIPT_DIR}/scripts/utils/create-mysql-db.sh" /usr/bin/create-mysql-db
    chmod 755 /usr/bin/create-mysql-db
fi

if [ "${INSTALL_POSTGRESQL}" == true ]; then
    cp -v "${SCRIPT_DIR}/scripts/utils/backup-postgres-db.sh" /usr/bin/backup-postgres-db
    chmod 755 /usr/bin/backup-postgres-db

    cp -v "${SCRIPT_DIR}/scripts/utils/create-postgres-db.sh" /usr/bin/create-postgres-db
    chmod 755 /usr/bin/create-postgres-db
fi
