#!/bin/bash

# $Id$

# make sure java version is correct

UMBC_JAVA="/usr/local/bin/java"

if ! java -version 2>&1 | grep --quiet '1.6' &> /dev/null; then

  if [[ -f ${UMBC_JAVA} ]] && 
    ${UMBC_JAVA} -version 2>&1 | grep --quiet '1.6' &> /dev/null; then 

      alias java="${UMBC_JAVA}"
  fi

fi

unset UMBC_JAVA

