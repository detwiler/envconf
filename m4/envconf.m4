# envconf.m4

# EC_VIM_YCM_OWNER(VARIABLE, DESCRIPTION)
# ----------------------------------------------------------
# Set the GitHub owner for the Vim plugin YouCompleteMe.  Ensure the literal
# shell VARIABLE is set, and make it precious by passing to AC_ARG_VAR along
# with DESCRIPTION.  If not set, set the contents to the computed value for
# os-release ID and VERSION_ID.
AC_DEFUN([EC_VIM_YCM_OWNER],
[
AC_ARG_VAR([$1],[$2])
AC_MSG_CHECKING([if $1 is set])
AS_VAR_SET_IF([$1],
              [AC_MSG_RESULT([$$1])],
              [AC_MSG_RESULT([no])
               AS_VAR_COPY([_ec_version], [VERSION])
               QH_OS_RELEASE
               AS_ECHO_N(['setting $1 to computed value... '])
               AS_CASE([$ID],
                       [almalinux], [AS_CASE([$VERSION_ID],
                                             [8*], [AS_VAR_SET([$1], [detwiler])],
                                             [AS_VAR_SET([$1], [ycm-core])])],
                       [alpine],    [AS_VAR_SET([$1], [detwiler])],
                       [centos],    [AS_CASE([$VERSION_ID],
                                             [7|8], [AS_VAR_SET([$1], [detwiler])],
                                             [AS_VAR_SET([$1], [ycm-core])])],
                       [ubuntu],    [AS_CASE([$VERSION_ID],
                                             [18.04], [AS_VAR_SET([$1], [detwiler])],
                                             [AS_VAR_SET([$1], [ycm-core])])],
                       [AS_VAR_SET([$1], [ycm-core])])
               AS_VAR_COPY([VERSION], [_ec_version])
               AC_MSG_RESULT([$$1])])
]) # EC_VIM_YCM_OWNER

# EC_VIM_YCM_REF(VARIABLE, DESCRIPTION)
# ----------------------------------------------------------
# Set the Git reference for the Vim plugin YouCompleteMe.  Ensure the literal
# shell VARIABLE is set, and make it precious by passing to AC_ARG_VAR along
# with DESCRIPTION.  If not set, set the contents to the computed value for
# os-release ID and VERSION_ID.
AC_DEFUN([EC_VIM_YCM_REF],
[
AC_ARG_VAR([$1],[$2])
AC_MSG_CHECKING([if $1 is set])
AS_VAR_SET_IF([$1],
              [AC_MSG_RESULT([$$1])],
              [AC_MSG_RESULT([no])
               AS_VAR_COPY([_ec_version], [VERSION])
               QH_OS_RELEASE
               AS_ECHO_N(['setting $1 to computed value... '])
               AS_CASE([$ID],
                       [almalinux], [AS_CASE([$VERSION_ID],
                                             [8*], [AS_VAR_SET([$1], [vim-7.4.1578])],
                                             [AS_VAR_SET([$1], [master])])],
                       [alpine],    [AS_CASE([$VERSION_ID],
                                             [3.13*], [AS_VAR_SET([$1], [llvm-10])],
                                             [3.14*], [AS_VAR_SET([$1], [llvm-11])],
                                             [3.15*], [AS_VAR_SET([$1], [llvm-12])],
                                             [AS_VAR_SET([$1], [master])])],
                       [centos],    [AS_CASE([$VERSION_ID],
                                             [7], [AS_VAR_SET([$1], [vim-7.4.143])],
                                             [8], [AS_VAR_SET([$1], [vim-7.4.1578])],
                                             [AS_VAR_SET([$1], [master])])],
                       [ubuntu],    [AS_CASE([$VERSION_ID],
                                             [18.04], [AS_VAR_SET([$1], [vim-7.4.1578])],
                                             [AS_VAR_SET([$1], [master])])],
                       [AS_VAR_SET([$1], [master])])
               AS_VAR_COPY([VERSION], [_ec_version])
               AC_MSG_RESULT([$$1])])
]) # EC_VIM_YCM_REF

# EC_VIM_YCM_ARGS(VARIABLE, DESCRIPTION)
# ----------------------------------------------------------
# Set the arguments for the Vim plugin YouCompleteMe's installation script.
# Ensure the literal shell VARIABLE is set, and make it precious by passing to
# AC_ARG_VAR along with DESCRIPTION.  If not set, set the contents to the
# computed value for os-release ID and VERSION_ID.
AC_DEFUN([EC_VIM_YCM_ARGS],
[
AC_ARG_VAR([$1],[$2])
AC_MSG_CHECKING([if $1 is set])
AS_VAR_SET_IF([$1],
              [AC_MSG_RESULT([$$1])],
              [AC_MSG_RESULT([no])
               AS_VAR_COPY([_ec_version], [VERSION])
               QH_OS_RELEASE
               AS_ECHO_N(['setting $1 to computed value... '])
               AS_CASE([$ID],
                       [almalinux], [AS_CASE([$VERSION_ID],
                                             [8*], [AS_VAR_SET([$1], [--clangd-completer])],
                                             [AS_VAR_SET([$1], ['--clangd-completer --force-sudo'])])],
                       [alpine],    [AS_CASE([$VERSION_ID],
                                             [3.13*], [AS_VAR_SET([$1], [--clangd-completer])],
                                             [3.14*], [AS_VAR_SET([$1], [--clangd-completer])],
                                             [AS_VAR_SET([$1], ['--clangd-completer --force-sudo'])])],
                       [centos],    [AS_CASE([$VERSION_ID],
                                             [7], [AS_VAR_SET([$1], [--clang-completer])],
                                             [8], [AS_VAR_SET([$1], [--clangd-completer])],
                                             [AS_VAR_SET([$1], ['--clangd-completer --force-sudo'])])],
                       [ubuntu],    [AS_CASE([$VERSION_ID],
                                             [18.04], [AS_VAR_SET([$1], [--clangd-completer])],
                                             [AS_VAR_SET([$1], ['--clangd-completer --force-sudo'])])],
                       [AS_VAR_SET([$1], ['--clangd-completer --force-sudo'])])
               AS_VAR_COPY([VERSION], [_ec_version])
               AC_MSG_RESULT([$$1])])
]) # EC_VIM_YCM_ARGS

