# Makefile.am

SUBDIRS = autoconf \
	  bash \
	  git \
	  man \
	  readline

if HAVE_DIRCOLORS
SUBDIRS += dircolors
endif

if HAVE_SVN
SUBDIRS += svn
endif

if HAVE_VIM
SUBDIRS += vim
endif
