# rules.mk

# generate an output file from an input template via sed
# define EDIT with an appropriate sed expression in the Makefile.am responsible
# for building the output file
%: %.in
	$(AM_V_GEN)$(SED) $(EDIT) < $< > $@
