# Makefile.am

include $(top_srcdir)/rules.mk

SUBDIRS = bashrc.d \
	  profile.d

# file/directory variables
cmake = cmake.vim
init = init.vim
map = map.vim
option = option.vim
vimrc = vimrc
vimrc_cmake = vimrc-cmake
vimrc_vim_plug = vimrc-vim-plug
vimrc_ycm = vimrc-ycm
vim_plug = vim-plug.vim
vim_plug_ycm = vim-plug-ycm
vimautoloaddir = $(vimconfdir)/autoload
vimpluggeddir = $(vimconfdir)/plugged
ycm = ycm.vim
ycm_clangd_binary_path = ycm-clangd-binary-path

# static data/scripts (not generated; require explicit distribution)
vimconf_static_data = $(map) \
		      $(option)
dist_vimconf_DATA = $(vimconf_static_data)

# data/scripts generated by configure (source file automatically distributed)
vimconf_conf_data =

if ENABLE_VIM_CMAKE
vimconf_conf_data += $(cmake)
endif

if ENABLE_YCM
vimconf_conf_data += $(ycm)
endif


vimconf_DATA = $(vimconf_conf_data)

DISTCLEANFILES = $(vim_plug_ycm) \
		 $(vimconf_conf_data) \
		 $(ycm_clangd_binary_path)

# data/scripts generated by make (require explicit distribution of source file)
vimconf_make_data = $(init) \
		    $(vimrc)

if ENABLE_VIM_PLUG
vimconf_make_data += $(vim_plug)
endif

vimconf_DATA += $(vimconf_make_data)

make_data = $(vimconf_make_data)

$(make_data): Makefile

# variables to support building our output
make_output = $(make_data)

make_sources = $(addsuffix .in,$(make_output))

# explicit source file distribution
EXTRA_DIST = $(make_sources) \
	     $(vimrc_cmake) \
	     $(vimrc_vim_plug) \
	     $(vimrc_ycm)

CLEANFILES = $(make_output)

# sed command to build data/scripts
# we use % delimiters with vimconfdir below, because vimrc is processed by
# both configure and make, and we want to prevent configure from substituting
# vimconfdir with $(pkgconfdir)/...
EDIT = -e 's:@vimautoloaddir[@]:$(vimautoloaddir):g' \
       -e 's:%vimconfdir%:$(vimconfdir):g' \
       -e 's:@vimpluggeddir[@]:$(vimpluggeddir):g'

.PHONY: vim-plug-install
vim-plug-install:
	$(AM_V_GEN)$(VIM) -es -u $(DESTDIR)$(vimconfdir)/vimrc -i NONE -c PlugInstall -c qa

.PHONY: vim-plug-uninstall
vim-plug-uninstall:
	$(AM_V_GEN)rm -rf $(DESTDIR)$(vimautoloaddir) && \
	  rm -rf $(DESTDIR)$(vimpluggeddir)

if ENABLE_VIM_PLUG_INSTALL
install-data-hook: vim-plug-install
uninstall-hook: vim-plug-uninstall
endif
