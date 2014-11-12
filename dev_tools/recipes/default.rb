#
# Cookbook Name:: dev_tools
# Recipe:: default
#
# Copyright 2014, Example Com
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

include_recipe 'ark::default'
 
# Install maven software
ark 'maven' do
  url      node['dev_tools']['maven']['url']
  home_dir node['dev_tools']['maven']['home']
  version  node['dev_tools']['maven']['version']
  append_env_path node['dev_tools']['maven']['setup_bin']
end
 
template '/etc/mavenrc' do
  source 'mavenrc.erb'
  mode   '0755'
end

directory "/root/.m2" do
  owner "root"
  group "root"
  mode 00644
  action :create
end

# Create default root settings.xml file
template '/root/.m2/settings.xml' do
  source 'maven_root_settings_xml.erb'
  mode   '0644'
end

# Install SVN
yum_package 'subversion >= 1.8.8-1'

# Install OC4J software
ark 'oc4j' do
  url      node['dev_tools']['oc4j']['url']
  home_dir node['dev_tools']['oc4j']['home']
  version  node['dev_tools']['oc4j']['version']
  append_env_path node['dev_tools']['oc4j']['setup_bin']
end

# Install OC4J startup script
service "oc4j" do
  supports :restart => true, :start => true, :stop => true, :reload => false
  action :nothing
end

template "oc4j" do
  path "/etc/init.d/oc4j"
  source "oc4j_init.erb"
  owner "root"
  group "root"
  mode "0755"
  notifies :enable, "service[oc4j]"
  notifies :start, "service[oc4j]"
end
