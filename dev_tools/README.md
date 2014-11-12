Description
===========

Miscellanous development tools installation routines.

- Install Maven from archive file
- Create template for maven
- Set Maven options
- Create oc4j startup script

Requirements
============

Attributes
==========

* `node['dev_tools']['maven']['version']` - The version to be installed e.g. "3.2.1"
* `node['dev_tools']['maven']['url']` - The location of the archive file e.g. "file:///vagrant/software/apache-maven-3.2.1-bin.zip"
* `node['dev_tools']['maven']['home']` - The install location e.g "/usr/local/maven"
* `node['dev_tools']['maven']['mavenrc_opts']` - mavenrc default parameters e.g. "-Dmaven.repo.local=$HOME/.m2/repository -Xmx384m -XX:MaxPermSize=192m"
* `node['dev_tools']['maven']['setup_bin']`  - Whether to add the maven path e.g. true

Usage
=====

