# !/bin/bash

# Completion options
# ##################

# If this shell is interactive, turn on programmable completion enhancements.
# Any completions you add in ~/.bash_completion are sourced last.

# we don't need to do this for Fedora as of release 8
if [[ $(uname --operating-system) == "Cygwin" ]]; then

  case $- in

    *i*) [[ -f /etc/bash_completion ]] && . /etc/bash_completion ;;

  esac
fi
