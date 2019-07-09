#                                               -*- Autoconf -*-
# Process this file with autoconf to produce a configure script.

AC_INIT([envconf],
        [m4_esyscmd([build-aux/git-version-gen .tarball-version])],
        [mike@detwiler.io])

AC_PREREQ([2.63])
AC_CONFIG_AUX_DIR([build-aux])
AC_CONFIG_MACRO_DIR([m4])
AC_CONFIG_SRCDIR([data/bash/common/bashrc.in])

AM_INIT_AUTOMAKE([-Wall -Wno-portability -Werror dist-bzip2])
AM_SILENT_RULES([yes])

## determine host os ##
AC_CANONICAL_HOST

AM_CONDITIONAL([HOST_OS_DARWIN], [grep darwin <<<$host_os &>/dev/null])
AM_CONDITIONAL([HOST_OS_MINGW], [grep mingw <<<$host_os &>/dev/null])

AC_PREFIX_DEFAULT([$HOME/.local])

AC_SUBST([homedir], [$HOME])
AC_SUBST([pkgconfdir], ["\$(sysconfdir)/\$(PACKAGE)"])
AC_SUBST([bashrcdir], ["\$(pkgconfdir)/bashrc.d"])
AC_SUBST([profiledir], ["\$(pkgconfdir)/profile.d"])
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

AC_CHECK_PROG([have_aws_cli], [aws], [yes])
AM_CONDITIONAL([HAVE_AWS_CLI], [test "x$have_aws_cli" = xyes])

QH_VAR_ENSURE([AWS_CONFIG_DIR],
              [path to aws-cli configuration directory],
              [$HOME/.aws])

QH_VAR_ENSURE([AWS_SHARED_CREDENTIALS_FILE],
              [path to aws-cli shared credentials file],
              [$AWS_CONFIG_DIR/credentials])

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

## conan ##

QH_VAR_ENSURE([CONAN_USERNAME],
              [User name required by conan-package-tools],
              [$USER])
QH_VAR_ENSURE([CONAN_PIP_COMMAND],
              [Name of Python3 version of the pip command],
              [pip3])
QH_VAR_ENSURE([CONAN_GCC_VERSIONS],
              [colon-separated list of GCC major versions for conan-package-tools],
              [9])

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
                                            [if $ac_path_EXUBERANT_CTAGS --version | grep --silent Exuberant; then
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

QH_VAR_ENSURE([GIT_AUTHOR_NAME],
              [human-readable name for git author],
              [`getent passwd $USER | cut -d: -f5`])

QH_VAR_ENSURE([GIT_AUTHOR_EMAIL],
              [git author email],
              [$USER@$HOSTNAME])

QH_VAR_ENSURE([GIT_SIGNING_KEY],
              [git author gpg signing key],
              [`$GPG --list-key $GIT_AUTHOR_EMAIL 2>/dev/null | sed '2{s/\s*//;q};d'`])
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

QH_VAR_ENSURE([GIT_PROMPT_PATH],
              [path to git-prompt.sh],
              [/usr/share/git-core/contrib/completion/git-prompt.sh])

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
                                            [grep],
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

## python ##

AC_CACHE_CHECK([for Windows native Python 3],
               [ac_cv_path_WIN_PY3],
               [AC_PATH_PROGS_FEATURE_CHECK([WIN_PY3],
                                            [python python3],
                                            [if $ac_path_WIN_PY3 -c 'import sys; print(sys.version)' | grep '^3.*MSC' &>/dev/null; then
                                             ac_cv_path_WIN_PY3=$ac_path_WIN_PY3
                                             ac_path_WIN_PY3_found=:
                                             fi])])
AM_CONDITIONAL([HAVE_WIN_PY3], [test "x$ac_cv_path_WIN_PY3" != x])
AM_COND_IF([HAVE_WIN_PY3],
           [AC_SUBST([WIN_PY3_BASEDIR], [`dirname $ac_cv_path_WIN_PY3`])
            AC_SUBST([WIN_PY3_SCRIPTDIR], [$WIN_PY3_BASEDIR/Scripts])
            AC_CONFIG_FILES([data/bash/common/win-python-pathmung])])

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

AC_ARG_VAR([EDITOR], [default text editor])
AC_CHECK_PROG([EDITOR], [vim], [vim], [vi])
AM_CONDITIONAL([HAVE_VIM], [test "x$EDITOR" = xvim])
AM_COND_IF([HAVE_VIM], [AC_CONFIG_FILES([data/vim/.gvimrc])])

QH_VAR_ENSURE([VIMRC_EXAMPLE_PATH],
              [path to vimrc_example.vim],
              [`(rpm -ql vim-common 2>/dev/null | grep '/vimrc_example.vim') || echo /dev/null`])

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
                 data/bash/common/profile.d/Makefile
                 data/bash/common/profile.d/conan.sh
                 data/bash/common/profile.d/editor.sh
                 data/dircolors/Makefile
                 data/git/Makefile
                 data/git/.gitconfig
                 data/man/Makefile
                 data/readline/Makefile
                 data/ruby/Makefile
                 data/vim/Makefile
                 ])

AC_OUTPUT
