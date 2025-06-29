#                                               -*- Autoconf -*-
# Process this file with autoconf to produce a configure script.

AC_INIT([envconf], [package], [mike@detwiler.io])

AC_PREREQ([2.64])
AC_CONFIG_AUX_DIR([build-aux])
AC_REQUIRE_AUX_FILE([git-version-gen])
AC_CONFIG_MACRO_DIRS([m4])
AC_CONFIG_SRCDIR([data/autoconf/config.site.in])
VERSION_NUMBER=`cd $srcdir && build-aux/git-version-gen .tarball-version`
gl_INIT_PACKAGE_VERSION([$VERSION_NUMBER])
AM_INIT_AUTOMAKE([-Wall -Wno-portability -Werror tar-pax foreign])
AM_SILENT_RULES([yes])

# Installation directories
QH_VAR_ENSURE([EC_HOME],
              [User HOME directory],
              [$HOME])

AC_SUBST([homedir], [$EC_HOME])
AC_SUBST([pkgconfdir], ["\$(sysconfdir)/\$(PACKAGE_NAME)"])
AC_SUBST([bashconfdir], ["\$(sysconfdir)/bash"])
AC_SUBST([bashrcdir], ["\$(bashconfdir)/bashrc.d"])
AC_SUBST([profiledir], ["\$(bashconfdir)/profile.d"])
AC_SUBST([readlineconfdir], ["\$(sysconfdir)/readline"])
AC_SUBST([rubyconfdir], ["\$(sysconfdir)"])
AC_SUBST([bundleconfdir], ["\$(sysconfdir)/bundle"])
AC_SUBST([gitconfdir], ["\$(sysconfdir)/git"])
AC_SUBST([vimconfdir], ["\$(sysconfdir)/vim"])

# Runtime environment variables
AC_SUBST([XDG_CONFIG_HOME], ["\$(sysconfdir)"])
AC_SUBST([XDG_CACHE_HOME], ["\$(sharedstatedir)"])
AC_SUBST([XDG_DATA_HOME], ["\$(datadir)"])
AC_SUBST([XDG_STATE_HOME], ["\$(localstatedir)"])

QH_VAR_ENSURE([WORKDIR],
              [path to local work directory],
              [$EC_HOME/work])

QH_VAR_ENSURE([REFDIR],
              [path to local directory with reference repositories],
              [$WORKDIR/ref])

QH_VAR_ENSURE([TOOLBOX_ENV_FILE],
	      [path to toolbox environment file],
              [/run/.toolboxenv])

QH_VAR_ENSURE([CONTAINER_ENV_FILE],
	      [path to container environment file],
              [/run/.containerenv])

### Checks for programs. ###

AC_PROG_CC
AC_PROG_INSTALL
AC_PROG_LN_S
AC_PROG_MKDIR_P
AC_PROG_SED

# need to check for grep early
AC_ARG_VAR([GREP], [path to grep])
AC_PROG_GREP
AS_IF([test "x$GREP" = xno],
      [AC_MSG_ERROR([could not find grep])])

## aws-cli ##

AC_ARG_VAR([AWS_CLI], [aws-cli program])
AC_CHECK_PROGS([AWS_CLI], [aws])
AM_CONDITIONAL([HAVE_AWS_CLI], [test "x$AWS_CLI" != x])
AM_COND_IF([HAVE_AWS_CLI],
           [QH_VAR_ENSURE([AWS_CONFIG_DIR],
                          [path to aws-cli configuration directory],
			  ["\$XDG_CONFIG_HOME/aws"])
            QH_VAR_ENSURE([AWS_CONFIG_FILE],
                          [path to aws-cli config file],
                          [$AWS_CONFIG_DIR/config])
            QH_VAR_ENSURE([AWS_SHARED_CREDENTIALS_FILE],
                          [path to aws-cli shared credentials file],
                          [$AWS_CONFIG_DIR/credentials])
            AC_CONFIG_FILES([data/aws-cli/bashrc.d/aws-functions.sh])])

## bash ##

