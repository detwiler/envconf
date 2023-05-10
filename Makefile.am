# Makefile.am

SUBDIRS = data

gvg_version = $(top_srcdir)/.version
pkg_name = $(top_srcdir)/.package-name
pkg_release = $(PACKAGE)-release
gnulib_tool = gnulib-tool
vc_list_files = vc-list-files
gnulib_scripts = $(gnulib_tool) \
		 $(vc_list_files)
install_data_targets =
uninstall_targets =

ACLOCAL_AMFLAGS = -I m4 -I .quickhatch/m4

BUILT_SOURCES = $(gvg_version) \
		$(pkg_name)

dist_pkgconf_DATA = $(pkg_release)

CLEANFILES = $(gvg_version) \
	     $(pkg_name) \
	     $(pkg_release)

EXTRA_DIST = $(gvg_version) \
	     m4/gnulib-cache.m4 \
	     $(pkg_name) \
	     README.md

AM_DISTCHECK_CONFIGURE_FLAGS = HOME=$(top_distdir)

$(gvg_version):
	$(AM_V_GEN)echo $(VERSION) > $@-t && mv $@-t $@

$(pkg_name):
	$(AM_V_GEN)echo $(PACKAGE_NAME) > $@-t && mv $@-t $@

$(pkg_release): Makefile
	$(AM_V_GEN)echo "$(PACKAGE) release $(VERSION)" > $@-t && mv $@-t $@

.PHONY: gen-ChangeLog
gen-ChangeLog:
	$(AM_V_GEN)if test -d .git; then				\
	  $(top_srcdir)/build-aux/gitlog-to-changelog > $(distdir)/cl-t;\
	  rm -f $(distdir)/ChangeLog;					\
	  mv $(distdir)/cl-t $(distdir)/ChangeLog;			\
	fi

.PHONY: gen-tarball-version
gen-tarball-version:
	$(AM_V_GEN)echo $(VERSION) > $(distdir)/.tarball-version

.PHONY: mk-bindir
mk-bindir:
	$(AM_V_GEN)test -e $(DESTDIR)$(bindir) \
	  || $(MKDIR_P) $(DESTDIR)$(bindir)

$(gnulib_tool): mk-bindir
	$(AM_V_GEN)cd $(DESTDIR)$(bindir) && \
	  test -h $@ || $(LN_S) $(GNULIB_REFDIR)/$@ $@

$(vc_list_files): mk-bindir
	$(AM_V_GEN)cd $(DESTDIR)$(bindir) && \
	  test -h $@ || $(LN_S) $(GNULIB_REFDIR)/build-aux/$@ $@

.PHONY: rm-gnulib-scripts
rm-gnulib-scripts:
	$(AM_V_GEN)cd $(DESTDIR)$(bindir) && \
	  rm -f $(gnulib_scripts)

if HAVE_GNULIB_REFDIR
install_data_targets += $(gnulib_scripts)
uninstall_targets += rm-gnulib-scripts
endif

install-data-hook: $(install_data_targets)

uninstall-hook: $(uninstall_targets)

dist-hook: gen-ChangeLog gen-tarball-version
