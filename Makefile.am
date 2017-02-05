# Makefile.am

SUBDIRS = data

pkgconf_DATA = $(PACKAGE)-release

CLEANFILES = $(pkgconf_DATA)

.PHONY: $(PACKAGE)-release
$(PACKAGE)-release:
	$(AM_V_GEN)echo "$(PACKAGE) release $(VERSION)" > $@-t && mv $@-t $@

BUILT_SOURCES = $(top_srcdir)/.version

$(top_srcdir)/.version:
	$(AM_V_GEN)echo $(VERSION) > $@-t && mv $@-t $@

dist-hook: gen-ChangeLog
	$(AM_V_GEN)echo $(VERSION) > $(distdir)/.tarball-version

.PHONY: gen-ChangeLog
gen-ChangeLog:
	$(AM_V_GEN)if test -d .git; then				\
	  $(top_srcdir)/build-aux/gitlog-to-changelog > $(distdir)/cl-t;\
	  rm -f $(distdir)/ChangeLog;					\
	  mv $(distdir)/cl-t $(distdir)/ChangeLog;			\
	fi

EXTRA_DIST = $(top_srcdir)/.version

ACLOCAL_AMFLAGS = -I m4

DISTCHECK_CONFIGURE_FLAGS = HOME=$(top_distdir) \
			    --with-bash-alias=@BASH_ALIAS@ \
			    --with-subversion-alias=@SVN_ALIAS@ \
			    --with-vim-alias=@VIM_ALIAS@ \
			    --with-vimrc-example=@VIMRC_EXAMPLE@

if WITH_GNULIB_SRCDIR
DISTCHECK_CONFIGURE_FLAGS += --with-gnulib-srcdir=@GNULIB_SRCDIR@
endif # WITH_GNULIB_SRCDIR

mk-bindir:
	$(AM_V_GEN)test -e $(DESTDIR)$(bindir) || mkdir -p $(DESTDIR)$(bindir)

gnulib_tool = gnulib-tool

$(gnulib_tool): mk-bindir
	$(AM_V_GEN)cd $(DESTDIR)$(bindir) && \
	  test -e $@ || $(LN_S) $(GNULIB_SRCDIR)/$@

vc_list_files = vc-list-files

$(vc_list_files): mk-bindir
	$(AM_V_GEN)cd $(DESTDIR)$(bindir) && \
	  test -e $@ || $(LN_S) $(GNULIB_SRCDIR)/build-aux/$@

gnulib_scripts = $(gnulib_tool) \
		 $(vc_list_files)

if WITH_GNULIB_SRCDIR
install-data-hook: $(gnulib_scripts)
uninstall-hook:
	$(AM_V_GEN)cd $(DESTDIR)$(bindir) && \
	  rm -f $(gnulib_scripts)
endif
