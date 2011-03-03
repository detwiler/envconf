# Makefile.am

dist_seddata_DATA = ccproto.sed \
		    get-make-error-file.sed

pkgdata_SCRIPTS = ccproto \
		  skiperror

scripts = $(pkgdata_SCRIPTS)

CLEANFILES = $(pkgdata_SCRIPTS)

EXTRA_DIST = ccproto.in \
	     skiperror.in

edit = $(SED) -e 's:@seddatadir[@]:$(seddatadir):g'

skiperror: skiperror.in Makefile
	$(AM_V_GEN)$(edit) < $< > $@

ccproto: ccproto.in Makefile
	$(AM_V_GEN)$(edit) < $< > $@

install-data-hook:
	$(AM_V_GEN)test -e $(DESTDIR)$(bindir) || mkdir -p $(DESTDIR)$(bindir)
	$(AM_V_GEN)cd $(DESTDIR)$(bindir) && \
	  for s in $(scripts); do \
	    test -e $$s || $(LN_S) $(DESTDIR)$(pkgdatadir)/$$s; \
	  done

uninstall-hook:
	$(AM_V_GEN)cd $(DESTDIR)$(bindir) && \
	  rm -f $(scripts)
