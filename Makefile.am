# Makefile.am

SUBDIRS = data

gvg_version = .version
pkg_release = $(PACKAGE)-release
gnulib_tool = gnulib-tool
vc_list_files = vc-list-files
gnulib_scripts = $(gnulib_tool) \
		 $(vc_list_files)

pkgconf_DATA = $(pkg_release)

ACLOCAL_AMFLAGS = -I m4 -I .qh-at/m4

BUILT_SOURCES = $(gvg_version)

DISTCLEANFILES = $(gvg_version) \
		 $(pkg_release)

EXTRA_DIST = $(gvg_version) \
	     m4/gnulib-cache.m4

DISTCHECK_CONFIGURE_FLAGS = HOME=$(top_distdir) \
			    --enable-local-bash-completion=$enable_local_bash_comp

$(gvg_version): Makefile
	$(AM_V_GEN)echo $(VERSION) > $@-t && mv $@-t $@

$(pkg_release): $(gvg_version)
	$(AM_V_GEN)echo "$(PACKAGE) release $(VERSION)" > $@-t && mv $@-t $@

.PHONY: gen-ChangeLog
gen-ChangeLog:
	$(AM_V_GEN)if test -d .git; then				\
	  $(top_srcdir)/build-aux/gitlog-to-changelog > $(distdir)/cl-t;\
	  rm -f $(distdir)/ChangeLog;					\
	  mv $(distdir)/cl-t $(distdir)/ChangeLog;			\
	fi

mk-bindir:
	$(AM_V_GEN)test -e $(DESTDIR)$(bindir) || mkdir -p $(DESTDIR)$(bindir)

$(gnulib_tool): mk-bindir
	$(AM_V_GEN)cd $(DESTDIR)$(bindir) && \
	  test -h $@ || $(LN_S) $(GNULIB_SRCDIR)/$@

$(vc_list_files): mk-bindir
	$(AM_V_GEN)cd $(DESTDIR)$(bindir) && \
	  test -h $@ || $(LN_S) $(GNULIB_SRCDIR)/build-aux/$@

if HAVE_GNULIB_SRCDIR
install-data-hook: $(gnulib_scripts)
uninstall-hook:
	$(AM_V_GEN)cd $(DESTDIR)$(bindir) && \
	  rm -f $(gnulib_scripts)
endif

dist-hook: gen-ChangeLog
	$(AM_V_GEN)echo $(VERSION) > $(distdir)/.tarball-version
