# Makefile.am

vimdir = $(homedir)/.vim
vimplugindir = $(vimdir)/plugin
vimftdetectdir = $(vimdir)/ftdetect
vimindentdir = $(vimdir)/indent
vimsyntaxdir = $(vimdir)/syntax

vimrc = .vimrc
customvim = custom.vim

home_DATA = $(vimrc) \
	    .gvimrc

dist_vimdata_DATA = $(customvim)

dist_vimplugin_DATA = greputil.vim \
		      putinclude.vim \
		      touch-object-file.vim \
		      yankinclude.vim

dist_vimftdetect_DATA = scala-ftdetect.vim
dist_vimindent_DATA = scala-indent.vim
dist_vimsyntax_DATA = scala-syntax.vim

CLEANFILES = $(home_DATA)

EXTRA_DIST = gvimrc.linux

edit = $(SED) -e 's:@vimdatadir[@]:$(vimdatadir):g'

$(vimrc): @VIMRC_EXAMPLE@ Makefile
	$(AM_V_GEN)cp $< $@ && \
	  echo -e "\nsource $(vimdatadir)/$(customvim)" >> $@
