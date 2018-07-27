#
# Cookbook:: rabbitmq
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.

#include_recipe 'java'
include_recipe 'apt'

datadogkey = node['rabbitmq']['datadogkey']
instance = node['rabbitmq']['instance']

package [ 'apt-transport-https', 'init-system-helpers', 'socat', 'logrotate',  'adduser' ]

apt_repository 'erlang' do
  uri 'https://packages.erlang-solutions.com/ubuntu'
  components ['contrib']
  distribution 'xenial'
  key 'https://packages.erlang-solutions.com/ubuntu/erlang_solutions.asc'
  action :add
end

package ['erlang-base','erlang-inets', 'erlang-crypto', 'erlang-inets', 'erlang-runtime-tools', 'erlang-snmp', 'erlang-ssh', 'erlang-tools', 'erlang-xmerl', 'erlang-syntax-tools', 'erlang-ic', 'erlang-mnesia', 'erlang-ssl', 'erlang-public-key', 'erlang-asn1'] do
  action :install
  version ['1:20.3-1', '1:20.3-1', '1:20.3-1', '1:20.3-1', '1:20.3-1', '1:20.3-1', '1:20.3-1', '1:20.3-1', '1:20.3-1', '1:20.3-1', '1:20.3-1', '1:20.3-1', '1:20.3-1', '1:20.3-1', '1:20.3-1']
  timeout 900
end

package ['erlang-corba', 'erlang-diameter', 'erlang-edoc', 'erlang-eldap', 'erlang-erl-docgen', 'erlang-eunit', 'erlang-inviso', 'erlang-odbc', 'erlang-os-mon', 'erlang-parsetools', 'erlang-percept'] do
  action :install
  version ['1:20.3-1', '1:20.3-1', '1:20.3-1', '1:20.3-1', '1:20.3-1', '1:20.3-1', '1:20.3-1', '1:20.3-1', '1:20.3-1', '1:20.3-1', '1:20.3-1']
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

directory '/mnt/lib' do
  owner 'rabbitmq'
  group 'rabbitmq'
  mode '0755'
  action :create
end

directory '/mnt/log' do
  owner 'rabbitmq'
  group 'rabbitmq'
  mode '0755'
  action :create
end

execute 'copy_lib_files' do
  command 'mv /var/lib/rabbitmq /mnt/lib'
  action :run
end

execute 'copy_log_files' do
  command 'mv /var/log/rabbitmq /mnt/log'
  action :run
end

execute 'link_folders' do
  command 'ln -s /mnt/lib/rabbitmq /var/lib/rabbitmq'
  action :run
end

execute 'link_log_folders' do
  command 'ln -s /mnt/log/rabbitmq /var/log/rabbitmq'
  action :run
end

directory '/tmp/ssm' do
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

remote_file '/tmp/ssm/amazon-ssm-agent.deb' do
  source 'https://s3.amazonaws.com/ec2-downloads-windows/SSMAgent/latest/debian_amd64/amazon-ssm-agent.deb'
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

dpkg_package 'amazon-ssm-agent.deb' do
  source '/tmp/ssm/amazon-ssm-agent.deb'
  action :install
end

if datadogkey != "" then
  execute 'install_datadog' do
    command "DD_API_KEY=#{datadogkey} bash -c '$(curl -L https://raw.githubusercontent.com/DataDog/datadog-agent/master/cmd/agent/install_script.sh)'"
    action :run
  end
  execute 'tag_instance' do
    command "echo tags:#{instance} >> /etc/datadog-agent/datadog.yaml"
    action :run
  end
end
