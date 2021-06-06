# envconf.m4

# EC_COMPILER_C_VERSION_MAJOR(VARIABLE, DESCRIPTION, COMPILER)
# ----------------------------------------------------------
# Set VARIABLE to value of C COMPILER's major version number, and make it
# precious by passing to AC_ARG_VAR along with DESCRIPTION.
# Supported compilers: clang, gcc
AC_DEFUN([EC_COMPILER_C_VERSION_MAJOR],
[
AC_ARG_VAR([$1],[$2])
AC_MSG_CHECKING([if $1 is set])
AS_VAR_SET_IF([$1],
              [AC_MSG_RESULT([$$1])],
              [AC_MSG_RESULT([no])
               AC_LANG_PUSH([C])
               AS_VAR_COPY([_ec_cc], [CC])
               AS_VAR_SET([CC], [$3])
               AS_ECHO_N(['setting $1 to computed value... '])
               AS_CASE([$3],
                       [*gcc*], [AC_COMPUTE_INT([$1], [__GNUC__])],
                       [*clang*], [AC_COMPUTE_INT([$1], [__clang_major__])],
                       [AC_MSG_ERROR([unsupported compiler: $3])])
               AS_IF([test "x$$1" = x],
                     [AC_MSG_RESULT([empty])
                      AC_MSG_WARN([$1 set to empty value!])],
                     [AC_MSG_RESULT([$$1])])
               AS_VAR_COPY([CC], [_ec_cc])
               AC_LANG_POP([C])])
]) # EC_COMPILER_C_VERSION_MAJOR
