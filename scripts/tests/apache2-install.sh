#!/bin/bash

echo 'APACHE2 TEST'
echo '============'

if [[ $(apache2 -v | grep -o -m 1 'Apache/2\.4') != '' ]]; then
    echo "    Apache version (2.4+): ok"
else
    echo "    Apache version (2.4+): fail"
fi
