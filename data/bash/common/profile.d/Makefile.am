# Makefile.am

profile_DATA = editor.sh

if WITH_GNULIB_SRCDIR
profile_DATA += gnulib.sh
endif

dist_profile_DATA = bash-completion.sh \
		    bash.sh

if HAVE_ANDROID
dist_profile_DATA += android.sh
endif HAVE_ANDROID

if ENABLE_ARCH_BIN
dist_profile_DATA += arch-bin.sh
endif ENABLE_ARCH_BIN

DISTCLEANFILES = $(profile_DATA)
