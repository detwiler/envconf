#                                               -*- Autoconf -*-
# Process this file with autoconf to produce a configure script.

AC_INIT([homeconfig], [0.0.1], [mike.detwiler@gmail.com])
AC_PREREQ([2.63])
AC_CONFIG_AUX_DIR([build-aux])
AC_CONFIG_MACRO_DIR([m4])
AC_CONFIG_SRCDIR([data/bash/common/bashrc.in])

AM_INIT_AUTOMAKE([-Wall -Werror])
AM_SILENT_RULES

AC_CANONICAL_HOST
# cygwin systems
AM_CONDITIONAL([HCCYGWIN],
               [case "${host_os}" in
                  *cygwin* ) true;;
                         * ) false;;
                esac])

# Checks for programs.
AC_PROG_INSTALL
AC_PROG_SED

AC_ARG_VAR([EDITOR], [default text editor])
AC_CHECK_PROG([EDITOR], [vim], [vim], [vi])

AC_CHECK_PROG([hcdircolors], [dircolors], [yes])
AM_CONDITIONAL([HCDIRCOLORS], [test "x${hcdircolors}" = xyes])

AC_PATH_PROGS_FEATURE_CHECK([GREP_COLOR], [grep],
    [if echo color | ${ac_path_GREP_COLOR} --color color &> /dev/null; then
       ac_cv_path_GREP_COLOR=${ac_path_GREP_COLOR}
       ac_path_GREP_COLOR_found=:
     fi])
AM_CONDITIONAL([HCGREP_COLOR], [test -n ${ac_cv_path_GREP_COLOR}])
AM_COND_IF([HCGREP_COLOR],
           [AC_SUBST([GREP_COLOR], [${ac_cv_path_GREP_COLOR}])
            AC_CONFIG_FILES([data/bash/common/bashrc.d/grep.sh])])

# TODO write custom m4 macro for this, or AC_PATH_PROGS_FEATURE_CHECK?
# admittedly we're not using portable bourne shell here, but we know we're bash
AM_CONDITIONAL([MULTI_BASH], [(( $(type -ap bash | wc --lines) > 1 ))])
AM_COND_IF([MULTI_BASH],
           [for cmd in $(type -ap bash); do
              if test -z ${max} || \
                  test '$(${cmd} --version)' \> '$(${max} --version)'; then
                max=${cmd}
              fi
            done
            AC_SUBST([LATEST_BASH], [${max}])
            AC_CONFIG_FILES([data/bash/common/bashrc.d/0-multi-bash-hack.sh])])

AM_CONDITIONAL([MULTI_SVN], [(( $(type -ap svn | wc --lines) > 1 ))])
AM_COND_IF([MULTI_SVN],
           [for cmd in $(type -ap svn); do
              if test -z ${max} || \
                  test '$(${cmd} --version)' \> '$(${max} --version)'; then
                max=${cmd}
              fi
            done
            AC_SUBST([LATEST_SVN], [${max}])
            AC_CONFIG_FILES([data/bash/common/bashrc.d/svn.sh])])

AM_CONDITIONAL([MULTI_VIM], [(( $(type -ap vim | wc --lines) > 1 ))])
AM_COND_IF([MULTI_VIM],
           [for cmd in $(type -ap vim); do
              if test -z ${max} || \
                  test '$(${cmd} --version)' \> '$(${max} --version)'; then
                max=${cmd}
              fi
            done
            AC_SUBST([LATEST_VIM], [${max}])
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
                 ])

AC_OUTPUT
