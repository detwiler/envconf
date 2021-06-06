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
               QH_OS_RELEASE
               AS_ECHO_N(['setting $1 to computed value... '])
               AS_CASE([$ID],
                       [alpine], [AS_VAR_SET([$1], [detwiler])],
                       [ubuntu], [AS_CASE([$VERSION_ID],
                                          [18.04], [AS_VAR_SET([$1], [detwiler])],
                                          [AS_VAR_SET([$1], [ycm-core])])],
                       [AS_VAR_SET([$1], [ycm-core])])
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
               QH_OS_RELEASE
               AS_ECHO_N(['setting $1 to computed value... '])
               AS_CASE([$ID],
                       [alpine], [AS_VAR_SET([$1], [llvm-10])],
                       [ubuntu], [AS_CASE([$VERSION_ID],
                                          [18.04], [AS_VAR_SET([$1], [ubuntu-1804])],
                                          [AS_VAR_SET([$1], [master])])],
                       [AS_VAR_SET([$1], [master])])
               AC_MSG_RESULT([$$1])])
]) # EC_VIM_YCM_REF
