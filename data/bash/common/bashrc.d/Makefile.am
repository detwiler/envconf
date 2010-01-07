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
		   set.sh \
		   shopt.sh \
		   svn.sh \
		   vim.sh

if SSH_HOSTS
dist_bashrc_DATA += ssh-home.sh \
		    ssh-umbc.sh \
		    ssh-umd-cs.sh \
		    ssh-umiacs.sh

if UMIACS_HOST
dist_bashrc_DATA += ssh-umiacs-local.sh
endif UMIACS_HOST

endif SSH_HOSTS

if MULTI_BASH
bashrc_DATA += 0-multi-bash-hack.sh
endif

if HCGREP_COLOR
bashrc_DATA += grep.sh
endif

EXTRA_DIST = ls.aliases \
	     ls-color.aliases
