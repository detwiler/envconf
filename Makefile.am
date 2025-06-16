# Makefile.am

SUBDIRS = data

pkg_name = $(top_srcdir)/.package-name
pkg_release = $(PACKAGE)-release
version_stamp = $(top_srcdir)/.version

ACLOCAL_AMFLAGS = -I m4 -I .quickhatch/m4

BUILT_SOURCES = $(pkg_name) \
		$(version_stamp)

dist_pkgconf_DATA = $(pkg_release)

CLEANFILES = $(pkg_name) \
	     $(pkg_release)

EXTRA_DIST = m4/gnulib-cache.m4 \
	     $(pkg_name) \
	     README.md \
	     $(version_stamp) \
	     xdg-configure

AM_DISTCHECK_CONFIGURE_FLAGS = HOME=$(top_distdir)

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

dist-hook: gen-ChangeLog dist-tarball-version
