# Makefile.am

profiledir = $(pkgdatadir)/profile.d

profile_DATA = editor.sh

CLEANFILES = $(profile_DATA)

EXTRA_DIST = editor.sh.in

edit = $(SED) -e 's:@EDITOR[@]:$(EDITOR):g'

editor.sh: editor.sh.in Makefile
	$(edit) < $(srcdir)/editor.sh.in > editor.sh

dist_profile_DATA = bash-completion.sh \
		    bash.sh
