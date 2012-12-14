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

if WITH_IDEA_HOME
profile_DATA += idea.sh
endif WITH_IDEA_HOME

DISTCLEANFILES = $(profile_DATA)
