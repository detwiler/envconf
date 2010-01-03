#!/bin/bash

# $Id$

# Misc :)
alias less='less -r'                          # raw control characters
alias whence='type -a'                        # where, of a sort

# show grep matches in color if it supports that option
if echo "color" | grep --color "color" &> /dev/null; then
  alias grep='grep --color'                   # show differences in color
fi

alias c='clear'

