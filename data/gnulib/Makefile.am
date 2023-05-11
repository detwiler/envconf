# Makefile.am

include $(top_srcdir)/rules.mk

SUBDIRS = profile.d

# data/script variables
gnulib_tool = gnulib-tool
vc_list_files = vc-list-files
gnulib_scripts = $(gnulib_tool) \
		 $(vc_list_files)

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

install-data-hook: $(gnulib_scripts)

uninstall-hook: rm-gnulib-scripts
