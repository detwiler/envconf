#                                               -*- Autoconf -*-
# Process this file with autoconf to produce a configure script.

AC_INIT([envconf],
        [m4_esyscmd([build-aux/git-version-gen .tarball-version])],
        [mike@detwiler.io])

AC_PREREQ([2.64])
AC_CONFIG_AUX_DIR([build-aux])
AC_CONFIG_MACRO_DIR([m4])
AC_CONFIG_SRCDIR([data/bash/common/bashrc.in])

AM_INIT_AUTOMAKE([-Wall -Wno-portability -Werror foreign])
AM_SILENT_RULES([yes])

## determine host os ##
AC_CANONICAL_HOST

# need to check for grep early
AC_ARG_VAR([GREP], [path to grep])
AC_PROG_GREP
AS_IF([test "x$GREP" = xno],
      [AC_MSG_ERROR([could not find grep])])

AM_CONDITIONAL([HOST_OS_DARWIN], [echo $host_os | $GREP darwin &>/dev/null])
AM_CONDITIONAL([HOST_OS_MINGW], [echo $host_os | $GREP mingw &>/dev/null])

# option to provision toolbox host environment
QH_ARG_ENABLE([toolbox_host], [no])
AM_CONDITIONAL([ENABLE_TOOLBOX_HOST], [test "x$enable_toolbox_host" != xno])

# set TOOLBOX_NAME
AM_COND_IF([ENABLE_TOOLBOX_HOST],
           [QH_VAR_ENSURE([TOOLBOX_NAME], [Toolbox name], [`flatpak-spawn --host hostname`])],
           [EC_TOOLBOX_NAME([TOOLBOX_NAME], [Toolbox name])])

AC_PREFIX_DEFAULT([$HOME/.local])

AC_SUBST([homedir], [$HOME])
AC_SUBST([pkgconfdir], ["\$(sysconfdir)/\$(PACKAGE)"])
AC_SUBST([toolboxdir], ["\$(pkgconfdir)/\$(TOOLBOX_NAME)"])
AC_SUBST([bashrcdir], ["\$(toolboxdir)/bashrc.d"])
AC_SUBST([profiledir], ["\$(toolboxdir)/profile.d"])
AC_SUBST([vimdir], ["\$(sysconfdir)/vim/\$(TOOLBOX_NAME)"])
AC_SUBST([vimconfdir], ["\$(toolboxdir)/vim"])

QH_VAR_ENSURE([WORKDIR],
              [path to local work directory],
              [$HOME/work])

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

AC_PROG_INSTALL
AC_PROG_LN_S
AC_PROG_MKDIR_P
AC_PROG_SED

## aws-cli ##

AM_COND_IF([ENABLE_TOOLBOX_HOST],
           [_ec_aws_cli_default=no],
           [_ec_aws_cli_default=yes])
QH_ARG_ENABLE([aws_cli], [$_ec_aws_cli_default])
AM_CONDITIONAL([ENABLE_AWS_CLI], [test "x$enable_aws_cli" = xyes])
AM_COND_IF([ENABLE_AWS_CLI],
           [QH_REQUIRE_PROG([AWS], [aws], [path to aws])])
AM_CONDITIONAL([HAVE_AWS_CLI], [test "x$AWS" != x])
QH_VAR_ENSURE([AWS_CONFIG_DIR],
	  [path to aws-cli configuration directory],
	  [$HOME/.aws])
QH_VAR_ENSURE([AWS_CONFIG_FILE],
	  [path to aws-cli config file],
	  [$AWS_CONFIG_DIR/config])
QH_VAR_ENSURE([AWS_SHARED_CREDENTIALS_FILE],
	  [path to aws-cli shared credentials file],
	  [$AWS_CONFIG_DIR/credentials])
AC_CONFIG_FILES([data/bash/common/bashrc.d/aws-functions.sh])

## bash ##

# option to specify path to desired bash executable
# (usually one that is not the system default)
AC_ARG_VAR([BASH_PATH], [path to alternate bash executable])
AM_CONDITIONAL([HAVE_BASH_PATH], [test "x$BASH_PATH" != x])
AM_COND_IF([HAVE_BASH_PATH],
           [AC_SUBST([BASH_PATH])
            MULTI_BASH_HACK=data/bash/common/multi-bash-hack.sh
            AC_CONFIG_FILES([data/bash/common/multi-bash-hack.sh])],
           [MULTI_BASH_HACK=data/bash/common/single-bash.sh])
AC_SUBST_FILE([MULTI_BASH_HACK])

