
# Completion options
# ##################

# If this shell is interactive, turn on programmable completion enhancements.
# Any completions you add in ~/.bash_completion are sourced last.

case $- in

  *i*) [[ -f /etc/bash_completion ]] && . /etc/bash_completion ;;

esac
