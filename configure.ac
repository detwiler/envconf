#                                               -*- Autoconf -*-
# Process this file with autoconf to produce a configure script.

AC_INIT([envconf],
        [m4_esyscmd([build-aux/git-version-gen .tarball-version])],
        [mike.detwiler@gmail.com])

AC_PREREQ([2.63])
AC_CONFIG_AUX_DIR([build-aux])
AC_CONFIG_MACRO_DIR([m4])
AC_CONFIG_SRCDIR([data/bash/common/bashrc.in])

AM_INIT_AUTOMAKE([-Wall -Werror dist-bzip2])
AM_SILENT_RULES([yes])

AC_PREFIX_DEFAULT([$HOME/usr])

AC_SUBST([homedir], [$HOME])
AC_SUBST([bashrcdir], ["\$(pkgdatadir)/bashrc.d"])
AC_SUBST([profiledir], ["\$(pkgdatadir)/profile.d"])
AC_SUBST([seddatadir], ["\$(pkgdatadir)/sed"])
AC_SUBST([vimdatadir], ["\$(pkgdatadir)/vim"])

AC_CANONICAL_HOST
# cygwin systems
AM_CONDITIONAL([ECCYGWIN],
               [case "$host_os" in
                  *cygwin* ) true;;
                         * ) false;;
                esac])
AM_COND_IF([ECCYGWIN],
           [UPPER2LOWER=scripts/upper2lower.cygwin],
           [UPPER2LOWER=scripts/upper2lower.linux])
AC_SUBST_FILE([UPPER2LOWER])

# Checks for programs.
AC_PROG_INSTALL
AC_PROG_SED
AM_CONDITIONAL([HAVE_SED], [test "x$SED" != x])

AC_ARG_VAR([EDITOR], [default text editor])
AC_CHECK_PROG([EDITOR], [vim], [vim], [vi])
AM_CONDITIONAL([HAVE_VIM], [test "x$EDITOR" = xvim])

AM_COND_IF([HAVE_VIM], [AM_COND_IF([ECCYGWIN],
           [GVIM_FONT=/dev/null],
           [GVIM_FONT=data/vim/gvimrc.linux])
           AC_SUBST_FILE([GVIM_FONT])
           AC_CONFIG_FILES([data/vim/.gvimrc])])

AC_CHECK_PROG([have_dircolors], [dircolors], [yes])
AM_CONDITIONAL([HAVE_DIRCOLORS], [test "x$have_dircolors" = xyes])

AC_CHECK_PROG([have_svn], [svn], [yes])
AM_CONDITIONAL([HAVE_SVN], [test "x$have_svn" = xyes])

AC_ARG_VAR([WGET], [path to wget])
AC_PATH_PROG([WGET], [wget])
AM_CONDITIONAL([HAVE_WGET], [test "x$WGET" != x])

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

AC_ARG_VAR([EGREP], [path to egrep])
AC_PATH_PROG([EGREP], [egrep])
AM_CONDITIONAL([HAVE_EGREP], [test "x$EGREP" != x])
AM_COND_IF([HAVE_EGREP],
           [AC_CONFIG_FILES([data/bash/common/functions])])

AM_CONDITIONAL([EC_LSCOLOR], [ls --color &> /dev/null])
AM_COND_IF([EC_LSCOLOR],
           [LS_ALIASES=data/bash/common/bashrc.d/ls-color.aliases],
           [LS_ALIASES=data/bash/common/bashrc.d/ls.aliases])
AC_SUBST_FILE([LS_ALIASES])

# Checks for files.

AC_CHECK_FILE([$HOME/usr/share/android/tools],
              [have_android=yes])
AM_CONDITIONAL([HAVE_ANDROID], [test "x$have_android" = xyes])

AC_CHECK_FILE([$prefix/etc/profile.d/bash_completion.sh],
              [have_bash_comp=yes])
AM_CONDITIONAL([HAVE_BASH_COMP], [test "x$have_bash_comp" = xyes])

AC_CHECK_FILE([/opt/eldk],
              [have_eldk=yes])
AM_CONDITIONAL([HAVE_ELDK], [test "x$have_eldk" = xyes])

# umbc systems
AC_CHECK_FILE([/afs/umbc.edu], [umbc=true])
AM_CONDITIONAL([UMBC], [test "x$umbc" = xtrue])

AM_COND_IF([UMBC],
           [AC_CHECK_FILE([/usr/local/oracle/oracle.profile],
                          [umbc_oracle=true])])

# every AM_CONDITIONAL must run when configure is run
AM_CONDITIONAL([UMBC_ORACLE], [test "x$umbc_oracle" = xtrue])

AM_COND_IF([UMBC],
           [AC_CHECK_FILE([/afs/umbc.edu/software/cadence/etc/license.dat],
                          [umbc_cadence=true])])
