#
# Cookbook Name:: ods_db_import
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

create_sql = File.join(Chef::Config[:file_cache_path], 'create-ods-schema.sql')

results = "/tmp/output.txt"
file results do
    action :delete
end

template create_sql do
  action :create
  notifies :run, 'execute[create-ods-schema]', :immediately
end

execute "create-ods-schema" do
  command "source /u01/app/oracle/product/11.2.0/xe/bin/oracle_env.sh && sqlplus / as sysdba @#{create_sql} &> #{results}"
  user 'oracle'
  group 'dba' # required
  action :nothing
end

ruby_block "output-create-ods-schema" do
    only_if { ::File.exists?(results) }
    block do
        print "\n*** create-ods-schema output ***\n"
        print File.read(results)
                File.delete(results)
    end
end

ods_dump_file = "/u01/app/oracle/admin/XE/dpdump/ODSTT.DMP"

remote_file ods_dump_file do
  source node['ods_db_import']['url']
  owner "oracle"
  group "dba"
  action :create
end

execute "import-ods-dump-file" do
  command "source /u01/app/oracle/product/11.2.0/xe/bin/oracle_env.sh && impdp system/password@xe dumpfile=ODSTT.DMP full=y 2> #{results}"
  user 'oracle'
  group 'dba' # required
  action :run
  returns [0,5] # impdp returns '5' due to ODS user already existing
end
