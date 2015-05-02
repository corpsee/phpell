#!/bin/bash

DB_NAME=$1
DB_USER=$2
DB_PASSWORD=$3
ROOT_PASSSWORD=$4

mysql -u root -p"${ROOT_PASSSWORD}" -e "CREATE DATABASE ${DB_NAME};"
mysql -u root -p"${ROOT_PASSSWORD}" -e "GRANT ALL ON ${DB_NAME}.* TO '${DB_USER}'@localhost IDENTIFIED BY '${DB_PASSWORD}';"
mysql -u root -p"${ROOT_PASSSWORD}" -e "FLUSH PRIVILEGES;"

# mysql -u ${DB_USER} -p${DB_PASSWORD} -D ${DB_NAME}
