# Makefile.am

SUBDIRS = autoconf \
	  bash \
	  coreutils \
	  go \
	  man \
	  readline \
	  ssh \
	  xdg

if HAVE_AWS_CLI
SUBDIRS += aws-cli
endif

if HAVE_CMAKE3
SUBDIRS += cmake
endif

if HAVE_CONAN
SUBDIRS += conan
endif

if HAVE_EXUBERANT_CTAGS
SUBDIRS += ctags
endif

if HAVE_GIT
SUBDIRS += git
endif

if HAVE_GNULIB_REFDIR
SUBDIRS += gnulib
endif

if HAVE_GPG2
SUBDIRS += gnupg
endif

if HAVE_GREP_COLOR
SUBDIRS += grep
endif

if HAVE_RUBY
SUBDIRS += ruby
endif

if ENABLE_SCL
SUBDIRS += scl
endif

if HAVE_VIM
SUBDIRS += vim
endif
