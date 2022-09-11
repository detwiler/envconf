# Makefile.am

include $(top_srcdir)/rules.mk

# data/script variables
sshconf = config
githubconf = github.conf
gitlabconf = gitlab.conf
vagrantconf = vagrant.conf

# directory variables
sshdir = $(homedir)/.ssh
confdir = $(sshdir)/config.d
keydir = $(sshdir)/keys.d
knownhostsdir = $(sshdir)/known_hosts.d

# static data/scripts (not generated; require explicit distribution)
static_data = $(sshconf)

dist_ssh_DATA = $(static_data)

static_conf_data = $(githubconf) \
		   $(gitlabconf) \
		   $(vagrantconf)

dist_conf_DATA = $(static_conf_data)

# install/uninstall targets
.PHONY: sshdir-perms
sshdir-perms:
	chmod 0700 $(DESTDIR)$(sshdir)

.PHONY: ssh-data-perms
ssh-data-perms:
	cd $(DESTDIR)$(sshdir) && chmod 0600 $(dist_ssh_DATA)

.PHONY: confdir-perms
confdir-perms:
	chmod 0700 $(DESTDIR)$(confdir)

.PHONY: conf-data-perms
conf-data-perms:
	cd $(DESTDIR)$(confdir) && chmod 0600 $(dist_conf_DATA)

$(keydir):
	$(MKDIR_P) -m 0700 $(DESTDIR)$@

$(knownhostsdir):
	$(MKDIR_P) -m 0700 $(DESTDIR)$@

install-data-local: $(keydir) $(knownhostsdir)

install-data-hook: sshdir-perms ssh-data-perms confdir-perms conf-data-perms
