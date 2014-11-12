##
# Create directories
##

temp_weblogic_installer = File.join(Chef::Config[:file_cache_path], 'weblogic.jar');

remote_file "#{temp_weblogic_installer}" do
  source node["wls_installation"]["installer"]
  action :create
end

# Set user variable
user = node["wls_installation"]["user"]
group = node["wls_installation"]["group"]
weblogic_home = node["wls_installation"]["weblogic_home"]

# Middleware Home directories
node["wls_installation"]["directories"].each do |wls_directory|
	directory wls_directory do
		owner user
		group group
		mode '0644'
		action :create
	end
end

##
# Prepare files
##

# Response files
tmp_directory = node["wls_installation"]["middleware_home"] + "/tmp"
weblogic_response = tmp_directory + "/weblogic_response.xml"

template weblogic_response do
	source "weblogic_response.erb"
	owner user
	group group
	variables({
		:middleware_home => node["wls_installation"]["middleware_home"],
		:weblogic_home => weblogic_home,
		:java_home => node["wls_installation"]["java_home"]
	})
end

# Install script
log_file =  tmp_directory + "/install.log"
java_exe = node["wls_installation"]["java_home"] + "/bin/java"
run_command = java_exe + " -jar " + temp_weblogic_installer 
install_script = tmp_directory + "/install_script.cmd"

template install_script do
	source "install_script.erb"
	owner user
	group group
	mode 0744
	variables({
		:wls_install_command => run_command,
		:response_file => weblogic_response,
		:log_file => log_file
	})
end

##
# Run installer
##

execute install_script do
	action :run
	not_if { Dir.exists?(weblogic_home) }
end

##
# Clean
##

# Delete temp directory
directory tmp_directory do
	recursive true
	owner user
	group group
	mode '0644'
	action :delete
end