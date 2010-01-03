#!/bin/bash

# $Id$

# hack to force us to use the most recent version of vim
if (( $(type -ap vim | wc --lines) > 1 )); then

  for cmd in $(type -ap vim); do

    if [[ -z ${max} || ("$(${cmd} --version)" > "$(${max} --version)") ]]; then
      max="${cmd}"
    fi
  done

  alias vim="${max}"

  unset cmd
  unset max
fi
