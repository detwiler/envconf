# Makefile.am

dist_vimdata_DATA = beautify.vim \
		    kr2allman.vim

pkgdata_SCRIPTS = beautify \
		  kr2allman

scripts = $(pkgdata_SCRIPTS)

CLEANFILES = $(pkgdata_SCRIPTS)

EXTRA_DIST = beautify.in \
	     kr2allman.in

edit = $(SED) -e 's:@vimdatadir[@]:$(vimdatadir):g'

beautify: beautify.in Makefile
	$(AM_V_GEN)$(edit) < $< > $@

kr2allman: kr2allman.in Makefile
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
