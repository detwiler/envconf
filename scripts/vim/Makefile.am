# Makefile.am

dist_vimdata_DATA = beautify.vim \
		    kr2allman.vim

bin_SCRIPTS = beautify \
	      kr2allman

CLEANFILES = $(bin_SCRIPTS)

EXTRA_DIST = beautify.in \
	     kr2allman.in

edit = $(SED) -e 's:@vimdatadir[@]:$(vimdatadir):g'

beautify: beautify.in Makefile
	$(AM_V_GEN)$(edit) < $(srcdir)/beautify.in > beautify

kr2allman: kr2allman.in Makefile
	$(AM_V_GEN)$(edit) < $(srcdir)/kr2allman.in > kr2allman
