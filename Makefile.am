# Makefile.am

SUBDIRS = data

gvg_version = .version
pkg_release = $(PACKAGE)-release
gnulib_tool = gnulib-tool
vc_list_files = vc-list-files
gnulib_scripts = $(gnulib_tool) \
		 $(vc_list_files)
gnupgdir = $(homedir)/.gnupg
gpg_agent_conf = $(gnupgdir)/gpg-agent.conf
install_data_targets =
uninstall_targets =

pkgconf_DATA = $(pkg_release)

ACLOCAL_AMFLAGS = -I m4 -I .qh-at/m4

BUILT_SOURCES = $(gvg_version)

DISTCLEANFILES = $(gvg_version) \
		 $(pkg_release)

EXTRA_DIST = $(gvg_version) \
	     m4/gnulib-cache.m4

DISTCHECK_CONFIGURE_FLAGS = HOME=$(top_distdir)

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

.PHONY: mk-bindir
mk-bindir:
	$(AM_V_GEN)test -e $(DESTDIR)$(bindir) \
	  || $(MKDIR_P) $(DESTDIR)$(bindir)

$(gnulib_tool): mk-bindir
	$(AM_V_GEN)cd $(DESTDIR)$(bindir) && \
	  test -h $@ || $(LN_S) $(GNULIB_SRCDIR)/$@

$(vc_list_files): mk-bindir
	$(AM_V_GEN)cd $(DESTDIR)$(bindir) && \
	  test -h $@ || $(LN_S) $(GNULIB_SRCDIR)/build-aux/$@

.PHONY: rm-gnulib-scripts
rm-gnulib-scripts:
	$(AM_V_GEN)cd $(DESTDIR)$(bindir) && \
	  rm -f $(gnulib_scripts)

if HAVE_GNULIB_SRCDIR
install_data_targets += $(gnulib_scripts)
uninstall_targets += rm-gnulib-scripts
endif

.PHONY: mk-gnupgdir
mk-gnupgdir:
	$(AM_V_GEN)test -e $(DESTDIR)$(gnupgdir) || \
	  $(MKDIR_P) -m 0700 $(DESTDIR)$(gnupgdir)

.PHONY: gpg-agent-pinentry-mac
gpg-agent-pinentry-mac: mk-gnupgdir
	$(AM_V_GEN)$(GREP) '^pinentry-program' $(DESTDIR)$(gpg_agent_conf) &>/dev/null || \
	  printf 'pinentry-program %s\n' $(PINENTRY_MAC) >>$(DESTDIR)$(gpg_agent_conf)

.PHONY: rm-gpg-agent-pinentry-mac
rm-gpg-agent-pinentry-mac: mk-gnupgdir
	$(AM_V_GEN)$(GREP) -v '^pinentry-program $(PINENTRY_MAC)' $(DESTDIR)$(gpg_agent_conf) &>/dev/null || \
	  rm $(DESTDIR)$(gpg_agent_conf)

if HAVE_GPG_AGENT
if HAVE_PINENTRY_MAC
install_data_targets += gpg-agent-pinentry-mac
uninstall_targets += rm-gpg-agent-pinentry-mac
endif
endif

install-data-hook: $(install_data_targets)

uninstall-hook: $(uninstall_targets)

dist-hook: gen-ChangeLog
	$(AM_V_GEN)echo $(VERSION) > $(distdir)/.tarball-version
