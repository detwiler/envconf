# Makefile.am

include $(top_srcdir)/rules.mk

# data/script variables
info = info.sh

# data/scripts generated by make (require explicit distribution of source file)
make_data = $(info)

$(make_data): Makefile

profile_DATA = $(make_data)

# variables to support building our output
make_output = $(make_data)

make_sources = $(addsuffix .in,$(make_output))

# explicit source file distribution
EXTRA_DIST = $(make_sources)

CLEANFILES = $(make_output)

# sed command to build data/scripts
EDIT = -e 's:@infodir[@]:$(infodir):g'
