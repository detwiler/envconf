# Makefile.am

bashrcdir = $(pkgdatadir)/bashrc.d

bashrc_DATA = ls.sh \
	      ps1.sh

if MULTI_BASH
bashrc_DATA += 0-multi-bash-hack.sh
endif

if MULTI_SVN
bashrc_DATA += svn.sh
endif

if MULTI_VIM
bashrc_DATA += vim.sh
endif

if HCGREP_COLOR
bashrc_DATA += grep.sh
endif

dist_bashrc_DATA = ctags.sh \
		   files.sh \
		   functions.sh \
		   minicom.sh \
		   misc.sh \
		   set.sh \
		   shopt.sh

if SSH_HOSTS
dist_bashrc_DATA += ssh-home.sh \
		    ssh-umbc.sh \
		    ssh-umd-cs.sh \
		    ssh-umiacs.sh

if UMIACS_HOST
dist_bashrc_DATA += ssh-umiacs-local.sh
endif UMIACS_HOST

endif SSH_HOSTS

if VI_ALIAS
dist_bashrc_DATA += vi.sh
endif VI_ALIAS

EXTRA_DIST = ls.aliases \
	     ls-color.aliases
