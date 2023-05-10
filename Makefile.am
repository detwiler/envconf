# Makefile.am

SUBDIRS = data

gvg_version = $(top_srcdir)/.version
pkg_name = $(top_srcdir)/.package-name
pkg_release = $(PACKAGE)-release

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

dist-hook: gen-ChangeLog gen-tarball-version