# bash-completion not enabled by default on Darwin
AM_COND_IF([HOST_OS_DARWIN],
           [QH_VAR_ENSURE([BASH_COMPLETION],
                          [path to bash completion script],
                          [/usr/local/etc/bash_completion])
            QH_VAR_ENSURE([BASH_COMPLETION_DIR],
                          [path to bash completion directory],
                          [/usr/local/etc/bash_completion.d])
            QH_VAR_ENSURE([BASH_COMPLETION_COMPAT_DIR],
                          [path to bash completion compat directory],
                          [/usr/local/etc/bash_completion.d])
            AC_CONFIG_FILES([data/bash/common/bashrc.d/bash-completion.sh])])

# readline configuration
AM_CONDITIONAL([BIND_INPUTRC], [test "x$INPUTRC" != x])

# customization of PS1 color
EC_PS1_DEFAULT
AM_COND_IF([ENABLE_TOOLBOX_HOST],
           [AS_CASE([$TERM],
                    [*256*], [AS_VAR_SET([_ec_ps1_host_default], ['38;5;245'])],
                             [AS_VAR_SET([_ec_ps1_host_default], [37])])])

QH_VAR_ENSURE([PS1_USER_COLOR], [bash prompt username color],    [$_ec_ps1_user_default])
QH_VAR_ENSURE([PS1_HOST_COLOR], [bash prompt hostname color],    [$_ec_ps1_host_default])
QH_VAR_ENSURE([PS1_GIT_COLOR],  [bash prompt git status color],  [$_ec_ps1_git_default])
QH_VAR_ENSURE([PS1_PWD_COLOR],  [bash prompt pwd color],         [0])
QH_VAR_ENSURE([PS1_AWS_COLOR],  [bash prompt aws profile color], [$_ec_ps1_aws_default])

## cmake ##
#
# cmake3 #
AC_ARG_VAR([CMAKE], [cmake program])
AC_CHECK_PROGS([CMAKE], [cmake cmake3], [no])
AM_CONDITIONAL([HAVE_CMAKE3], [test "x$CMAKE" = xcmake3])
AM_COND_IF([HAVE_CMAKE3], [AC_CONFIG_FILES([data/bash/common/bashrc.d/cmake3.sh])])

## python ##

AM_PATH_PYTHON([3.0], [],
	       [AC_MSG_ERROR([could not find python version >= 3.0])])

AC_CACHE_CHECK([for Windows native Python 3],
               [ac_cv_path_WIN_PY3],
               [AC_PATH_PROGS_FEATURE_CHECK([WIN_PY3],
                                            [python python3],
                                            [if $ac_path_WIN_PY3 -c 'import sys; print(sys.version)' | $GREP '^3.*MSC' &>/dev/null; then
                                             ac_cv_path_WIN_PY3=$ac_path_WIN_PY3
                                             ac_path_WIN_PY3_found=:
                                             fi])])
AM_CONDITIONAL([HAVE_WIN_PY3], [test "x$ac_cv_path_WIN_PY3" != x])
AM_COND_IF([HAVE_WIN_PY3],
           [AC_SUBST([WIN_PY3_BASEDIR], [`dirname $ac_cv_path_WIN_PY3`])
            AC_SUBST([WIN_PY3_SCRIPTDIR], [$WIN_PY3_BASEDIR/Scripts])
            AC_CONFIG_FILES([data/bash/common/win-python-pathmung])])

## conan ##

AM_COND_IF([ENABLE_TOOLBOX_HOST],
           [_ec_conan_default=no],
           [_ec_conan_default=yes])
QH_ARG_ENABLE([conan], [$_ec_conan_default])
AM_CONDITIONAL([ENABLE_CONAN], [test "x$enable_conan" = xyes])
AM_COND_IF([ENABLE_CONAN],
	   [AC_ARG_VAR([CLANG], [clang program])
            AC_PATH_PROGS([CLANG], [clang clang-10], [no])
            AM_CONDITIONAL([HAVE_CLANG], [test "x$CLANG" != xno])
	    AM_COND_IF([HAVE_CLANG],
                       [QH_COMPILER_C_VERSION_MAJOR([CONAN_CLANG_VERSIONS],
                                                    [clang version for conan],
                                                    [$CLANG])])
	    QH_REQUIRE_PROG([GCC], [gcc], [path to gcc])
	    QH_COMPILER_C_VERSION_MAJOR([CONAN_GCC_VERSIONS],
					[gcc version for conan],
					[$GCC])
	    QH_REQUIRE_PROG([CONAN_PIP_COMMAND], [pip3], [path to pip3])
	    QH_VAR_ENSURE([CONAN_USER_HOME],
			  [Conan user configuration directory],
			  ["\$(sysconfdir)/conan/\$(TOOLBOX_NAME)"])
	    QH_VAR_ENSURE([CONAN_USERNAME],
			  [User name required by conan-package-tools],
			  [$USER])])

## coreutils ##

AC_CHECK_PROG([have_dircolors], [dircolors], [yes])
AM_CONDITIONAL([HAVE_DIRCOLORS], [test "x$have_dircolors" = xyes])

