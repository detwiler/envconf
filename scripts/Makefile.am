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
dist_pkgdata_SCRIPTS += update-hadoop-cluster
endif WITH_HADOOP_DAEMON_VERSION

scripts = $(pkgdata_SCRIPTS) \
	  $(dist_pkgdata_SCRIPTS) 

DISTCLEANFILES = $(pkgdata_DATA) \
		 $(pkgdata_SCRIPTS)

EXTRA_DIST = upper2lower.cygwin \
	     upper2lower.linux

mk-bindir:
	$(AM_V_GEN)test -e $(DESTDIR)$(bindir) || mkdir -p $(DESTDIR)$(bindir)

mk-script-links: mk-bindir
	$(AM_V_GEN)cd $(DESTDIR)$(bindir) && \
	  for s in $(scripts); do \
	    test -e $$s || $(LN_S) $(DESTDIR)$(pkgdatadir)/$$s; \
	  done

gnulib_tool = gnulib-tool

$(gnulib_tool): mk-bindir
	$(AM_V_GEN)cd $(DESTDIR)$(bindir) && \
	  test -e $@ || $(LN_S) $(GNULIB_SRCDIR)/$@

if WITH_GNULIB_SRCDIR
install-data-hook: $(gnulib_tool) mk-script-links
uninstall_files = $(scripts) $(gnulib_tool)
else
install-data-hook: mk-script-links
uninstall_files = $(scripts)
endif

uninstall-hook:
	$(AM_V_GEN)cd $(DESTDIR)$(bindir) && \
	  rm -f $(uninstall_files)
