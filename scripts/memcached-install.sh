#!/bin/bash

#TODO: config
DEBIAN_FRONTEND=noninteractive aptitude -y install memcached
DEBIAN_FRONTEND=noninteractive aptitude -y install php5-memcache php5-memcached
