# Makefile.am

SUBDIRS =

if HAVE_SED
SUBDIRS += sed
endif HAVE_SED

if HAVE_VIM
SUBDIRS += vim
endif HAVE_VIM

pkgdata_DATA = config-bash

pkgdata_SCRIPTS = dl-git \
		  dl-gnu-tool \
		  upper2lower

dist_pkgdata_SCRIPTS = fics \
		       get-autotools \
		       get-git \
		       get-gnu-tool \
		       makecscope \
		       mini \
		       nixify \
		       pattmv \
		       space2hyphen \
		       weather

if WITH_HADOOP_DAEMON_VERSION
dist_pkgdata_SCRIPTS += mapred-restart
endif WITH_HADOOP_DAEMON_VERSION

scripts = $(pkgdata_SCRIPTS) \
	  $(dist_pkgdata_SCRIPTS) 

DISTCLEANFILES = $(pkgdata_DATA) \
		 $(pkgdata_SCRIPTS)

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
