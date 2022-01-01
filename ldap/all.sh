#!/bin/bash
ldapsearch -x -b 'dc=example,dc=com' '(objectclass=*)'
