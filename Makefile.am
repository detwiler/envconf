# Makefile.am

SUBDIRS = data

gvg_version = $(top_srcdir)/.version
pkg_name = $(top_srcdir)/.package-name
pkg_release = $(PACKAGE)-release
cmake = cmake
gnulib_tool = gnulib-tool
vc_list_files = vc-list-files
gnulib_scripts = $(gnulib_tool) \
		 $(vc_list_files)
gnupgdir = $(homedir)/.gnupg
gpg_agent_conf = $(gnupgdir)/gpg-agent.conf
install_data_targets =
uninstall_targets =

ACLOCAL_AMFLAGS = -I m4 -I .quickhatch/m4

BUILT_SOURCES = $(gvg_version) \
		$(pkg_name)

toolbox_DATA = $(pkg_release)

CLEANFILES = $(gvg_version) \
	     $(pkg_name) \
	     $(pkg_release)

EXTRA_DIST = $(gvg_version) \
	     m4/gnulib-cache.m4 \
	     $(pkg_name) \
	     README.md

AM_DISTCHECK_CONFIGURE_FLAGS = HOME=$(top_distdir)

if !ENABLE_AWS_CLI
AM_DISTCHECK_CONFIGURE_FLAGS += --disable-aws-cli
endif

if !ENABLE_CONAN
AM_DISTCHECK_CONFIGURE_FLAGS += --disable-conan
endif

if !ENABLE_VIM_CMAKE
AM_DISTCHECK_CONFIGURE_FLAGS += --disable-vim-cmake
endif

AM_DISTCHECK_CONFIGURE_FLAGS += --disable-vim-plug-install

$(gvg_version):
	$(AM_V_GEN)echo $(VERSION) > $@-t && mv $@-t $@

$(pkg_name):
	$(AM_V_GEN)echo $(PACKAGE_NAME) > $@-t && mv $@-t $@

$(pkg_release): $(gvg_version)
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

$(cmake): mk-bindir
	$(AM_V_GEN)cd $(DESTDIR)$(bindir) && \
	  test -h $@ || $(LN_S) $(CMAKE) $@

$(gnulib_tool): mk-bindir
	$(AM_V_GEN)cd $(DESTDIR)$(bindir) && \
	  test -h $@ || $(LN_S) $(GNULIB_REFDIR)/$@ $@

$(vc_list_files): mk-bindir
	$(AM_V_GEN)cd $(DESTDIR)$(bindir) && \
	  test -h $@ || $(LN_S) $(GNULIB_REFDIR)/build-aux/$@ $@

.PHONY: rm-cmake
rm-cmake:
	$(AM_V_GEN)cd $(DESTDIR)$(bindir) && \
	  rm -f $(cmake)

.PHONY: rm-gnulib-scripts
rm-gnulib-scripts:
	$(AM_V_GEN)cd $(DESTDIR)$(bindir) && \
	  rm -f $(gnulib_scripts)

if HAVE_GNULIB_REFDIR
install_data_targets += $(gnulib_scripts)
uninstall_targets += rm-gnulib-scripts
endif

if HAVE_CMAKE3
install_data_targets += $(cmake)
uninstall_targets += rm-cmake
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

dist-hook: gen-ChangeLog gen-tarball-version
