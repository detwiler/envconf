# Makefile.am

SUBDIRS =

if HAVE_SED
SUBDIRS += sed
endif HAVE_SED

if HAVE_VIM
SUBDIRS += vim
endif HAVE_VIM

pkgdata_SCRIPTS = get-git \
		  get-gnu-tool \
		  upper2lower

dist_pkgdata_SCRIPTS = fics \
		       get-autotools \
		       makecscope \
		       mini \
		       nixify \
		       pattmv \
		       space2hyphen \
		       weather

scripts = $(pkgdata_SCRIPTS) \
	  $(dist_pkgdata_SCRIPTS) 

DISTCLEANFILES = $(pkgdata_SCRIPTS)

EXTRA_DIST = upper2lower.cygwin \
	     upper2lower.linux

install-data-hook:
	$(AM_V_GEN)test -e $(DESTDIR)$(bindir) || mkdir -p $(DESTDIR)$(bindir)
	$(AM_V_GEN)cd $(DESTDIR)$(bindir) && \
	  for s in $(scripts); do \
	    test -e $$s || $(LN_S) $(DESTDIR)$(pkgdatadir)/$$s; \
	  done

uninstall-hook:
	$(AM_V_GEN)cd $(DESTDIR)$(bindir) && \
	  rm -f $(scripts)
