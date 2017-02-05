# Makefile.am

SUBDIRS = bashrc.d \
	  profile.d

bash_profile_h = .bash_profile
bashrc_h = .bashrc
bashrc = bashrc
profile = profile

home_DATA = $(bash_profile_h) \
	    $(bashrc_h)

pkgconf_DATA = $(bashrc) \
	       functions \
	       global-bash \
	       $(profile)

CLEANFILES = $(home_DATA) \
	     $(pkgconf_DATA)

EXTRA_DIST = $(bash_profile_h).in \
	     $(bashrc_h).in \
	     $(bashrc).in \
	     $(profile).in

edit = $(SED) \
       -e 's:@homedir[@]:$(homedir):g' \
       -e 's:@bindir[@]:$(bindir):g' \
       -e 's:@sbindir[@]:$(sbindir):g' \
       -e 's:@pkgconfdir[@]:$(pkgconfdir):g' \
       -e 's:@bashrcdir[@]:$(bashrcdir):g' \
       -e 's:@profiledir[@]:$(profiledir):g'

$(bash_profile_h): $(bash_profile_h).in Makefile
	$(AM_V_GEN)$(edit) < $< > $@

$(bashrc_h): $(bashrc_h).in Makefile
	$(AM_V_GEN)$(edit) < $< > $@

$(bashrc): $(bashrc).in Makefile
	$(AM_V_GEN)$(edit) < $< > $@

$(profile): $(profile).in Makefile
	$(AM_V_GEN)$(edit) < $< > $@

install-data-local:
	$(AM_V_GEN)test ! -e $(homedir)/$(bash_profile_h).orig && \
	  test -e $(homedir)/$(bash_profile_h) && \
	  cp $(homedir)/$(bash_profile_h) $(homedir)/$(bash_profile_h).orig || \
	  true
	$(AM_V_GEN)test ! -e $(homedir)/$(bashrc_h).orig && \
	  test -e $(homedir)/$(bashrc_h) && \
	  cp $(homedir)/$(bashrc_h) $(homedir)/$(bashrc_h).orig || true

uninstall-hook:
	$(AM_V_GEN)test -e $(homedir)/$(bash_profile_h).orig && \
	  test ! -e $(homedir)/$(bash_profile_h) && \
	  mv $(homedir)/$(bash_profile_h).orig $(homedir)/$(bash_profile_h) || \
	  true
	$(AM_V_GEN)test -e $(homedir)/$(bashrc_h).orig && \
	  test ! -e $(homedir)/$(bashrc_h) && \
	  mv $(homedir)/$(bashrc_h).orig $(homedir)/$(bashrc_h) || true
