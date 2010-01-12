#                                               -*- Autoconf -*-
# Process this file with autoconf to produce a configure script.

AC_INIT([homeconfig], [0.0.1], [mike.detwiler@gmail.com])
AC_PREREQ([2.63])
AC_CONFIG_AUX_DIR([build-aux])
AC_CONFIG_MACRO_DIR([m4])
AC_CONFIG_SRCDIR([data/bash/common/bashrc.in])

AM_INIT_AUTOMAKE([-Wall -Werror])
AM_SILENT_RULES

AC_SUBST([homedir], [${HOME}/hctest])
AC_SUBST([bashrcdir], ["\$(pkgdatadir)/bashrc.d"])
AC_SUBST([profiledir], ["\$(pkgdatadir)/profile.d"])
AC_SUBST([seddatadir], ["\$(pkgdatadir)/sed"])
AC_SUBST([vimdatadir], ["\$(pkgdatadir)/vim"])

AC_CANONICAL_HOST
# cygwin systems
AM_CONDITIONAL([HCCYGWIN],
               [case "${host_os}" in
                  *cygwin* ) true;;
                         * ) false;;
                esac])
AM_COND_IF([HCCYGWIN],
           [UPPER2LOWER=scripts/upper2lower.cygwin],
           [UPPER2LOWER=scripts/upper2lower.linux])
AC_SUBST_FILE([UPPER2LOWER])

# Checks for programs.
AC_PROG_INSTALL
AC_PROG_SED
AM_CONDITIONAL([HAVE_SED], [test "x${SED}" != x])

AC_ARG_VAR([EDITOR], [default text editor])
AC_CHECK_PROG([EDITOR], [vim], [vim], [vi])
AM_CONDITIONAL([HAVE_VIM], [test "x${EDITOR}" = xvim])

AM_COND_IF([HAVE_VIM], [AM_COND_IF([HCCYGWIN],
           [GVIM_FONT=/dev/null],
           [GVIM_FONT=data/vim/gvimrc.linux])
           AC_SUBST_FILE([GVIM_FONT])
           AC_CONFIG_FILES([data/vim/.gvimrc])])

AC_CHECK_PROG([have_dircolors], [dircolors], [yes])
AM_CONDITIONAL([HAVE_DIRCOLORS], [test "x${have_dircolors}" = xyes])

AC_CHECK_PROG([have_svn], [svn], [yes])
AM_CONDITIONAL([HAVE_SVN], [test "x${have_svn}" = xyes])

AC_ARG_VAR([WGET], [path to wget])
AC_PATH_PROG([WGET], [wget])
AM_CONDITIONAL([HAVE_WGET], [test "x${WGET}" != x])

AC_PATH_PROGS_FEATURE_CHECK([GREP_COLOR], [grep],
    [if echo color | ${ac_path_GREP_COLOR} --color color &> /dev/null; then
       ac_cv_path_GREP_COLOR=${ac_path_GREP_COLOR}
       ac_path_GREP_COLOR_found=:
     fi])
AM_CONDITIONAL([HAVE_GREP_COLOR], [test -n ${ac_cv_path_GREP_COLOR}])
AM_COND_IF([HAVE_GREP_COLOR],
           [AC_SUBST([GREP_COLOR], [${ac_cv_path_GREP_COLOR}])
            AC_CONFIG_FILES([data/bash/common/bashrc.d/grep.sh])])

AC_ARG_VAR([EGREP], [path to egrep])
AC_PATH_PROG([EGREP], [egrep])
AM_CONDITIONAL([HAVE_EGREP], [test "x${EGREP}" != x])
AM_COND_IF([HAVE_EGREP],
           [AC_CONFIG_FILES([data/bash/common/functions])])

# TODO write custom m4 macro for this, or AC_PATH_PROGS_FEATURE_CHECK?
# admittedly we're not using portable bourne shell here, but we know we're bash
AM_CONDITIONAL([MULTI_BASH], [(( $(type -ap bash | wc --lines) > 1 ))])
AM_COND_IF([MULTI_BASH],
           [for cmd in $(type -ap bash); do
              if test -z ${maxbash} || \
                  test '$(${cmd} --version)' \> '$(${maxbash} --version)'; then
                maxbash=${cmd}
              fi
            done
            AC_SUBST([LATEST_BASH], [${maxbash}])
            AC_CONFIG_FILES([data/bash/common/bashrc.d/0-multi-bash-hack.sh])])

