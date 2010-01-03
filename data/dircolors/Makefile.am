# Makefile.am

dist_pkgdata_DATA = dircolors

profiledir = $(pkgdatadir)/profile.d

profile_DATA = dircolors.sh

CLEANFILES = $(profile_DATA)

EXTRA_DIST = dircolors.sh.in

edit = $(SED) -e 's:@pkgdatadir[@]:$(pkgdatadir):g'

dircolors.sh: dircolors.sh.in Makefile
	$(edit) < $(srcdir)/dircolors.sh.in > dircolors.sh
