# Makefile.am

include $(top_srcdir)/rules.mk

# data/script variables
conan = conan.sh

# data/scripts generated by make (require explicit distribution of source file)
make_data = $(conan)

$(make_data): Makefile

profile_DATA = $(make_data)

# variables to support building our output
make_output = $(make_data)

make_sources = $(addsuffix .in,$(make_output))

# explicit source file distribution
EXTRA_DIST = $(make_sources)

CLEANFILES = $(make_output)

# sed command to build data/scripts
EDIT = -e 's:@CONAN_CLANG_VERSIONS[@]:$(CONAN_CLANG_VERSIONS):g' \
       -e 's:@CONAN_GCC_VERSIONS[@]:$(CONAN_GCC_VERSIONS):g' \
       -e 's:@CONAN_PIP_COMMAND[@]:$(CONAN_PIP_COMMAND):g' \
       -e 's:@CONAN_USER_HOME[@]:$(CONAN_USER_HOME):g' \
       -e 's:@CONAN_USERNAME[@]:$(CONAN_USERNAME):g'
