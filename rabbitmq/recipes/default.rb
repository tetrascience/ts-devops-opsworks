#
# Cookbook:: rabbitmq
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.

#include_recipe 'java'
include_recipe 'apt'

package [ 'apt-transport-https', 'init-system-helpers', 'socat', 'logrotate',  'adduser' ]

apt_repository 'erlang' do
  uri 'https://packages.erlang-solutions.com/ubuntu'
  components ['contrib']
  distribution 'xenial'
  key 'https://packages.erlang-solutions.com/ubuntu/erlang_solutions.asc'
  action :add
end

package ['erlang-base','erlang-inets', 'erlang-crypto', 'erlang-inets', 'erlang-runtime-tools', 'erlang-snmp', 'erlang-ssh', 'erlang-tools', 'erlang-xmerl', 'erlang-syntax-tools', 'erlang-ic', 'erlang-mnesia'] do
  action :install
  version ['1:20.3-1', '1:20.3-1', '1:20.3-1', '1:20.3-1', '1:20.3-1', '1:20.3-1', '1:20.3-1', '1:20.3-1', '1:20.3-1', '1:20.3-1', '1:20.3-1', '1:20.3-1']
  timeout 900
end

package ['erlang','erlang-dev', 'erlang-appmon', 'erlang-common-test', 'erlang-debugger', 'erlang-dialyzer', 'erlang-et', 'erlang-gs', 'erlang-megaco', 'erlang-observer', 'erlang-pman', 'erlang-reltool', 'erlang-test-server', 'erlang-toolbar', 'erlang-tv', 'erlang-typer', 'erlang-wx', 'erlang-ic-java', 'erlang-src'] do
  action :install
  version ['1:20.3-1', '1:20.3-1', '1:20.3-1', '1:20.3-1', '1:20.3-1', '1:20.3-1', '1:20.3-1', '1:20.3-1', '1:20.3-1', '1:20.3-1', '1:20.3-1', '1:20.3-1', '1:20.3-1', '1:20.3-1', '1:20.3-1', '1:20.3-1', '1:20.3-1', '1:20.3-1', '1:20.3-1']
  timeout 900
end

apt_repository 'rabbitmq' do
  uri 'https://dl.bintray.com/rabbitmq/debian'
  components ['main']
  distribution 'xenial'
  key 'https://dl.bintray.com/rabbitmq/Keys/rabbitmq-release-signing-key.asc'
  action :add
end

package 'rabbitmq-server' do
  action :install
end

execute 'enalbe_rabiitmq_management_plugin' do
  command 'rabbitmq-plugins enable rabbitmq_management'
  action :run
end

template '/etc/rabbitmq/rabbitmq.conf' do
  source 'rabbitmq.conf.erb'
  owner 'root'
  group 'root'
  mode '0644'
  notifies :restart, 'service[rabbitmq-server]', :delayed
end

service 'rabbitmq-server' do
  supports status: true
  action [:enable, :start]
end
