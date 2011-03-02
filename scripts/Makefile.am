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
		   get-autotools \
		   get-bash \
		   get-git \
		   makecscope \
		   mini \
		   nixify \
		   pattmv \
		   space2hyphen \
		   weather

DISTCLEANFILES = $(bin_SCRIPTS)

EXTRA_DIST = upper2lower.cygwin \
	     upper2lower.linux
