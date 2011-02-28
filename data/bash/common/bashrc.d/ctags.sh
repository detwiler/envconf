#! /bin/bash

# TODO make java tags

CTAGSFLAGS="--links=yes --totals --recurse --extra=+fq --fields=+aiKlmnSz"
CTAGSFLAGS="$CTAGSFLAGS --c-kinds=+px --c++-kinds=+px"

alias makectags="ctags $CTAGSFLAGS"

unset CTAGSFLAGS
