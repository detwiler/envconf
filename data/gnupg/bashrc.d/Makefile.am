# Makefile.am

include $(top_srcdir)/rules.mk

# data/script variables
gpg2 = gpg2.sh

# data/scripts generated by configure (source file automatically distributed)

if HAVE_GPG2
conf_data = $(gpg2)
endif

bashrc_DATA = $(conf_data)

DISTCLEANFILES = $(conf_data)