# customization of PS1 color
EC_PS1_DEFAULT
QH_VAR_ENSURE([PS1_USER_COLOR], [bash prompt username color],    [$_ec_ps1_user_default])
QH_VAR_ENSURE([PS1_HOST_COLOR], [bash prompt hostname color],    [$_ec_ps1_host_default])
QH_VAR_ENSURE([PS1_GIT_COLOR],  [bash prompt git status color],  [$_ec_ps1_git_default])
QH_VAR_ENSURE([PS1_PWD_COLOR],  [bash prompt pwd color],         [0])
AM_COND_IF([HAVE_AWS_CLI],
           [QH_VAR_ENSURE([PS1_AWS_COLOR],
                          [bash prompt aws profile color],
                          [$_ec_ps1_aws_default])
            AWS_PROFILE_FUNC='__aws_profile'],
           [AWS_PROFILE_FUNC='true'])
AC_SUBST([AWS_PROFILE_FUNC])

## clang ##

AC_ARG_VAR([CLANG], [clang program])
AC_CHECK_PROGS([CLANG], [clang clang-10], [no])
AM_CONDITIONAL([HAVE_CLANG], [test "x$CLANG" != xno])

## cmake ##

AC_ARG_VAR([CMAKE], [cmake program])
AC_CHECK_PROGS([CMAKE], [cmake cmake3], [no])
AM_CONDITIONAL([HAVE_CMAKE], [test "x$CMAKE" != xno])
AM_CONDITIONAL([HAVE_CMAKE3], [test "x$CMAKE" = xcmake3])
AM_COND_IF([HAVE_CMAKE3], [AC_CONFIG_FILES([data/cmake/bashrc.d/cmake3.sh])])

## conan ##

AC_ARG_VAR([CONAN], [conan program])
AC_CHECK_PROGS([CONAN], [conan], [no])
AM_CONDITIONAL([HAVE_CONAN], [test "x$CONAN" != xno])

# conan needs to know about python, python-pip, clang, and gcc
# python #
AM_PATH_PYTHON([3.0], [],
	       [AC_MSG_WARN([could not find python version >= 3.0])])
AC_ARG_VAR([PIP3], [pip3 program])
AC_CHECK_PROGS([PIP3], [pip3], [no])
AM_CONDITIONAL([HAVE_PIP3], [test "x$PIP3" != xno])

# gcc #
# GCC set by AC_PROG_CC
AM_CONDITIONAL([HAVE_GCC], [test "x$GCC" = xyes])

AM_COND_IF([HAVE_CONAN],
	   [QH_VAR_ENSURE([CONAN_USER_HOME],
			  [Conan user configuration directory],
			  ["\$(XDG_CONFIG_HOME)/conan"])
	    QH_VAR_ENSURE([CONAN_USERNAME],
			  [User name required by conan-package-tools],
			  [$USER])])
AM_COND_IF([HAVE_CONAN],
	   [AM_COND_IF([HAVE_PIP3],
	               [QH_VAR_ENSURE([CONAN_PIP_COMMAND],
                                      [path to pip3],
                                      [$PIP3])])])
AM_COND_IF([HAVE_CONAN],
	   [AM_COND_IF([HAVE_CLANG],
	               [QH_COMPILER_C_VERSION_MAJOR([CONAN_CLANG_VERSIONS],
					            [clang version for conan],
					            [$CLANG])])])
AM_COND_IF([HAVE_CONAN],
	   [AM_COND_IF([HAVE_GCC],
	               [QH_COMPILER_C_VERSION_MAJOR([CONAN_GCC_VERSIONS],
					            [gcc version for conan],
					            [$CC])])])

## coreutils ##

# check for ls that supports --color
AM_CONDITIONAL([EC_LSCOLOR], [ls --color &> /dev/null])
AM_COND_IF([EC_LSCOLOR],
           [LS_ALIASES=data/coreutils/bashrc.d/ls-color.aliases],
           [LS_ALIASES=data/coreutils/bashrc.d/ls.aliases])
AC_SUBST_FILE([LS_ALIASES])

## ctags ##

