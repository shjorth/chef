Description
===========

Custom chef cookbooks used for provisioning.

To create a new chef cookbook template (called "hosts") in a Linux VM:

	export PATH=$PATH:/opt/chef/embedded/bin/
	cd /vagrant/chef-solo/
	rake new_cookbook COOKBOOK=hosts CB_PREFIX=site-

Refer to http://powdahound.com/2010/07/dynamic-hosts-file-using-chef
