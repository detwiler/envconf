#!/bin/bash

# $Id$

# the old PS1="[\u@\h \W]\$ "

# moved this setting here because it wasn't working without TERM defined
# use a cygwin-style prompt

case "${TERM}" in

  xterm | cygwin)
    PS1='\[\e]0;\u@\h \w\a\]\n\[\e[32m\]\u@\h \[\e[33m\]\w\[\e[0m\]\n\$ ';;

  linux)
    PS1='\n\[\e[32m\]\u@\h \[\e[33m\]\w\[\e[0m\]\n\$ ';;

  *) 
    PS1='\n\u@\h \w\n\$ ';;

esac

# hack to force us to use the most recent version of bash
if (( $(type -ap bash | wc --lines) > 1 )); then

  for cmd in $(type -ap bash); do

    if [[ -z ${max} || ("$(${cmd} --version)" > "$(${max} --version)") ]]; then
      max="${cmd}"
    fi
  done

  alias bash="${max}"

  unset cmd
  unset max
fi
