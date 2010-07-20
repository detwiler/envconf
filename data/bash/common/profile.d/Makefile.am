# Makefile.am

profile_DATA = editor.sh

if WITH_GNULIB_SRCDIR
profile_DATA += gnulib.sh
endif

dist_profile_DATA = bash-completion.sh \
		    bash.sh

if HAVE_ELDK
dist_profile_DATA += eldk.sh
endif HAVE_ELDK

DISTCLEANFILES = $(profile_DATA)
