# Makefile.am

bashrc_DATA = ls.sh \
	      ps1.sh

dist_bashrc_DATA = files.sh \
		   functions.sh \
		   minicom.sh \
		   misc.sh \
		   set.sh \
		   shopt.sh

if MULTI_BASH
bashrc_DATA += 0-multi-bash-hack.sh
endif

if HAVE_EXUBERANT_CTAGS
bashrc_DATA += ctags-alias.sh
dist_bashrc_DATA += ctags.sh
endif

if MULTI_SVN
bashrc_DATA += svn.sh
endif

if MULTI_VIM
bashrc_DATA += vim.sh
endif

if HAVE_GREP_COLOR
bashrc_DATA += grep.sh
endif

if PROXY_CHECK
if HAVE_WGET
bashrc_DATA += proxy.sh
endif HAVE_WGET
endif PROXY_CHECK

if SSH_HOSTS
dist_bashrc_DATA += ssh-home.sh \
		    ssh-umbc.sh \
		    ssh-umd-cs.sh \
		    ssh-umiacs.sh

if UMIACS_HOST
dist_bashrc_DATA += ssh-umiacs-local.sh
endif UMIACS_HOST

endif SSH_HOSTS

if HAVE_VIM
dist_bashrc_DATA += vi.sh
endif HAVE_VIM

if HAVE_BASH_COMP
dist_bashrc_DATA += bash-completion.sh
endif HAVE_BASH_COMP

DISTCLEANFILES = $(bashrc_DATA)

EXTRA_DIST = ls.aliases \
	     ls-color.aliases
