# Makefile.am

include $(top_srcdir)/rules.mk

SUBDIRS = bashrc.d \
	  profile.d

# data/script variables
config = config
ignore = ignore
gitconfig_signing_key = gitconfig-signing-key
pager_diff_highlight = pager-diff-hightlight

# static data/scripts (not generated; require explicit distribution)
static_data = $(ignore)

dist_gitconf_DATA = $(static_data)

# data/scripts generated by configure (source file automatically distributed)
conf_data = $(config)

gitconf_DATA = $(conf_data)

DISTCLEANFILES = $(conf_data) \
		 $(gitconfig_signing_key) \
		 $(pager_diff_highlight)

EXTRA_DIST = cred-helper-pass
