# Makefile.am

bashrcdir = $(pkgdatadir)/bashrc.d

# bashrc_DATA = dircolors.sh

# CLEANFILES = $(bashrc_DATA)

# EXTRA_DIST = dircolors.sh.in

# edit = sed -e 's:@pkgdatadir[@]:$(pkgdatadir):g'

# dircolors.sh: dircolors.sh.in Makefile
# $(edit) < $(srcdir)/dircolors.sh.in > dircolors.sh

dist_bashrc_DATA = bash.sh \
		   ctags.sh \
		   files.sh \
		   functions.sh \
		   java.sh \
		   ls.sh \
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
bashrc_DATA = 0-multi-bash-hack.sh
endif