AM_CONDITIONAL([MULTI_SVN], [(( $(type -ap svn | wc --lines) > 1 ))])
AM_COND_IF([MULTI_SVN],
           [for cmd in $(type -ap svn); do
              if test -z ${maxsvn} || \
                  test '$(${cmd} --version)' \> '$(${maxsvn} --version)'; then
                maxsvn=${cmd}
              fi
            done
            AC_SUBST([LATEST_SVN], [${maxsvn}])
            AC_CONFIG_FILES([data/bash/common/bashrc.d/svn.sh])])

AM_CONDITIONAL([MULTI_VIM], [(( $(type -ap vim | wc --lines) > 1 ))])
AM_COND_IF([MULTI_VIM],
           [for cmd in $(type -ap vim); do
              if test -z ${maxvim} || \
                  test '$(${cmd} --version)' \> '$(${maxvim} --version)'; then
                maxvim=${cmd}
              fi
            done
            AC_SUBST([LATEST_VIM], [${maxvim}])
            AC_CONFIG_FILES([data/bash/common/bashrc.d/vim.sh])])

AM_CONDITIONAL([HC_LSCOLOR], [ls --color &> /dev/null])
AM_COND_IF([HC_LSCOLOR],
           [LS_ALIASES=data/bash/common/bashrc.d/ls-color.aliases],
           [LS_ALIASES=data/bash/common/bashrc.d/ls.aliases])
AC_SUBST_FILE([LS_ALIASES])

# Checks for libraries.

# Checks for files.

# umbc systems
AC_CHECK_FILE([/afs/umbc.edu], [umbc=true])
AM_CONDITIONAL([UMBC], [test "x${umbc}" = xtrue])

AM_COND_IF([UMBC],
           [AC_CHECK_FILE([/usr/local/oracle/oracle.profile],
                          [umbc_oracle=true])
           ])

# every AM_CONDITIONAL must run when configure is run
AM_CONDITIONAL([UMBC_ORACLE], [test "x${umbc_oracle}" = xtrue])

AM_COND_IF([UMBC],
           [AC_CHECK_FILE([/afs/umbc.edu/software/cadence/etc/license.dat],
                          [umbc_cadence=true])
           ])
AM_CONDITIONAL([UMBC_CADENCE], [test "x${umbc_cadence}" = xtrue])

# enable customization for root user
AM_CONDITIONAL([HCROOT], [(( $(id -u) == 0 ))])
AM_COND_IF([HCROOT], [user_color=31], [user_color=32])
AC_SUBST([USER_COLOR], [${user_color}])

# umiacs 
AM_CONDITIONAL([UMIACS_HOST], [hostname | grep umiacs &> /dev/null])

# Checks for header files.

# Checks for typedefs, structures, and compiler characteristics.

# Checks for library functions.

# Additional options

# option to conditionally include ssh hosts
AC_ARG_ENABLE([ssh-hosts],
              [AS_HELP_STRING([--enable-ssh-hosts],
                              [enable ssh hosts (default no)])],
              [case "${enableval}" in
                 yes) ssh_hosts="true" ;;
                 no) ssh_hosts="false" ;;
                 *) AC_MSG_ERROR(
                      [bad value ${enableval} for --enable-ssh-hosts]) ;;
              esac], [ssh_hosts="false"])
AM_CONDITIONAL([SSH_HOSTS], [test "x${ssh_hosts}" = xtrue])

# option to enable proxy check
AC_ARG_ENABLE([proxy-check],
              [AS_HELP_STRING([--enable-proxy-check],
                              [enable proxy check (default no)])],
              [case "${enableval}" in
                 yes) proxy_check="true" ;;
                 no) proxy_check="false" ;;
                 *) AC_MSG_ERROR(
                      [bad value ${enableval} for --enable-proxy-check]) ;;
              esac], [proxy_check="false"])
AM_CONDITIONAL([PROXY_CHECK], [test "x${proxy_check}" = xtrue])
AM_COND_IF([PROXY_CHECK], [AM_COND_IF([HAVE_WGET],
           [AC_CONFIG_FILES([data/bash/common/bashrc.d/proxy.sh])],
           [AC_MSG_ERROR([must have wget for --enable-proxy-check])])])

AM_CONDITIONAL([HCREADLINE], [test "x${INPUTRC}" != x])

AC_CONFIG_FILES([Makefile
                 data/Makefile
                 data/bash/Makefile
                 data/bash/common/Makefile
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
