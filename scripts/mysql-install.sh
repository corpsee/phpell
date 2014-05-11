#!/bin/bash

DEBIAN_FRONTEND=noninteractive aptitude -y update
DEBIAN_FRONTEND=noninteractive aptitude -y install mysql-server mysql-client
DEBIAN_FRONTEND=noninteractive aptitude -y install php5-mysql