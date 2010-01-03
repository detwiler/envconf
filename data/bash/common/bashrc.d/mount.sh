#!/bin/bash

# $Id$

# alias for mounting windows partition

mount_options="-t ntfs -o umask=0027,uid=mike,gid=mike"

alias mountwin="su -c 'mount /dev/sda1 /mnt/windows ${mount_options}'"

unset mount_options
