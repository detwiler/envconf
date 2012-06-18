# Makefile.am

profile_DATA = editor.sh

if WITH_GNULIB_SRCDIR
profile_DATA += gnulib.sh
endif

dist_profile_DATA = bash-completion.sh \
		    bash.sh

if WITH_ANDROID_BINDIR
profile_DATA += android.sh
endif WITH_ANDROID_BINDIR

DISTCLEANFILES = $(profile_DATA)
