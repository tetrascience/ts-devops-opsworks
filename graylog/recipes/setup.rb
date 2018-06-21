#
# Cookbook:: graylog
# Recipe:: setup
#
# Copyright:: 2018, The Authors, All Rights Reserved.
include_recipe 'java'
include_recipe 'apt'

package [ 'apt-transport-https', 'wget' ]

apt_repository 'mongodb' do
  uri 'https://repo.mongodb.org/apt/ubuntu'
  components ['multiverse']
  arch 'amd64'
  distribution 'xenial/mongodb-org/3.6'
  key '2930ADAE8CAF5059EE73BB4B58712A2291FA4AD5'
  keyserver 'keyserver.ubuntu.com'
  action :add
end

execute 'get_graylog' do
  command "wget https://packages.graylog2.org/repo/packages/graylog-#{node['graylog']['version']}-repository_latest.deb"
  action  :run
  creates "/tmp/graylog-#{node['graylog']['version']}-repository_latest.deb"
  cwd     "/tmp"
end

dpkg_package 'graylog' do
  source "/tmp/graylog-#{node['graylog']['version']}-repository_latest.deb"
  action :install
end

apt_update 'graylog' do
  ignore_failure true
  action :update
end

package [ 'mongodb-org',  'uuid-runtime', 'pwgen','graylog-server' ]

service 'mongod' do
  supports status: true
  action [:enable, :start]
end
