# Makefile.am

SUBDIRS = bashrc.d \
	  profile.d

home_DATA = .bash_profile \
	    .bashrc

pkgdata_DATA = bashrc \
	       functions \
	       profile

CLEANFILES = $(home_DATA) \
	     $(pkgdata_DATA)

EXTRA_DIST = .bash_profile.in \
	     .bashrc.in \
	     bashrc.in \
	     profile.in

edit = $(SED) \
       -e 's:@bindir[@]:$(bindir):g' \
       -e 's:@pkgdatadir[@]:$(pkgdatadir):g' \
       -e 's:@bashrcdir[@]:$(bashrcdir):g' \
       -e 's:@profiledir[@]:$(profiledir):g'

.bash_profile: .bash_profile.in Makefile
	$(AM_V_GEN)$(edit) < $(srcdir)/.bash_profile.in > .bash_profile

.bashrc: .bashrc.in Makefile
	$(AM_V_GEN)$(edit) < $(srcdir)/.bashrc.in > .bashrc

bashrc: bashrc.in Makefile
	$(AM_V_GEN)$(edit) < $(srcdir)/bashrc.in > bashrc

profile: profile.in Makefile
	$(AM_V_GEN)$(edit) < $(srcdir)/profile.in > profile

install-data-local:
	$(AM_V_GEN)test ! -e $(homedir)/.bash_profile.orig && \
	  test -e $(homedir)/.bash_profile && \
	  cp $(homedir)/.bash_profile $(homedir)/.bash_profile.orig || true
	$(AM_V_GEN)test ! -e $(homedir)/.bashrc.orig && \
	  test -e $(homedir)/.bashrc && \
	  cp $(homedir)/.bashrc $(homedir)/.bashrc.orig || true

uninstall-hook:
	$(AM_V_GEN)test -e $(homedir)/.bash_profile.orig && \
	  test ! -e $(homedir)/.bash_profile && \
	  mv $(homedir)/.bash_profile.orig $(homedir)/.bash_profile || true
	$(AM_V_GEN)test -e $(homedir)/.bashrc.orig && \
	  test ! -e $(homedir)/.bashrc && \
	  mv $(homedir)/.bashrc.orig $(homedir)/.bashrc || true
