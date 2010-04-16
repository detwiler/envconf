#! /bin/sh

touch ChangeLog || exit 1

autoreconf --verbose --install --force
