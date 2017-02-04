# Makefile.am

vimdir = $(homedir)/.vim
vimplugindir = $(vimdir)/plugin

vimrc = .vimrc
gvimrc = .gvimrc
customvim = custom.vim
pathogenvim = pathogen.vim

home_DATA = $(vimrc) \
	    $(gvimrc)

dist_vimdata_DATA = $(customvim) \
		    $(pathogenvim)

dist_vimplugin_DATA = greputil.vim \
		      putinclude.vim \
		      touch-object-file.vim \
		      yankinclude.vim

CLEANFILES = $(vimrc)

DISTCLEANFILES = $(gvimrc)

$(vimrc): @VIMRC_EXAMPLE@ Makefile
	$(AM_V_GEN) \
	  ( \
	    cat $<; \
	    printf '\n'; \
	    printf 'source %s/%s\n' $(vimdatadir) $(pathogenvim); \
	    printf 'source %s/%s\n' $(vimdatadir) $(customvim); \
	  ) >$@-t && mv $@-t $@