# check for ls that supports --color
AM_CONDITIONAL([EC_LSCOLOR], [ls --color &> /dev/null])
AM_COND_IF([EC_LSCOLOR],
           [LS_ALIASES=data/bash/common/bashrc.d/ls-color.aliases],
           [LS_ALIASES=data/bash/common/bashrc.d/ls.aliases])
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
            AC_CONFIG_FILES([data/bash/common/bashrc.d/ctags-alias.sh])])

## gpg ##

# gpg2 #
AC_ARG_VAR([GPG], [gpg program])
AC_CHECK_PROGS([GPG], [gpg2 gpg], [gpg])
AM_CONDITIONAL([HAVE_GPG2], [test "x$GPG" = xgpg2])
AM_COND_IF([HAVE_GPG2], [AC_CONFIG_FILES([data/bash/common/bashrc.d/gpg2.sh])])

# gpg-agent
AC_ARG_VAR([GPG_AGENT], [gpg-agent program])
AC_CHECK_PROGS([GPG_AGENT], [gpg-agent], [no])
AM_CONDITIONAL([HAVE_GPG_AGENT], [test "x$GPG_AGENT" != xno])

# pinentry-mac
AC_ARG_VAR([PINENTRY_MAC], [path to pinentry-mac])
AC_PATH_PROG([PINENTRY_MAC], [pinentry-mac], [no])
AM_CONDITIONAL([HAVE_PINENTRY_MAC], [test "x$PINENTRY_MAC" != xno])

## git ##

QH_REQUIRE_PROG([GIT], [git], [path to git])
QH_VAR_ENSURE([GIT_AUTHOR_NAME],
              [human-readable name for git author],
              [`getent passwd $USER | cut -d: -f5`])

QH_VAR_ENSURE([GIT_AUTHOR_EMAIL],
              [git author email],
              [$USER@$HOSTNAME])

QH_VAR_ENSURE([GIT_SIGNING_KEY],
              [git author gpg signing key],
              [`$GPG --list-key $GIT_AUTHOR_EMAIL 2>/dev/null | $SED '2{s/\s*//;q};d'`])
AM_CONDITIONAL([HAVE_GIT_SIGNING_KEY], [test "x$GIT_SIGNING_KEY" != x])
AM_COND_IF([HAVE_GIT_SIGNING_KEY],
           [GIT_SIGNING_KEY_FILE=data/git/gitconfig-signing-key
            AC_CONFIG_FILES([data/git/gitconfig-signing-key])],
           [GIT_SIGNING_KEY_FILE=/dev/null])
AC_SUBST_FILE([GIT_SIGNING_KEY_FILE])

AC_CHECK_PROG([have_git_cred_pass], [git-credential-password-store], [yes])
AM_CONDITIONAL([HAVE_GIT_CRED_PASS], [test "x$have_git_cred_pass" = xyes])
AM_COND_IF([HAVE_GIT_CRED_PASS],
           [GIT_CRED_HELPER_FILE=data/git/cred-helper-pass],
           [AM_COND_IF([HOST_OS_MINGW],
                       [GIT_CRED_HELPER_FILE=data/git/cred-helper-manager],
                       [GIT_CRED_HELPER_FILE=/dev/null])])
AC_SUBST_FILE([GIT_CRED_HELPER_FILE])

AC_ARG_VAR([DIFF_HIGHLIGHT], [path to git diff-highlight])
AC_PATH_PROG([DIFF_HIGHLIGHT], [diff-highlight], [no],
             [$PATH$PATH_SEPARATOR/usr/share/git-core/contrib$PATH_SEPARATOR/usr/share/doc/git/contrib/diff-highlight])
AM_CONDITIONAL([HAVE_DIFF_HIGHLIGHT], [test "x$DIFF_HIGHLIGHT" != xno])
AM_COND_IF([HAVE_DIFF_HIGHLIGHT],
           [GIT_PAGER_FILE=data/git/pager-diff-highlight
            AC_CONFIG_FILES([data/git/pager-diff-highlight])],
           [GIT_PAGER_FILE=/dev/null])
AC_SUBST_FILE([GIT_PAGER_FILE])

AC_CHECK_FILE([/etc/bash_completion.d/git-prompt])
AM_CONDITIONAL([HAVE_GIT_PROMPT],
               [test "x$ac_cv_file__etc_bash_completion_d_git_prompt" = xyes])
AC_ARG_VAR([GIT_PROMPT_PATH], [path to git-prompt.sh])
AS_IF([test "x$GIT_PROMPT_PATH" = x],
      [AC_CHECK_FILE([/usr/share/git-core/contrib/completion/git-prompt.sh],
                     [GIT_PROMPT_PATH=/usr/share/git-core/contrib/completion/git-prompt.sh])])