AC_CACHE_CHECK([for exuberant ctags],
               [ac_cv_path_EXUBERANT_CTAGS],
               [AC_PATH_PROGS_FEATURE_CHECK([EXUBERANT_CTAGS],
                                            [ctags],
                                            [if $ac_path_EXUBERANT_CTAGS --version | $GREP --silent Exuberant; then
                                               ac_cv_path_EXUBERANT_CTAGS=$ac_path_EXUBERANT_CTAGS
                                               ac_path_EXUBERANT_CTAGS_found=:
                                             fi])])
AM_CONDITIONAL([HAVE_EXUBERANT_CTAGS], [test "x$ac_cv_path_EXUBERANT_CTAGS" != x])
AM_COND_IF([HAVE_EXUBERANT_CTAGS],
           [AC_SUBST([EXUBERANT_CTAGS],
                     [$ac_cv_path_EXUBERANT_CTAGS])
            AC_CONFIG_FILES([data/ctags/bashrc.d/ctags-alias.sh])])

## curl ##

AC_ARG_VAR([CURL], [curl program])
AC_CHECK_PROGS([CURL], [curl], [no])
AM_CONDITIONAL([HAVE_CURL], [test "x$CURL" != xno])

## gpg ##

AC_ARG_VAR([GPG], [gpg program])
AC_CHECK_PROGS([GPG], [gpg2 gpg], [gpg])
AM_CONDITIONAL([HAVE_GPG], [test "x$GPG" != x])

# gpg2 #
AM_CONDITIONAL([HAVE_GPG2], [test "x$GPG" = xgpg2])
AM_COND_IF([HAVE_GPG2], [AC_CONFIG_FILES([data/gnupg/bashrc.d/gpg2.sh])])

## git ##

AC_ARG_VAR([GIT], [git program])
AC_CHECK_PROGS([GIT], [git], [no])
AM_CONDITIONAL([HAVE_GIT], [test "x$GIT" != xno])

AM_COND_IF([HAVE_GIT],
	   [QH_VAR_ENSURE([GIT_AUTHOR_NAME],
                          [human-readable name for git author],
                          [`getent passwd $USER | cut -d: -f5`])
            QH_VAR_ENSURE([GIT_AUTHOR_EMAIL],
                          [git author email],
                          [$USER@$HOSTNAME])
            QH_VAR_ENSURE([GIT_SIGNING_KEY],
                          [git author gpg signing key],
                          [`$GPG --list-key $GIT_AUTHOR_EMAIL 2>/dev/null | $SED '2{s/\s*//;q};d'`])])
AM_CONDITIONAL([HAVE_GIT_SIGNING_KEY], [test "x$GIT_SIGNING_KEY" != x])
AM_COND_IF([HAVE_GIT_SIGNING_KEY],
           [GIT_SIGNING_KEY_FILE=data/git/gitconfig-signing-key
            AC_CONFIG_FILES([data/git/gitconfig-signing-key])],
           [GIT_SIGNING_KEY_FILE=/dev/null])
AM_COND_IF([HAVE_GIT], [AC_SUBST_FILE([GIT_SIGNING_KEY_FILE])])

AC_CHECK_PROG([have_git_cred_pass], [git-credential-password-store], [yes])
AM_CONDITIONAL([HAVE_GIT_CRED_PASS], [test "x$have_git_cred_pass" = xyes])
AM_COND_IF([HAVE_GIT_CRED_PASS],
           [GIT_CRED_HELPER_FILE=data/git/cred-helper-pass],
           [GIT_CRED_HELPER_FILE=/dev/null])
AM_COND_IF([HAVE_GIT], [AC_SUBST_FILE([GIT_CRED_HELPER_FILE])])

AC_ARG_VAR([DIFF_HIGHLIGHT], [path to git diff-highlight])
AC_PATH_PROG([DIFF_HIGHLIGHT], [diff-highlight], [no],
             [$PATH$PATH_SEPARATOR/usr/share/git-core/contrib$PATH_SEPARATOR/usr/share/doc/git/contrib/diff-highlight])
AM_CONDITIONAL([HAVE_DIFF_HIGHLIGHT], [test "x$DIFF_HIGHLIGHT" != xno])
AM_COND_IF([HAVE_DIFF_HIGHLIGHT],
           [GIT_PAGER_FILE=data/git/pager-diff-highlight
            AC_CONFIG_FILES([data/git/pager-diff-highlight])],
           [GIT_PAGER_FILE=/dev/null])
