# envconf.m4
#
# convenience functions

AC_DEFUN([EC_ARG_ENABLE],
         [AC_ARG_ENABLE([m4_translit([$1], [_], [-])],
                        [AS_HELP_STRING([--enable-m4_translit([$1], [_], [-])],
                                        [enable $1 (default=$2)])],
                        [enable_[]$1=$enableval],
                        [enable_[]$1=$2])])

AC_DEFUN([EC_ARG_WITH],
         [AC_ARG_WITH([m4_translit([$1], [_], [-])],
                        [AS_HELP_STRING([--with-m4_translit([$1], [_], [-])],
                                        [with $1 (default=$2)])],
                        [with_[]$1=$withval],
                        [with_[]$1=$2])])