AM_CONDITIONAL([LOCAL_GIT_PROMPT],
               [test "x$GIT_PROMPT_PATH" != x])

## gnulib ##

QH_VAR_ENSURE([GNULIB_REFDIR],
              [path to gnulib git repository clone],
              [$REFDIR/gnulib])
AM_CONDITIONAL([HAVE_GNULIB_REFDIR], [test -d $GNULIB_REFDIR])
AM_COND_IF([HAVE_GNULIB_REFDIR],
           [AC_CONFIG_FILES([data/bash/common/profile.d/gnulib.sh])])

## go ##

QH_VAR_ENSURE([GOPATH],
              [path to Go workspace directory],
              [$WORKDIR/go])

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
            AC_CONFIG_FILES([data/bash/common/bashrc.d/grep.sh])])

## homebrew paths ##

AM_COND_IF([HOST_OS_DARWIN],
           [QH_VAR_ENSURE([HOMEBREW_PREFIX],
                          [Homebrew prefix],
                          [/usr/local])
            AC_CONFIG_FILES([data/bash/common/homebrew-pathmung])])

## software collections ##

QH_ARG_ENABLE([scl], [no])
AM_CONDITIONAL([ENABLE_SCL], [test "x$enable_scl" = xyes])
AM_COND_IF([ENABLE_SCL],
	   [QH_REQUIRE_PROG([SCL], [scl], [path to scl])
	    QH_REQUIRE_PROG([SCL_ENABLED], [scl_enabled], [path to scl_enabled])
	    QH_REQUIRE_PROG([SCL_SOURCE], [scl_source], [path to scl_source])
	    QH_VAR_ENSURE([SCL_LIST],
			  [software collections list],
			  [`$SCL --list`])
            AC_CONFIG_FILES([data/bash/common/profile.d/scl.sh])])

## systemd ##

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

QH_REQUIRE_PROG([VIM], [vim vi], [path to vim])

# Vim YouCompleteMe requirements
QH_ARG_ENABLE([ycm], [yes])
AM_CONDITIONAL([ENABLE_YCM], [test "x$enable_ycm" = xyes])
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
AM_COND_IF([ENABLE_TOOLBOX_HOST],
           [_ec_vim_cmake_default=no],
           [_ec_vim_cmake_default=yes])
QH_ARG_ENABLE([vim_cmake], [$_ec_vim_cmake_default])
AM_CONDITIONAL([ENABLE_VIM_CMAKE], [test "x$enable_vim_cmake" = xyes])
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
QH_ARG_ENABLE([vim_plug_install], [yes])
AM_CONDITIONAL([ENABLE_VIM_PLUG_INSTALL], [test "x$enable_vim_plug_install" = xyes])
QH_REQUIRE_PROG([CURL], [curl], [path to curl])
AC_SUBST_FILE([VIM_PLUG_YCM_FILE])

# gvim
AC_CHECK_PROGS([GVIM], [gvim])
AM_CONDITIONAL([HAVE_GVIM], [test "x$GVIM" = xgvim])
AM_COND_IF([HAVE_GVIM],
	   [QH_VAR_ENSURE([GVIM_FONT], [gvim font], [Monospace])
	    QH_VAR_ENSURE([GVIM_FONT_SIZE], [gvim font size], [11])
	    AM_COND_IF([HOST_OS_DARWIN], [GVIM_FONT_SEPARATOR=:h], [GVIM_FONT_SEPARATOR='\ '])
	    AC_SUBST([GVIM_FONT_SEPARATOR])
	    AC_CONFIG_FILES([data/vim/gvimrc])])

## ruby ##

AC_CHECK_PROGS([RUBY], [ruby])
AM_CONDITIONAL([HAVE_RUBY], [test "x$RUBY" = xruby])

## configure output files

AC_CONFIG_FILES([Makefile
                 data/Makefile
                 data/autoconf/Makefile
                 data/autoconf/config.site
                 data/bash/Makefile
                 data/bash/common/Makefile
                 data/bash/common/functions
                 data/bash/common/global-bash
                 data/bash/common/bashrc.d/Makefile
                 data/bash/common/bashrc.d/ls.sh
                 data/bash/common/bashrc.d/ps1.sh
                 data/bash/common/bashrc.d/vi.sh
                 data/bash/common/profile.d/Makefile
                 data/bash/common/profile.d/git.sh
                 data/bash/common/profile.d/editor.sh
                 data/dircolors/Makefile
                 data/git/Makefile
                 data/git/.gitconfig
                 data/gnupg/Makefile
                 data/man/Makefile
                 data/readline/Makefile
                 data/ruby/Makefile
                 data/ssh/Makefile
                 data/vim/Makefile
                 data/vim/vim-plug.vim.in
                 data/vim/vimrc.in
                 ])
AC_OUTPUT