AM_COND_IF([HAVE_GIT], [AC_SUBST_FILE([GIT_PAGER_FILE])])

AC_CHECK_FILE([/etc/bash_completion.d/git-prompt])
AM_CONDITIONAL([HAVE_GIT_PROMPT],
               [test "x$ac_cv_file__etc_bash_completion_d_git_prompt" = xyes])
AC_ARG_VAR([GIT_PROMPT_PATH], [path to git-prompt.sh])
AS_IF([test "x$GIT_PROMPT_PATH" = x],
      [AC_CHECK_FILE([/usr/share/git-core/contrib/completion/git-prompt.sh],
                     [GIT_PROMPT_PATH=/usr/share/git-core/contrib/completion/git-prompt.sh])])
AM_CONDITIONAL([LOCAL_GIT_PROMPT],
               [test "x$GIT_PROMPT_PATH" != x])

AM_COND_IF([HAVE_GIT],
           [AC_CONFIG_FILES([data/git/config
                             data/git/profile.d/git.sh])])

## gnulib ##

QH_VAR_ENSURE([GNULIB_REFDIR],
              [path to gnulib git repository clone],
              [$REFDIR/gnulib])
AM_CONDITIONAL([HAVE_GNULIB_REFDIR], [test -d $GNULIB_REFDIR])
AM_COND_IF([HAVE_GNULIB_REFDIR],
           [AC_CONFIG_FILES([data/gnulib/profile.d/gnulib.sh])])

## go ##

QH_VAR_ENSURE([GOPATH],
              [path to Go workspace directory],
              ["\$(XDG_DATA_HOME)/go"])
QH_VAR_ENSURE([GOMODCACHE],
              [path to Go module cache],
              ["\$(XDG_CACHE_HOME)/go/mod"])

## grep ##

AC_ARG_VAR([EGREP], [path to egrep])
AC_PROG_EGREP
AS_IF([test "x$EGREP" = xno],
      [AC_MSG_ERROR([could not find egrep])])

AC_CACHE_CHECK([for grep that supports --color],
               [ac_cv_path_GREP_COLOR],
               [AC_PATH_PROGS_FEATURE_CHECK([GREP_COLOR],
                                            [ggrep grep],
                                            [if echo color | $ac_path_GREP_COLOR --color color &> /dev/null; then
                                               ac_cv_path_GREP_COLOR=$ac_path_GREP_COLOR
                                               ac_path_GREP_COLOR_found=:
                                             fi])])
AM_CONDITIONAL([HAVE_GREP_COLOR], [test "x$ac_cv_path_GREP_COLOR" != x])
AM_COND_IF([HAVE_GREP_COLOR],
           [AC_SUBST([GREP_COLOR], [$ac_cv_path_GREP_COLOR])
            AC_CONFIG_FILES([data/grep/bashrc.d/grep.sh])])

## minicom ##

AC_ARG_VAR([MINICOM], [minicom program])
AC_CHECK_PROGS([MINICOM], [minicom], [no])
AM_CONDITIONAL([HAVE_MINICOM], [test "x$MINICOM" != xno])

## ruby ##

AC_ARG_VAR([RUBY], [ruby program])
AC_CHECK_PROGS([RUBY], [ruby], [no])
AM_CONDITIONAL([HAVE_RUBY], [test "x$RUBY" != xno])

QH_VAR_ENSURE([BUNDLE_USER_CONFIG],
              [path to bundle user home],
              ["\$(bundleconfdir)"])
QH_VAR_ENSURE([BUNDLE_USER_CACHE],
              [path to Go module cache],
              ["\$(XDG_CACHE_HOME)/bundle"])
QH_VAR_ENSURE([BUNDLE_USER_PLUGIN],
              [path to Go module cache],
              ["\$(XDG_DATA_HOME)/bundle"])

## software collections ##

