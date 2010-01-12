# Makefile.am

dist_seddata_DATA = ccproto.sed \
		    get-make-error-file.sed

bin_SCRIPTS = ccproto \
	      skiperror

CLEANFILES = $(bin_SCRIPTS)

EXTRA_DIST = ccproto.in \
	     skiperror.in

edit = $(SED) -e 's:@seddatadir[@]:$(seddatadir):g'

skiperror: skiperror.in Makefile
	$(edit) < $(srcdir)/skiperror.in > skiperror

ccproto: ccproto.in Makefile
	$(edit) < $(srcdir)/ccproto.in > ccproto
