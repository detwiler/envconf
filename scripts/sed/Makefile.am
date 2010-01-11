# Makefile.am

dist_seddata_DATA = get-make-error-file.sed

bin_SCRIPTS = skiperror

CLEANFILES = $(bin_SCRIPTS)

EXTRA_DIST = skiperror.in

edit = $(SED) -e 's:@seddatadir[@]:$(seddatadir):g'

skiperror: skiperror.in Makefile
	$(edit) < $(srcdir)/skiperror.in > skiperror
