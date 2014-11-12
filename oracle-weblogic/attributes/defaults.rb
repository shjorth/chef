# User who installs the software
default["wls_installation"]["user"] = "root"
default["wls_installation"]["group"] = "root"

# Where weblogic would be installed
default["wls_installation"]["directories"] = [
	"/u01",
	"/u01/oracle",
	"/u01/oracle/fmw",
	"/u01/oracle/fmw/tmp"
]

# Oracle Homes
default["wls_installation"]["middleware_home"] = "/u01/oracle/fmw"
default["wls_installation"]["weblogic_home"] = node["wls_installation"]["middleware_home"] + "/wlserver_10.3"
default["wls_installation"]["java_home"] = "/usr/java/latest"
default["wls_installation"]["installer"] = "file:///vagrant/software/wls1036_generic.jar"