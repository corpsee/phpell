#!/bin/bash

DEBIAN_FRONTEND=noninteractive aptitude -y install memcached > /dev/null

service memcached status