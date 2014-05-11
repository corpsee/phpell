#!/bin/bash

#TODO: choose java version (6, 7, 8)
DEBIAN_FRONTEND=noninteractive add-app-repository ppa:webupd8team/java
DEBIAN_FRONTEND=noninteractive aptitude -y update
DEBIAN_FRONTEND=noninteractive aptitude -y install oracle-java7-installer