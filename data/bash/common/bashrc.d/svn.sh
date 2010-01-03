#!/bin/bash

# $Id$

# hack to force us to use the most recent version of svn
if (( $(type -ap svn | wc --lines) > 1 )); then

  for cmd in $(type -ap svn); do

    if [[ -z ${max} || ("$(${cmd} --version)" > "$(${max} --version)") ]]; then
      max="${cmd}"
    fi
  done

  alias svn="${max}"

  unset cmd
  unset max
fi
