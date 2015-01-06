#!/bin/bash

DB_NAME=$1
DB_USER=$2
DB_PASSWORD=$3
ROOT_PASSSWORD=$4

mysql -uroot -p "${ROOT_PASSSWORD}" -e "CREATE DATABASE ${DB_NAME};"
mysql -uroot -p "${ROOT_PASSSWORD}" -e "GRANT ALL ON ${DB_NAME}.* TO ${DB_USER}@localhost IDENTIFIED BY '${DB_PASSWORD}';"
mysql -uroot -p "${ROOT_PASSSWORD}" -e "FLUSH PRIVILEGES;"