QH_ARG_ENABLE([scl], [no])
AM_CONDITIONAL([ENABLE_SCL], [test "x$enable_scl" != xno])
AM_COND_IF([ENABLE_SCL],
	   [QH_REQUIRE_PROG([SCL], [scl], [path to scl])
	    QH_REQUIRE_PROG([SCL_ENABLED], [scl_enabled], [path to scl_enabled])
	    QH_REQUIRE_PROG([SCL_SOURCE], [scl_source], [path to scl_source])
	    QH_VAR_ENSURE([SCL_LIST],
			  [software collections list],
			  [`$SCL --list`])
            AC_CONFIG_FILES([data/scl/profile.d/scl.sh])])

## systemd ##

# TODO: revisit
# check for systemd-path
AC_ARG_VAR([SYSTEMD_PATH], [path to systemd-path])
AC_PATH_PROG([SYSTEMD_PATH], [systemd-path], [no])
AM_CONDITIONAL([HAVE_SYSTEMD_PATH], [test "x$SYSTEMD_PATH" != xno])
AM_COND_IF([HAVE_SYSTEMD_PATH],
           [XDG_BASEDIR_FILE=data/autoconf/config-site-systemd
            AC_CONFIG_FILES([data/autoconf/config-site-systemd])],
           [XDG_BASEDIR_FILE=data/autoconf/config-site-sysvinit])
AC_SUBST_FILE([XDG_BASEDIR_FILE])

## vim ##

AC_ARG_VAR([VIM], [vim program])
AC_CHECK_PROGS([VIM], [vim], [no])
AM_CONDITIONAL([HAVE_VIM], [test "x$VIM" != xno])

# Vim YouCompleteMe requirements
QH_ARG_ENABLE([ycm], [no])
AM_CONDITIONAL([ENABLE_YCM], [test "x$enable_ycm" != xno])
AM_COND_IF([ENABLE_YCM],
	   [QH_REQUIRE_PROG([CMAKE], [cmake cmake3], [path to cmake])
	    QH_REQUIRE_PROG([GCXX], [g++], [path to g++])
	    EC_VIM_YCM_OWNER([VIM_YCM_OWNER], [GitHub owner for YouCompleteMe])
	    EC_VIM_YCM_REF([VIM_YCM_REF], [Git reference for YouCompleteMe])
	    EC_VIM_YCM_ARGS([VIM_YCM_ARGS], [Arguments for YouCompleteMe install script])
	    VIM_PLUG_YCM_FILE=data/vim/vim-plug-ycm
	    AC_CONFIG_FILES([data/vim/vim-plug-ycm])
	    VIMRC_YCM_FILE=data/vim/vimrc-ycm],
	   [VIM_PLUG_YCM_FILE=/dev/null
	    VIMRC_YCM_FILE=/dev/null])
AC_SUBST_FILE([VIM_PLUG_YCM_FILE])
AC_SUBST_FILE([VIMRC_YCM_FILE])

AM_CONDITIONAL([VIM_YCM_SYSTEM_CLANGD],
	       [test "x$VIM_YCM_OWNER" = "xdetwiler" && test "x$VIM_YCM_REF" != "xvim-7.4.143"])
AM_COND_IF([ENABLE_YCM],
	   [AM_COND_IF([VIM_YCM_SYSTEM_CLANGD],
		       [QH_REQUIRE_PROG([CLANGD], [clangd clangd-10], [path to clangd])
			YCM_CLANGD_BINARY_PATH_FILE=data/vim/ycm-clangd-binary-path
			AC_CONFIG_FILES([data/vim/ycm-clangd-binary-path])],
		       [YCM_CLANGD_BINARY_PATH_FILE=/dev/null])
	    AC_SUBST_FILE([YCM_CLANGD_BINARY_PATH_FILE])
	    AC_CONFIG_FILES([data/vim/ycm.vim])])

# Vim CMake requirements
QH_ARG_ENABLE([vim_cmake], [no])
AM_CONDITIONAL([ENABLE_VIM_CMAKE], [test "x$enable_vim_cmake" != xno])
AM_COND_IF([ENABLE_VIM_CMAKE],
	   [QH_REQUIRE_PROG([CMAKE], [cmake cmake3], [path to cmake])
	    QH_VAR_ENSURE([VIM_CMAKE_BUILD_DIR],
			  [vim-cmake plugin build directory], [.ycm-build])
	    AC_CONFIG_FILES([data/vim/cmake.vim])
            VIM_PLUG_CMAKE_FILE=data/vim/vim-plug-cmake
	    VIMRC_CMAKE_FILE=data/vim/vimrc-cmake],
           [VIM_PLUG_CMAKE_FILE=/dev/null
            VIMRC_CMAKE_FILE=/dev/null])
