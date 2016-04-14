#!/bin/bash

cd "${SCRIPT_DIR}/scripts"

PHPCI_HOST="phpci.virtual"

create-host -h "${PHPCI_HOST}" -p "${PHPCI_HOST}" --public=public
[ ! -d "/var/www/${PHPCI_HOST}" ] && rm -fvr "/var/www/${PHPCI_HOST}"

composer create-project block8/phpci "/var/www/${PHPCI_HOST}" --keep-vcs --no-dev --prefer-dist
cd "/var/www/${PHPCI_HOST}"

create-mysql-db --database="${PHPCI_HOST}" --user="${PHPCI_HOST}" --password="${PHPCI_HOST}" --root="${MYSQL_ROOT_PASSWORD}"

php ./console phpci:install --url=$DEFAULT_URL --db-host=localhost --db-name=$DB_NAME --db-user=homestead --db-pass=secret --admin-name=homestead --admin-pass=$ADMIN_PASSWORD --admin-mail=$ADMIN_EMAIL
