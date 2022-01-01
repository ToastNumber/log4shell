#!/bin/bash
if [ $# -ne 1 ]; then
    echo "Usage: add.sh <ldif file>"
    exit 1;
fi
ldapadd -w secret -D "cn=Manager,dc=example,dc=com" -f $1
