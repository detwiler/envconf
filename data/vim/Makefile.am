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

grep = $(GREP_COLOR) --line-number --max-count=1 --regexp=nocompatible
cut = cut --delimiter=':' --fields=1

$(vimrc): @VIMRC_EXAMPLE@ Makefile
	$(AM_V_GEN) \
	  ( \
	    head --lines=$$($(grep) $< | $(cut)) $<; \
	    echo -e '\nsource $(vimdatadir)/$(pathogenvim)'; \
	    tail --lines=+$$(echo "$$($(grep) $< | $(cut)) + 1" | bc -l) $<; \
	    echo -e '\nsource $(vimdatadir)/$(customvim)' \
	  ) >$@-t && mv $@-t $@
