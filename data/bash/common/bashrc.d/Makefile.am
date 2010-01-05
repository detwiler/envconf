# Makefile.am

bashrcdir = $(pkgdatadir)/bashrc.d

bashrc_DATA = ls.sh \
	      ps1.sh

# CLEANFILES = $(bashrc_DATA)

# edit = sed -e 's:@pkgdatadir[@]:$(pkgdatadir):g'

# dircolors.sh: dircolors.sh.in Makefile
# $(edit) < $(srcdir)/dircolors.sh.in > dircolors.sh

dist_bashrc_DATA = ctags.sh \
		   files.sh \
		   functions.sh \
		   minicom.sh \
		   misc.sh \
		   mount.sh \
		   set.sh \
		   shopt.sh \
		   ssh-digidata.sh \
		   ssh-home.sh \
		   ssh-umbc.sh \
		   ssh-umd-cs.sh \
		   ssh-umd.sh \
		   ssh-umiacs-local.sh \
		   ssh-umiacs.sh \
		   svn.sh \
		   vim.sh \
		   yum.sh

if MULTI_BASH
bashrc_DATA += 0-multi-bash-hack.sh
endif

EXTRA_DIST = ls.aliases \
	     ls-color.aliases
