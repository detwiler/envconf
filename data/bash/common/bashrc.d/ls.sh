#!/bin/bash

# $Id$

# ls

# Solaris doesn't have the --color option
if ls --color &> /dev/null; then
  alias ls='command ls --classify --color=tty'
  alias l.='command ls --directory --classify .* --color=tty'
  alias ll='command ls -l --classify --human-readable --color=tty'
  alias ll.='command ls -l --directory --classify --human-readable .* --color=tty'
  alias llz='command ls --classify --context --color=tty'
  alias dir='ls --color=auto --format=vertical'
  alias vdir='ls --color=auto --format=long'
else
  alias ls='command ls -F'
  alias l.='command ls -dF .*'
  alias ll='command ls -lF'
  alias ll.='command ls -ldF .*'
fi
