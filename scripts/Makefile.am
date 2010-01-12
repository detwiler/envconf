# Makefile.am

SUBDIRS =

if HAVE_SED
SUBDIRS += sed
endif HAVE_SED

if HAVE_VIM
SUBDIRS += vim
endif HAVE_VIM

bin_SCRIPTS = upper2lower

dist_bin_SCRIPTS = fics \
		   makecscope \
		   mini \
		   nixify \
		   pattern-rename \
		   space2hyphen

DISTCLEANFILES = $(bin_SCRIPTS)

EXTRA_DIST = upper2lower.cygwin \
	     upper2lower.linux
