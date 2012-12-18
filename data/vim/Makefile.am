# Makefile.am

vimdir = $(homedir)/.vim
vimplugindir = $(vimdir)/plugin

vimrc = .vimrc
gvimrc = .gvimrc
customvim = custom.vim

home_DATA = $(vimrc) \
	    $(gvimrc)

dist_vimdata_DATA = $(customvim)

dist_vimplugin_DATA = greputil.vim \
		      putinclude.vim \
		      touch-object-file.vim \
		      yankinclude.vim

CLEANFILES = $(vimrc)

DISTCLEANFILES = $(gvimrc) \
		 gvimrc.linux

edit = $(SED) -e 's:@vimdatadir[@]:$(vimdatadir):g'

head_end = $(shell grep -n -m 1 nocompatible @VIMRC_EXAMPLE@ | cut -d ':' -f 1)

tail_start = $(shell echo '$(head_end) + 1' | bc -l)

$(vimrc): @VIMRC_EXAMPLE@ Makefile
	$(AM_V_GEN)grep -n -m 1 nocompatible $< | cut -d ':' -f 1 >$@-head && \
	  echo "$$(cat $@-head) + 1" | bc -l >y && \
	  head -n $$(cat $@-head) $< >$@ && \
	  cat $(srcdir)/pathogen.vim >>$@ && \
	  tail -n +$$(cat $@-tail) >>$@ && \
	  echo -e "\nsource $(vimdatadir)/$(customvim)" >>$@ && \
	  rm $@-head $@-tail
