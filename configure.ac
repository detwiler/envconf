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

AC_SUBST([homedir], [${HOME}])
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

AC_CACHE_CHECK([for grep that supports --color], [ac_cv_path_GREP_COLOR],
  [AC_PATH_PROGS_FEATURE_CHECK([GREP_COLOR], [grep],
    [if echo color | ${ac_path_GREP_COLOR} --color color &> /dev/null; then
      ac_cv_path_GREP_COLOR=${ac_path_GREP_COLOR}
      ac_path_GREP_COLOR_found=:
     fi])])
AM_CONDITIONAL([HAVE_GREP_COLOR], [test -n ${ac_cv_path_GREP_COLOR}])
AM_COND_IF([HAVE_GREP_COLOR],
           [AC_SUBST([GREP_COLOR], [${ac_cv_path_GREP_COLOR}])
            AC_CONFIG_FILES([data/bash/common/bashrc.d/grep.sh])])

AC_CACHE_CHECK([for exuberant ctags], [ac_cv_path_EXUBERANT_CTAGS],
  [AC_PATH_PROGS_FEATURE_CHECK([EXUBERANT_CTAGS], [ctags],
    [if ${ac_path_EXUBERANT_CTAGS} --version | grep --silent Exuberant; then
      ac_cv_path_EXUBERANT_CTAGS=${ac_path_EXUBERANT_CTAGS}
      ac_path_EXUBERANT_CTAGS_found=:
     fi])])
AM_CONDITIONAL([HAVE_EXUBERANT_CTAGS], [test -n ${ac_cv_path_EXUBERANT_CTAGS}])
AM_COND_IF([HAVE_EXUBERANT_CTAGS],
           [AC_SUBST([EXUBERANT_CTAGS], [${ac_cv_path_EXUBERANT_CTAGS}])
            AC_CONFIG_FILES([data/bash/common/bashrc.d/ctags-alias.sh])])

AC_ARG_VAR([EGREP], [path to egrep])
AC_PATH_PROG([EGREP], [egrep])
AM_CONDITIONAL([HAVE_EGREP], [test "x${EGREP}" != x])
AM_COND_IF([HAVE_EGREP],
           [AC_CONFIG_FILES([data/bash/common/functions])])

# TODO write custom m4 macro for this, or AC_PATH_PROGS_FEATURE_CHECK?
# admittedly we're not using portable bourne shell here, but we know we're bash

AC_MSG_CHECKING([for multiple versions of bash])
if (( $(type -ap bash | wc --lines) > 1 )); then
  exp="s:^.*(@<:@0-9@:>@+\.@<:@0-9@:>@+\.@<:@0-9@:>@+).*$:\1:"
  multibash=no
  maxver=""
  maxbash=""
  for cmd in $(type -ap bash); do
    version=$(${cmd} --version | head --lines=1 | \
              sed --regexp-extended --expression="${exp}")
    if test "x${maxver}" = x; then
      maxver=${version}
      maxbash=${cmd}
    elif test "x${version}" != "x${maxver}"; then
      multibash=yes
      if test "x${version}" \> "x${maxver}"; then
        maxver=${version}
        maxbash=${cmd}
      fi
    fi
  done
  if test "x${multibash}" = xyes; then
    AC_MSG_RESULT([yes])
  else
    AC_MSG_RESULT([no])
    false
  fi
else
  AC_MSG_RESULT([no])
  false
fi

AM_CONDITIONAL([MULTI_BASH], [test "x${multibash}" = xyes])
AM_COND_IF([MULTI_BASH],
           [AC_SUBST([LATEST_BASH], [${maxbash}])
            AC_CONFIG_FILES([data/bash/common/bashrc.d/0-multi-bash-hack.sh])])

