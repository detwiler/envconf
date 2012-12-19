# Makefile.am

vimdir = $(homedir)/.vim
vimplugindir = $(vimdir)/plugin

vimrc = .vimrc
gvimrc = .gvimrc
customvim = custom.vim
pathogen = pathogen.vim

home_DATA = $(vimrc) \
	    $(gvimrc)

dist_vimdata_DATA = $(customvim)

dist_vimplugin_DATA = greputil.vim \
		      putinclude.vim \
		      touch-object-file.vim \
		      yankinclude.vim

EXTRA_DIST = $(pathogen)

CLEANFILES = $(vimrc)

DISTCLEANFILES = $(gvimrc) \
		 gvimrc.linux

grep = $(GREP_COLOR) --line-number --max-count=1 --regexp=nocompatible
cut = cut --delimiter=':' --fields=1

$(vimrc): @VIMRC_EXAMPLE@ $(pathogen) Makefile
	$(AM_V_GEN) \
	  ( \
	    head --lines=$$($(grep) $< | $(cut)) $<; \
	    cat $(srcdir)/$(pathogen); \
	    tail --lines=+$$(echo "$$($(grep) $< | $(cut)) + 1" | bc -l) $<; \
	    echo -e '\nsource $(vimdatadir)/$(customvim)' \
	  ) >$@-t && mv $@-t $@
