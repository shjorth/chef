#
# Cookbook Name:: jdk
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

temp_jdk_file = File.join(Chef::Config[:file_cache_path], 'jdk.rpm');

remote_file "#{temp_jdk_file}" do
  source node['jdk']['url']
  action :create
end

# Install JDK RPM 
yum_package 'jdk' do
  source "#{temp_jdk_file}"
  action :install
end

# Update JDK default path
execute 'update-java-alternatives' do
	command "/usr/sbin/alternatives --install \"/usr/bin/java\" \"java\" \"/usr/java/default/bin/java\" 2 
	--slave /usr/bin/javac javac /usr/java/default/bin/javac 
	--slave /usr/bin/javadoc javadoc /usr/java/default/bin/javadoc 
    --slave /usr/bin/jar jar /usr/java/default/bin/jar 
	--slave /usr/bin/keytool keytool /usr/java/default/bin/keytool 
	--slave /usr/bin/orbd orbd /usr/java/default/bin/orbd 
	--slave /usr/bin/pack200 pack200 /usr/java/default/bin/pack200 
	--slave /usr/bin/rmid rmid /usr/java/default/bin/rmid  
	--slave /usr/bin/rmiregistry rmiregistry /usr/java/default/bin/rmiregistry 
	--slave /usr/bin/servertool servertool /usr/java/default/bin/servertool 
	--slave /usr/bin/tnameserv tnameserv /usr/java/default/bin/tnameserv 
	--slave /usr/bin/unpack200 unpack200 /usr/java/default/bin/unpack200 
	--slave /usr/share/man/man1/java.1.gz java.1.gz /usr/java/default/man/man1/java.1.gz 
	--slave /usr/share/man/man1/keytool.1.gz keytool.1.gz /usr/java/default/man/man1/keytool.1.gz 
	--slave /usr/share/man/man1/orbd.1.gz orbd.1.gz /usr/java/default/man/man1/orbd.1.gz 
	--slave /usr/share/man/man1/pack200.1.gz pack200.1.gz /usr/java/default/man/man1/pack200.1.gz 
	--slave /usr/share/man/man1/rmid.1.gz rmid.1.gz /usr/java/default/man/man1/rmid.1.gz 
	--slave /usr/share/man/man1/rmiregistry.1.gz rmiregistry.1.gz /usr/java/default/man/man1/rmiregistry.1.gz 
	--slave /usr/share/man/man1/servertool.1.gz servertool.1.gz /usr/java/default/man/man1/servertool.1.gz 
	--slave /usr/share/man/man1/tnameserv.1.gz tnameserv.1.gz /usr/java/default/man/man1/tnameserv.1.gz 
	--slave /usr/share/man/man1/unpack200.1.gz unpack200.1.gz /usr/java/default/man/man1/unpack200.1.gz ;
	gzip /usr/java/default/man/man1/*.1 ;
	/usr/sbin/alternatives --set java /usr/java/default/bin/java"
	:run
end