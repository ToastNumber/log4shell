#!/bin/bash
if [ $# -ne 1 ]; then
    echo "Usage: search.sh <base>"
    exit 1
fi
echo "$0"
ldapsearch -x -b "$1" '(objectclass=*)'
