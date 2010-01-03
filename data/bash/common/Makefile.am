# Makefile.am

SUBDIRS = bashrc.d \
	  profile.d

pkgdata_DATA = bashrc \
	       profile

CLEANFILES = $(pkgdata_DATA)

EXTRA_DIST = bashrc.in \
	     profile.in

edit = $(SED) -e 's:@pkgdatadir[@]:$(pkgdatadir):g'

bashrc: bashrc.in Makefile
	$(edit) < $(srcdir)/bashrc.in > bashrc

profile: profile.in Makefile
	$(edit) < $(srcdir)/profile.in > profile
