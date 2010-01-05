#! /bin/bash

# the old PS1="[\u@\h \W]\$ "

# moved this setting here because it wasn't working without TERM defined
# use a cygwin-style prompt

# TODO move to ps1.sh.in
# TODO configure color based on root or not

# only do this in interactive shells
echo $- | grep i &> /dev/null || return

case "${TERM}" in

  xterm | cygwin)
    PS1='\[\e]0;\u@\h \w\a\]\n\[\e[32m\]\u@\h \[\e[33m\]\w\[\e[0m\]\n\$ ';;

  linux)
    PS1='\n\[\e[32m\]\u@\h \[\e[33m\]\w\[\e[0m\]\n\$ ';;

  *) 
    PS1='\n\u@\h \w\n\$ ';;

esac