# EC_TOOLBOX_ENV
# ----------------------------------------------------------
# Find the container environment file and source it.
AC_DEFUN([EC_TOOLBOX_ENV],
[
AC_CHECK_FILE([/run/.toolboxenv],
	      [AC_CHECK_FILE([/run/.containerenv],
			     [. /run/.containerenv],
			     [AC_MSG_RESULT([failed to find /run/.containerenv])])],
	      [AC_MSG_RESULT([failed to find /run/.toolboxenv])])
]) # EC_TOOLBOX_ENV

# EC_TOOLBOX_NAME(VARIABLE, DESCRIPTION)
# ----------------------------------------------------------
# Ensure the literal shell VARIABLE is set, and make it
# precious by passing to AC_ARG_VAR. If not set, set the
# contents to the value found in /run/.containerenv if it
# exists, otherwise set to the hostname.
AC_DEFUN([EC_TOOLBOX_NAME],
[
AC_ARG_VAR([$1],[$2])
AC_MSG_CHECKING([if $1 is set])
AS_VAR_SET_IF([$1],
              [AC_MSG_RESULT([$$1])],
              [AC_MSG_RESULT([no])
	       EC_TOOLBOX_ENV
               AS_ECHO_N(['setting $1 to computed value... '])
               AS_VAR_SET([$1],[$name])
               AS_IF([test "x$$1" = x],
                     [AS_VAR_SET([$1],[$HOSTNAME])])
               AC_MSG_RESULT([$$1])])
]) # EC_TOOLBOX_NAME

# EC_PS1_DEFAULT
# ----------------------------------------------------------
# Set the default colors for various PS1 elements. Use 256
# color options if available.  Results are stored in the
# following variables.
# * _ec_ps1_user_default
# * _ec_ps1_host_default
# * _ec_ps1_git_default
# * _ec_ps1_aws_default
AC_DEFUN([EC_PS1_DEFAULT],
[
AS_VAR_SET([_ec_user_id], [m4_esyscmd_s([id --user])])
AS_VAR_COPY([_ec_version], [VERSION])
QH_OS_RELEASE
AS_CASE([$TERM],
        [*256*], [AS_CASE([$_ec_user_id],
                          [0], [AS_VAR_SET([_ec_ps1_user_default], ['38;5;9'])],
                          [AS_VAR_SET([_ec_ps1_user_default], ['38;5;28'])])
                  AS_CASE([$ID],
                          [almalinux], [AS_VAR_SET([_ec_ps1_host_default], ['38;5;214'])],
                          [alpine],    [AS_VAR_SET([_ec_ps1_host_default], ['38;5;24'])],
                          [centos],    [AS_VAR_SET([_ec_ps1_host_default], ['38;5;214'])],
                          [debian],    [AS_VAR_SET([_ec_ps1_host_default], ['38;5;161'])],
                          [fedora],    [AS_VAR_SET([_ec_ps1_host_default], ['38;5;33'])],
                          [rhel],      [AS_VAR_SET([_ec_ps1_host_default], ['38;5;196'])],
                          [ubuntu],    [AS_VAR_SET([_ec_ps1_host_default], ['38;5;202'])],
                          [AS_VAR_SET([_ec_ps1_host_default], ['38;5;6'])])
                  AS_VAR_SET([_ec_ps1_git_default], ['38;5;202'])
                  AS_VAR_SET([_ec_ps1_aws_default], ['38;5;214'])],
                 [AS_CASE([$_ec_user_id],
                          [0], [AS_VAR_SET([_ec_ps1_user_default], [31])],
                          [AS_VAR_SET([_ec_ps1_user_default], [32])])
                  AS_CASE([$ID],
                          [almalinux], [AS_VAR_SET([_ec_ps1_host_default], [33])],
                          [alpine],    [AS_VAR_SET([_ec_ps1_host_default], [36])],
                          [centos],    [AS_VAR_SET([_ec_ps1_host_default], [33])],
                          [debian],    [AS_VAR_SET([_ec_ps1_host_default], [35])],
                          [fedora],    [AS_VAR_SET([_ec_ps1_host_default], [34])],
                          [rhel],      [AS_VAR_SET([_ec_ps1_host_default], [31])],
                          [ubuntu],    [AS_VAR_SET([_ec_ps1_host_default], [35])],
                          [AS_VAR_SET([_ec_ps1_host_default], [32])])
                  AS_VAR_SET([_ec_ps1_git_default], [31])
                  AS_VAR_SET([_ec_ps1_aws_default], [33])])
AS_VAR_COPY([VERSION], [_ec_version])
]) # EC_PS1_DEFAULT
