#!/usr/bin/env bash

default_route=$(ip route show default | awk '/default/ {print $3}')
ping -qc1 $default_route 2>&1 | awk -F'/' 'END{ print (/^rtt/? ""$5" ms":"FAIL") }'
