# Makefile.am

SUBDIRS = data

bootstrap_funclib = bootstrap-funclib.sh
pkg_name = $(top_srcdir)/.package-name
pkg_release = $(PACKAGE)-release
version_stamp = $(top_srcdir)/.version
xdg_configure = xdg-configure

ACLOCAL_AMFLAGS = -I m4 -I .quickhatch/m4

BUILT_SOURCES = $(pkg_name) \
		$(version_stamp)

dist_bin_SCRIPTS = $(xdg_configure)

dist_pkgconf_DATA = $(pkg_release)

dist_pkgdata_DATA = $(bootstrap_funclib)

CLEANFILES = $(pkg_name) \
	     $(pkg_release)

EXTRA_DIST = m4/gnulib-cache.m4 \
	     $(pkg_name) \
	     README.md \
	     $(version_stamp)

AM_DISTCHECK_CONFIGURE_FLAGS = EC_HOME=$(top_distdir)

$(pkg_name):
	$(AM_V_GEN)echo $(PACKAGE_NAME) > $@-t && mv $@-t $@

$(pkg_release): $(version_stamp)
	$(AM_V_GEN)echo "$(PACKAGE) release $(VERSION)" > $@-t && mv $@-t $@

.PHONY: gen-ChangeLog
gen-ChangeLog:
	$(AM_V_GEN)if test -d .git; then				\
	  $(top_srcdir)/build-aux/gitlog-to-changelog > $(distdir)/cl-t;\
	  rm -f $(distdir)/ChangeLog;					\
	  mv $(distdir)/cl-t $(distdir)/ChangeLog;			\
	fi

.PHONY: dist-tarball-version
dist-tarball-version:
	$(AM_V_GEN)echo '$(VERSION)' > $(distdir)/.tarball-version

# sed command to build data/scripts
EDIT = -e 's:@PACKAGE_STRING[@]:$(PACKAGE_STRING):g' \
       -e 's:@pkgdatadir[@]:$(pkgdatadir):g'

install-xdg-configure-hook:
	$(AM_V_GEN)cd $(DESTDIR)$(bindir) && \
	  $(SED) --in-place $(EDIT) $(xdg_configure)

dist-hook: gen-ChangeLog dist-tarball-version

install-data-hook: install-xdg-configure-hook