AC_MSG_CHECKING([for multiple versions of subversion])
if (( $(type -ap svn | wc --lines) > 1 )); then
  exp="s:^.*(@<:@0-9@:>@+\.@<:@0-9@:>@+\.@<:@0-9@:>@+).*$:\1:"
  multisvn=no
  maxver=""
  maxsvn=""
  for cmd in $(type -ap svn); do
    version=$(${cmd} --version 2> /dev/null | head --lines=1 | \
              sed --regexp-extended --expression="${exp}")
    if test "x${maxver}" = x; then
      maxver=${version}
      maxsvn=${cmd}
    elif test "x${version}" != "x${maxver}"; then
      multisvn=yes
      if test "x${version}" \> "x${maxver}"; then
        maxver=${version}
        maxsvn=${cmd}
      fi
    fi
  done
  if test "x${multisvn}" = xyes; then
    AC_MSG_RESULT([yes])
  else
    AC_MSG_RESULT([no])
    false
  fi
else
  AC_MSG_RESULT([no])
  false
fi

AM_CONDITIONAL([MULTI_SVN], [test "x${multisvn}" = xyes])
AM_COND_IF([MULTI_SVN],
           [AC_SUBST([LATEST_SVN], [${maxsvn}])
           AC_CONFIG_FILES([data/bash/common/bashrc.d/svn.sh])])

AC_MSG_CHECKING([for multiple versions of vim])
if (( $(type -ap vim | wc --lines) > 1 )); then
  exp="s:^.*(@<:@0-9@:>@+\.@<:@0-9@:>@+).*$:\1:"
  multivim=no
  maxver=""
  maxvim=""
  for cmd in $(type -ap vim); do
    version=$(${cmd} --version | head --lines=1 | \
              sed --regexp-extended --expression="${exp}")
    if test "x${maxver}" = x; then
      maxver=${version}
      maxvim=${cmd}
    elif test "x${version}" != "x${maxver}"; then
      multivim=yes
      if test "x${version}" \> "x${maxver}"; then
        maxver=${version}
        maxvim=${cmd}
      fi
    fi
  done
  if test "x${multivim}" = xyes; then
    AC_MSG_RESULT([yes])
  else
    AC_MSG_RESULT([no])
    false
  fi
else
  AC_MSG_RESULT([no])
  false
fi

AM_CONDITIONAL([MULTI_VIM], [test "x${multivim}" = xyes])
AM_COND_IF([MULTI_VIM],
           [AC_SUBST([LATEST_VIM], [${maxvim}])
            AC_CONFIG_FILES([data/bash/common/bashrc.d/vim.sh])])

AM_CONDITIONAL([HC_LSCOLOR], [ls --color &> /dev/null])
AM_COND_IF([HC_LSCOLOR],
           [LS_ALIASES=data/bash/common/bashrc.d/ls-color.aliases],
           [LS_ALIASES=data/bash/common/bashrc.d/ls.aliases])
AC_SUBST_FILE([LS_ALIASES])

# Checks for libraries.

# Checks for files.

AC_CHECK_FILE([${prefix}/etc/profile.d/bash_completion.sh],
              [have_bash_comp=yes])
AM_CONDITIONAL([HAVE_BASH_COMP], [test "x${have_bash_comp}" = xyes])

AC_CHECK_FILE([/opt/eldk],
              [have_eldk=yes])
AM_CONDITIONAL([HAVE_ELDK], [test "x${have_eldk}" = xyes])

# umbc systems
AC_CHECK_FILE([/afs/umbc.edu], [umbc=true])
AM_CONDITIONAL([UMBC], [test "x${umbc}" = xtrue])

AM_COND_IF([UMBC],
           [AC_CHECK_FILE([/usr/local/oracle/oracle.profile],
                          [umbc_oracle=true])])

# every AM_CONDITIONAL must run when configure is run
AM_CONDITIONAL([UMBC_ORACLE], [test "x${umbc_oracle}" = xtrue])

AM_COND_IF([UMBC],
           [AC_CHECK_FILE([/afs/umbc.edu/software/cadence/etc/license.dat],
                          [umbc_cadence=true])])
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
