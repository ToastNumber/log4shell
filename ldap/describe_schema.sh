#!/bin/bash
if [ $# -ne 1 ]; then
    echo "Usage: describe_schema.sh <object class>"
    exit 1
fi
ldapsearch -x -s base -b cn=Subschema objectClasses | less -i +"/$1"
