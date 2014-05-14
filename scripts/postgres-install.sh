#!/bin/bash

#TODO: config
DEBIAN_FRONTEND=noninteractive aptitude -y install postgresql
DEBIAN_FRONTEND=noninteractive aptitude -y install php5-pgsql

