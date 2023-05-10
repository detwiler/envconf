# Makefile.am

SUBDIRS = autoconf \
	  bash \
	  git \
	  gnupg \
	  man \
	  readline \
	  ssh \
	  vim \
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

if HAVE_DIRCOLORS
SUBDIRS += dircolors
endif

if HAVE_RUBY
SUBDIRS += ruby
endif