AC_SUBST_FILE([VIM_PLUG_CMAKE_FILE])
AC_SUBST_FILE([VIMRC_CMAKE_FILE])

# vim-plug requirements
QH_ARG_ENABLE([vim_plug], [no])
AM_CONDITIONAL([ENABLE_VIM_PLUG], [test "x$enable_vim_plug" != xno])
AM_COND_IF([ENABLE_VIM_PLUG],
	   [QH_REQUIRE_PROG([CURL], [curl], [path to curl])
	    AC_CONFIG_FILES([data/vim/vim-plug.vim.in])
	    VIMRC_VIM_PLUG_FILE=data/vim/vimrc-vim-plug],
           [VIMRC_VIM_PLUG_FILE=/dev/null])
AC_SUBST_FILE([VIMRC_VIM_PLUG_FILE])

QH_ARG_ENABLE([vim_plug_install], [no])
AM_CONDITIONAL([ENABLE_VIM_PLUG_INSTALL], [test "x$enable_vim_plug_install" != xno])

AM_COND_IF([HAVE_VIM],
           [AC_CONFIG_FILES([data/vim/vimrc.in
                             data/vim/bashrc.d/vi.sh 
                             data/vim/profile.d/editor.sh])])

## additional modules

QH_ARG_WITH([bashrc_module], [no])
AC_SUBST([BASHRC_MODULE], [$with_bashrc_module])
AM_CONDITIONAL([WITH_BASHRC_MODULE], [test "x$with_bashrc_module" != xno])

QH_ARG_WITH([profile_module], [no])
AC_SUBST([PROFILE_MODULE], [$with_profile_module])
AM_CONDITIONAL([WITH_PROFILE_MODULE], [test "x$with_profile_module" != xno])

## configure output files

AC_CONFIG_FILES([Makefile
                 data/Makefile
                 data/autoconf/Makefile
                 data/autoconf/config.site
                 data/aws-cli/Makefile
                 data/aws-cli/bashrc.d/Makefile
                 data/aws-cli/profile.d/Makefile
                 data/bash/Makefile
                 data/bash/.profile
                 data/bash/functions
                 data/bash/bashrc.d/Makefile
                 data/bash/bashrc.d/functions.sh
                 data/bash/bashrc.d/ps1.sh
                 data/bash/profile.d/Makefile
                 data/cmake/Makefile
                 data/cmake/bashrc.d/Makefile
                 data/conan/Makefile
                 data/conan/profile.d/Makefile
                 data/coreutils/Makefile
                 data/coreutils/bashrc.d/Makefile
                 data/coreutils/bashrc.d/ls.sh
                 data/ctags/Makefile
                 data/ctags/bashrc.d/Makefile
                 data/info/Makefile
                 data/info/profile.d/Makefile
                 data/git/Makefile
                 data/git/bashrc.d/Makefile
                 data/git/profile.d/Makefile
                 data/gnulib/Makefile
                 data/gnulib/profile.d/Makefile
                 data/gnupg/Makefile
                 data/gnupg/bashrc.d/Makefile
                 data/gnupg/profile.d/Makefile
                 data/go/Makefile
                 data/go/profile.d/Makefile
                 data/grep/Makefile
                 data/grep/bashrc.d/Makefile
                 data/man/Makefile
                 data/minicom/Makefile
                 data/minicom/bashrc.d/Makefile
                 data/readline/Makefile
                 data/readline/profile.d/Makefile
                 data/ruby/Makefile
                 data/ruby/profile.d/Makefile
                 data/python/Makefile
                 data/python/profile.d/Makefile
                 data/scl/Makefile
                 data/scl/profile.d/Makefile
                 data/ssh/Makefile
                 data/vim/Makefile
                 data/vim/bashrc.d/Makefile
                 data/vim/profile.d/Makefile
                 data/xdg/Makefile
                 ])
gl_CONFIG_VERSION_STAMP
AC_OUTPUT
