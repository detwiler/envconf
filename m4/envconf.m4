# envconf.m4
#
# convenience functions

# EC_VAR_ENSURE(VARIABLE, DESCRIPTION, VALUE-IF-NOT-SET)
# ----------------------------------------------------------
# Ensure the literal shell VARIABLE is set, and make it
# precious by passing to AC_ARG_VAR along with DESCRIPTION.
# If not set, set the contents to the shell expansion of
# VALUE-IF-NOT-SET.
AC_DEFUN([EC_VAR_ENSURE],
[
AC_ARG_VAR([$1],[$2])
AC_MSG_CHECKING([if $1 is set])
AS_VAR_SET_IF([$1],
              [AC_MSG_RESULT([$$1])],
              [AC_MSG_RESULT([no])
               AS_ECHO_N(['setting $1 to default value... '])
               AS_VAR_SET([$1],[$3])
               AS_IF([test "x$$1" = x],
                     [AC_MSG_RESULT([empty])
                      AC_MSG_WARN([$1 set to empty value!])],
                     [AC_MSG_RESULT([$$1])])])
]) # EC_VAR_ENSURE
