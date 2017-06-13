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

AC_PREFIX_DEFAULT([$HOME/.local])

AC_SUBST([homedir], [$HOME])
AC_SUBST([pkgconfdir], ["\$(sysconfdir)/\$(PACKAGE)"])
AC_SUBST([bashrcdir], ["\$(pkgconfdir)/bashrc.d"])
AC_SUBST([profiledir], ["\$(pkgconfdir)/profile.d"])
AC_SUBST([vimconfdir], ["\$(pkgconfdir)/vim"])

EC_VAR_ENSURE([WORKDIR],
              [path to local work directory],
              [$HOME/work])

EC_VAR_ENSURE([SRCDIR],
              [path to local source code directory],
              [$WORKDIR/src])

### Checks for programs. ###

AC_PROG_INSTALL
AC_PROG_LN_S
AC_PROG_SED

## aws-cli ##

AC_CHECK_PROG([have_aws_cli], [aws], [yes])
AM_CONDITIONAL([HAVE_AWS_CLI], [test "x$have_aws_cli" = xyes])

EC_VAR_ENSURE([AWS_CONFIG_DIR],
              [path to aws-cli configuration directory],
              [$HOME/.aws])

EC_VAR_ENSURE([AWS_SHARED_CREDENTIALS_FILE],
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

# option to enable local bash-completion
AC_ARG_ENABLE([local-bash-completion],
              [AS_HELP_STRING([--enable-local-bash-completion]
                              [install bash-completion configuration locally])],
              [enable_local_bash_comp=$enableval],
              [enable_local_bash_comp=no])
AM_CONDITIONAL([ENABLE_LOCAL_BASH_COMP],
               [test "x$enable_local_bash_comp" = xyes])

AM_CONDITIONAL([BIND_INPUTRC], [test "x$INPUTRC" != x])

# customization of PS1 color
# Text color codes:
# 30=black 31=red 32=green 33=yellow 34=blue 35=magenta 36=cyan 37=white
EC_VAR_ENSURE([PS1_USER_COLOR], [bash prompt username color],    [32])
EC_VAR_ENSURE([PS1_HOST_COLOR], [bash prompt hostname color],    [34])
EC_VAR_ENSURE([PS1_GIT_COLOR],  [bash prompt git status color],  [32])
EC_VAR_ENSURE([PS1_PWD_COLOR],  [bash prompt pwd color],          [0])
EC_VAR_ENSURE([PS1_AWS_COLOR],  [bash prompt aws profile color], [33])

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

AC_CACHE_CHECK([for exuberant ctags], [ac_cv_path_EXUBERANT_CTAGS],
  [AC_PATH_PROGS_FEATURE_CHECK([EXUBERANT_CTAGS], [ctags],
    [if $ac_path_EXUBERANT_CTAGS --version | grep --silent Exuberant; then
      ac_cv_path_EXUBERANT_CTAGS=$ac_path_EXUBERANT_CTAGS
      ac_path_EXUBERANT_CTAGS_found=:
     fi])])
AM_CONDITIONAL([HAVE_EXUBERANT_CTAGS], [test -n $ac_cv_path_EXUBERANT_CTAGS])
AM_COND_IF([HAVE_EXUBERANT_CTAGS],
           [AC_SUBST([EXUBERANT_CTAGS], [$ac_cv_path_EXUBERANT_CTAGS])
            AC_CONFIG_FILES([data/bash/common/bashrc.d/ctags-alias.sh])])

## gpg2 ##

AC_ARG_VAR([GPG], [path to gpg])
AC_CHECK_PROGS([GPG], [gpg2 gpg], [gpg])
AM_CONDITIONAL([HAVE_GPG2], [test "x$GPG" = xgpg2])
AM_COND_IF([HAVE_GPG2], [AC_CONFIG_FILES([data/bash/common/bashrc.d/gpg2.sh])])

## git ##

EC_VAR_ENSURE([GIT_AUTHOR_NAME],
              [human-readable name for git author],
              [`getent passwd $USER | cut -d: -f5`])

EC_VAR_ENSURE([GIT_AUTHOR_EMAIL],
              [git author email],
              [$USER@$HOSTNAME])

EC_VAR_ENSURE([GIT_SIGNING_KEY],
              [git author gpg signing key],
              [`$GPG --list-key $GIT_AUTHOR_EMAIL 2>/dev/null | sed '2{s/\s*//;q};d'`])
AM_CONDITIONAL([HAVE_GIT_SIGNING_KEY], [test "x$GIT_SIGNING_KEY" != x])
AM_COND_IF([HAVE_GIT_SIGNING_KEY],
           [GIT_SIGNING_KEY_FILE=data/git/gitconfig-signing-key
            AC_CONFIG_FILES([data/git/gitconfig-signing-key])],
           [GIT_SIGNING_KEY_FILE=/dev/null])
AC_SUBST_FILE([GIT_SIGNING_KEY_FILE])

EC_VAR_ENSURE([GIT_PROMPT_PATH],
              [path to git-prompt.sh],
              [/usr/share/git-core/contrib/completion/git-prompt.sh])

## gnulib ##

EC_VAR_ENSURE([GNULIB_SRCDIR],
              [path to gnulib source directory],
              [$SRCDIR/gnulib])
AM_CONDITIONAL([HAVE_GNULIB_SRCDIR], [test -d $GNULIB_SRCDIR])
AM_COND_IF([HAVE_GNULIB_SRCDIR],
           [AC_CONFIG_FILES([data/bash/common/profile.d/gnulib.sh])])

## go ##

EC_VAR_ENSURE([GOPATH],
              [path to Go workspace directory],
              [$WORKDIR/go])

## grep ##

AC_ARG_VAR([EGREP], [path to egrep])
AC_PROG_EGREP
AS_IF([test "x$EGREP" = xno],
      [AC_MSG_ERROR([could not find egrep])])

AC_CACHE_CHECK([for grep that supports --color], [ac_cv_path_GREP_COLOR],
  [AC_PATH_PROGS_FEATURE_CHECK([GREP_COLOR], [grep],
    [if echo color | $ac_path_GREP_COLOR --color color &> /dev/null; then
      ac_cv_path_GREP_COLOR=$ac_path_GREP_COLOR
      ac_path_GREP_COLOR_found=:
     fi])])
AM_CONDITIONAL([HAVE_GREP_COLOR], [test -n $ac_cv_path_GREP_COLOR])
AM_COND_IF([HAVE_GREP_COLOR],
           [AC_SUBST([GREP_COLOR], [$ac_cv_path_GREP_COLOR])
            AC_CONFIG_FILES([data/bash/common/bashrc.d/grep.sh])])

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

EC_VAR_ENSURE([GVIM_FONT],
              [gvim font],
              [Monospace])

EC_VAR_ENSURE([GVIM_FONT_SIZE],
              [gvim font size],
              [11])

EC_VAR_ENSURE([VIMRC_EXAMPLE_PATH],
              [path to vimrc_example.vim],
              [`(rpm -ql vim-common 2>/dev/null | grep '/vimrc_example.vim') || echo /dev/null`])

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
                 data/bash/common/profile.d/editor.sh
                 data/dircolors/Makefile
                 data/git/Makefile
                 data/git/.gitconfig
                 data/man/Makefile
                 data/readline/Makefile
                 data/vim/Makefile
                 ])

AC_OUTPUT
