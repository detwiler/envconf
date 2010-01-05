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

# TODO write custom m4 macro for this
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

# enable customization for root user
AM_CONDITIONAL([HCROOT], [(( $(id -u) == 0 ))])
AM_COND_IF([HCROOT], [user_color=31], [user_color=32])
AC_SUBST([USER_COLOR], [${user_color}])

# Checks for header files.

# Checks for typedefs, structures, and compiler characteristics.

# Checks for library functions.

AC_CONFIG_FILES([Makefile
                 data/Makefile
                 data/bash/Makefile
                 data/bash/common/Makefile
                 data/bash/common/bashrc.d/Makefile
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
