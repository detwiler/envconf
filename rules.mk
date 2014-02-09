# rules.mk

# generate an output file from an input template via sed
%: %.in
	$(AM_V_GEN)$(SED) $(EDIT) < $< > $@
