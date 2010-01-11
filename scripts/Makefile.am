# Makefile.am

SUBDIRS =

if HAVE_SED
SUBDIRS += sed
endif HAVE_SED

if HAVE_VIM
SUBDIRS += vim
endif HAVE_VIM

dist_bin_SCRIPTS = fics \
		   makecscope \
		   mini \
		   nixify \
		   pattern-rename \
		   space2hyphen
