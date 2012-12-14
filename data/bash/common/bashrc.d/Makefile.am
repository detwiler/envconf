# Makefile.am

bashrc_DATA = aws-functions.sh \
	      ls.sh \
	      ps1.sh

dist_bashrc_DATA = files.sh \
		   functions.sh \
		   minicom.sh \
		   misc.sh \
		   set.sh \
		   shopt.sh

if HAVE_EXUBERANT_CTAGS
bashrc_DATA += ctags-alias.sh
dist_bashrc_DATA += ctags.sh
endif

if HAVE_GPG2
bashrc_DATA += gpg2.sh
endif

if HAVE_GREP_COLOR
bashrc_DATA += grep.sh
endif

if HAVE_S3CMD
dist_bashrc_DATA += s3cmd-alias.sh
endif

if WITH_SVN_ALIAS
bashrc_DATA += svn.sh
endif

if WITH_VIM_ALIAS
bashrc_DATA += vim.sh
endif

if HAVE_VIM
dist_bashrc_DATA += vi.sh
endif HAVE_VIM

if WITH_AWS_ACCOUNT_DIR
bashrc_DATA += aws-aliases.sh
endif

bash_completion = bash-completion.sh

if ENABLE_LOCAL_BASH_COMP
bashrc_DATA += $(bash_completion)
endif ENABLE_LOCAL_BASH_COMP

edit = $(SED) \
       -e 's:@sysconfdir[@]:$(sysconfdir):g'

$(bash_completion): $(bash_completion).in Makefile
	$(AM_V_GEN)$(edit) < $< > $@

CLEANFILES = $(bash_completion)

DISTCLEANFILES = $(bashrc_DATA)

EXTRA_DIST = $(bash_completion).in \
	     ls.aliases \
	     ls-color.aliases
