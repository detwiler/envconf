# Makefile.am

include $(top_srcdir)/rules.mk

# data/script variables
inputrc = .inputrc
readline = readline.sh

# static data/scripts (not generated; require explicit distribution)
static_data = $(inputrc)

if BIND_INPUTRC
static_data += $(readline)
endif

dist_home_DATA = $(static_data)
