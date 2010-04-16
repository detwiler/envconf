# Makefile.am

vimdir = $(homedir)/.vim
vimplugindir = $(vimdir)/plugin
vimftdetectdir = $(vimdir)/ftdetect
vimindentdir = $(vimdir)/indent
vimsyntaxdir = $(vimdir)/syntax

home_DATA = .vimrc \
	    .gvimrc

dist_vimdata_DATA = custom.vim

dist_vimplugin_DATA = greputil.vim \
		      putinclude.vim \
		      touch-object-file.vim \
		      yankinclude.vim

dist_vimftdetect_DATA = scala-ftdetect.vim
dist_vimindent_DATA = scala-indent.vim
dist_vimsyntax_DATA = scala-syntax.vim

CLEANFILES = $(home_DATA)

EXTRA_DIST = .vimrc.in \
	     gvimrc.linux

edit = $(SED) -e 's:@vimdatadir[@]:$(vimdatadir):g'

.vimrc: .vimrc.in Makefile
	$(AM_V_GEN)$(edit) < $(srcdir)/.vimrc.in > .vimrc
