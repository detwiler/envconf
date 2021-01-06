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

AC_PREFIX_DEFAULT([$HOME/.local])

AC_SUBST([homedir], [$HOME])
AC_SUBST([pkgconfdir], ["\$(sysconfdir)/\$(PACKAGE)"])
AC_SUBST([bashrcdir], ["\$(pkgconfdir)/bashrc.d"])
AC_SUBST([profiledir], ["\$(pkgconfdir)/profile.d"])
AC_SUBST([vimdir], ["\$(sysconfdir)/vim"])
AC_SUBST([vimconfdir], ["\$(pkgconfdir)/vim"])

QH_VAR_ENSURE([WORKDIR],
              [path to local work directory],
              [$HOME/work])

QH_VAR_ENSURE([REFDIR],
              [path to local directory with reference repositories],
              [$WORKDIR/ref])

### Checks for programs. ###

AC_PROG_INSTALL
AC_PROG_LN_S
AC_PROG_MKDIR_P
AC_PROG_SED

## aws-cli ##

QH_ARG_ENABLE([aws_cli], [yes])
AM_CONDITIONAL([ENABLE_AWS_CLI], [test "x$enable_aws_cli" = xyes])
AM_COND_IF([ENABLE_AWS_CLI],
           [QH_REQUIRE_PROG([AWS], [aws], [path to aws])
            QH_VAR_ENSURE([AWS_CONFIG_DIR],
                          [path to aws-cli configuration directory],
                          [$HOME/.aws])
            QH_VAR_ENSURE([AWS_SHARED_CREDENTIALS_FILE],
                          [path to aws-cli shared credentials file],
                          [$AWS_CONFIG_DIR/credentials])])
AM_CONDITIONAL([HAVE_AWS_CLI], [test "x$AWS" != x])

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
# Text color codes:
# 30=black 31=red 32=green 33=yellow 34=blue 35=magenta 36=cyan 37=white
QH_VAR_ENSURE([PS1_USER_COLOR], [bash prompt username color],    [32])
QH_VAR_ENSURE([PS1_HOST_COLOR], [bash prompt hostname color],    [34])
QH_VAR_ENSURE([PS1_GIT_COLOR],  [bash prompt git status color],  [32])
QH_VAR_ENSURE([PS1_PWD_COLOR],  [bash prompt pwd color],          [0])
QH_VAR_ENSURE([PS1_AWS_COLOR],  [bash prompt aws profile color], [33])

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

QH_REQUIRE_PROG([CLANG], [clang], [path to clang])
QH_CLANG_VERSION_MAJOR([CONAN_CLANG_VERSIONS], [clang version for conan])
QH_REQUIRE_PROG([GCC], [gcc], [path to gcc])
QH_GCC_VERSION_MAJOR([CONAN_GCC_VERSIONS], [gcc version for conan])

QH_VAR_ENSURE([CONAN_USERNAME],
              [User name required by conan-package-tools],
              [$USER])

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

QH_VAR_ENSURE([GNULIB_SRCDIR],
              [path to gnulib source directory],
              [$REFDIR/gnulib])
AM_CONDITIONAL([HAVE_GNULIB_SRCDIR], [test -d $GNULIB_SRCDIR])
AM_COND_IF([HAVE_GNULIB_SRCDIR],
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

QH_REQUIRE_PROG([VIM], [vim], [path to vim])
AC_CHECK_PROGS([GVIM], [gvim])
AM_CONDITIONAL([HAVE_GVIM], [test "x$GVIM" = xgvim])
AM_COND_IF([HAVE_GVIM], [AC_CONFIG_FILES([data/vim/gvimrc])])

# vim-plug requirements
QH_REQUIRE_PROG([CURL], [curl], [path to curl])

# YouCompleteMe requirements
QH_REQUIRE_PROG([CLANGD], [clangd], [path to clangd])
QH_REQUIRE_PROG([CMAKE], [cmake], [path to cmake])
QH_REQUIRE_PROG([GCXX], [g++], [path to g++])

QH_VAR_ENSURE([VIM_CMAKE_BUILD_DIR],
              [vim-cmake plugin build directory],
              [.ycm-build])

QH_VAR_ENSURE([VIM_YCM_OWNER],
              [GitHub owner for YouCompleteMe],
              [ycm-core])

QH_VAR_ENSURE([VIM_YCM_REF],
              [Git reference for YouCompleteMe],
              [master])

QH_VAR_ENSURE([GVIM_FONT],
              [gvim font],
              [Monospace])

QH_VAR_ENSURE([GVIM_FONT_SIZE],
              [gvim font size],
              [11])

AM_COND_IF([HOST_OS_DARWIN],
           [GVIM_FONT_SEPARATOR=:h],
           [GVIM_FONT_SEPARATOR='\ '])
AC_SUBST([GVIM_FONT_SEPARATOR])

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
                 data/bash/common/bashrc.d/aws-functions.sh
                 data/bash/common/bashrc.d/ls.sh
                 data/bash/common/bashrc.d/ps1.sh
                 data/bash/common/bashrc.d/vi.sh
                 data/bash/common/profile.d/Makefile
                 data/bash/common/profile.d/conan.sh
                 data/bash/common/profile.d/editor.sh
                 data/dircolors/Makefile
                 data/git/Makefile
                 data/git/.gitconfig
                 data/gnupg/Makefile
                 data/man/Makefile
                 data/readline/Makefile
                 data/ruby/Makefile
                 data/vim/Makefile
                 data/vim/cmake.vim
                 data/vim/ycm.vim
                 ])
AC_OUTPUT
