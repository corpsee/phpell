#!/bin/bash

#TODO: config
DEBIAN_FRONTEND=noninteractive aptitude -y install mongodb
DEBIAN_FRONTEND=noninteractive aptitude -y install php5-mongo
