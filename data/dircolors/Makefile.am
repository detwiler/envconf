# Makefile.am

dist_pkgconf_DATA = dircolors

profile_DATA = dircolors.sh

CLEANFILES = $(profile_DATA)

EXTRA_DIST = dircolors.sh.in

edit = $(SED) -e 's:@pkgconfdir[@]:$(pkgconfdir):g'

dircolors.sh: dircolors.sh.in Makefile
	$(AM_V_GEN)$(edit) < $< > $@
