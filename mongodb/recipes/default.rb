#
# Cookbook:: mongodb
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.

include_recipe 'apt'

package [ 'apt-transport-https' ]

apt_repository 'mongodb' do
  uri 'https://repo.mongodb.org/apt/ubuntu'
  components ['multiverse']
  arch 'amd64'
  distribution 'xenial/mongodb-org/3.6'
  key '2930ADAE8CAF5059EE73BB4B58712A2291FA4AD5'
  keyserver 'keyserver.ubuntu.com'
  action :add
end

package 'mongodb-org' do
  action :install
end

template '/etc/mongod.conf' do
  source 'mongod.conf.erb'
  owner 'root'
  group 'root'
  mode '0644'
  notifies :restart, 'service[mongod]', :delayed
end

service 'mongod' do
  supports status: true
  action [:enable, :start]
end