AM_CONDITIONAL([UMBC_CADENCE], [test "x$umbc_cadence" = xtrue])

# umiacs 
AM_CONDITIONAL([UMIACS_HOST], [hostname | grep umiacs &> /dev/null])

# Additional options

# enable customization of user/host/pwd PS1 color
# Text color codes:
# 30=black 31=red 32=green 33=yellow 34=blue 35=magenta 36=cyan 37=white
EC_ARG_WITH([user_color], [32])
AC_SUBST([USER_COLOR], [$with_user_color])
EC_ARG_WITH([host_color], [33])
AC_SUBST([HOST_COLOR], [$with_host_color])
EC_ARG_WITH([pwd_color], [0])
AC_SUBST([PWD_COLOR], [$with_pwd_color])

# option to specify path to gnulib clone
EC_ARG_WITH([gnulib_srcdir], [no])
AM_CONDITIONAL([WITH_GNULIB_SRCDIR], [test "x$with_gnulib_srcdir" != xno])
AM_COND_IF([WITH_GNULIB_SRCDIR],
           [AC_SUBST([GNULIB_SRCDIR], [$with_gnulib_srcdir])
            AC_CONFIG_FILES([data/bash/common/profile.d/gnulib.sh])])

# option to specify path to bash
EC_ARG_WITH([bash_alias], [no])
AM_CONDITIONAL([WITH_BASH_ALIAS], [test "x$with_bash_alias" != xno])
AM_COND_IF([WITH_BASH_ALIAS],
           [AC_SUBST([BASH_ALIAS], [$with_bash_alias])
            MULTI_BASH_HACK=data/bash/common/multi-bash-hack.sh
            AC_CONFIG_FILES([data/bash/common/multi-bash-hack.sh])],
            [MULTI_BASH_HACK=data/bash/common/single-bash.sh])
AC_SUBST_FILE([MULTI_BASH_HACK])

# option to specify path to subversion
EC_ARG_WITH([subversion_alias], [no])
AM_CONDITIONAL([WITH_SVN_ALIAS], [test "x$with_subversion_alias" != xno])
AM_COND_IF([WITH_SVN_ALIAS],
           [AC_SUBST([SVN_ALIAS], [$with_subversion_alias])
           AC_CONFIG_FILES([data/bash/common/bashrc.d/svn.sh])])

# option to specify path to vim
EC_ARG_WITH([vim_alias], [no])
AM_CONDITIONAL([WITH_VIM_ALIAS], [test "x$with_vim_alias" != xno])
AM_COND_IF([WITH_VIM_ALIAS],
           [AC_SUBST([VIM_ALIAS], [$with_vim_alias])
           AC_CONFIG_FILES([data/bash/common/bashrc.d/vim.sh])])

# option to specify path to vimrc example
EC_ARG_WITH([vimrc_example], [/dev/null])
AC_SUBST([VIMRC_EXAMPLE], [$with_vimrc_example])

# option to include ssh hosts
EC_ARG_ENABLE([ssh_hosts], [no])
AM_CONDITIONAL([SSH_HOSTS], [test "x$enable_ssh_hosts" = xyes])

# option to enable architecture specific bindir
EC_ARG_ENABLE([arch_bin], [no])
AM_CONDITIONAL([ENABLE_ARCH_BIN], [test "x$enable_arch_bin" = xyes])

# option to enable proxy check
EC_ARG_ENABLE([proxy_check], [no])
AM_CONDITIONAL([PROXY_CHECK], [test "x$enable_proxy_check" = xyes])
AM_COND_IF([PROXY_CHECK], [AM_COND_IF([HAVE_WGET],
           [AC_CONFIG_FILES([data/bash/common/bashrc.d/proxy.sh])],
           [AC_MSG_ERROR([must have wget for --enable-proxy-check])])])

AM_CONDITIONAL([ECREADLINE], [test "x$INPUTRC" != x])

AC_CONFIG_FILES([Makefile
                 data/Makefile
                 data/bash/Makefile
                 data/bash/common/Makefile
                 data/bash/common/global-bash
                 data/bash/common/bashrc.d/Makefile
                 data/bash/common/bashrc.d/ls.sh
                 data/bash/common/bashrc.d/ps1.sh
                 data/bash/common/profile.d/Makefile
                 data/bash/common/profile.d/editor.sh
                 data/bash/cygwin/Makefile
                 data/bash/cygwin/bashrc.d/Makefile
                 data/bash/umbc/Makefile
                 data/bash/umbc/profile.d/Makefile
                 data/dircolors/Makefile
                 data/git/Makefile
                 data/git/.gitconfig
                 data/readline/Makefile
                 data/svn/Makefile
                 data/vim/Makefile
                 scripts/Makefile
                 scripts/upper2lower
                 scripts/sed/Makefile
                 scripts/vim/Makefile
                 ])

AC_OUTPUT
