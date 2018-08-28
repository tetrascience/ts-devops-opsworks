#
# Cookbook:: elasticsearch
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.

include_recipe 'java'
include_recipe 'apt'

datadogkey = node['elasticsearch']['datadogkey']
instance = node['elasticsearch']['instance']

%w(* root elasticsearch).each do |user|
  set_limit user do
    type 'hard'
    item 'nofile'
    value 999999
    use_system true
  end
  set_limit user do
    type 'soft'
    item 'nofile'
    value 999999
    use_system true
  end
end

package 'apt-transport-https'

apt_repository 'elasticsearch' do
  uri "#{node['elasticsearch']['repo']['url'][node['elasticsearch']['version']]}"
  components ['main']
  distribution 'stable'
  key "#{node['elasticsearch']['repo']['gpg'][node['elasticsearch']['version']]}"
  action :add
end

package 'elasticsearch' do
  action :install
end

directory '/var/repos/elasticsearch' do
  owner 'elasticsearch'
  group 'elasticsearch'
  recursive true
  mode '0755'
  action :create
end

execute 'plugin_elasticseach_s3' do
  command '/usr/share/elasticsearch/bin/elasticsearch-plugin install --batch repository-s3'
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

execute 'chpwn_elasticseach_mount' do
  command 'chown -R elasticsearch:elasticsearch /var/lib/elasticsearch'
  action :run
  only_if { ::Dir.exist?("/var/lib/elasticsearch") }
end

if node['elasticsearch']['version'] == "2.x" then
  execute 'install_elasticsearch_head' do
    command '/usr/share/elasticsearch/bin/plugin install mobz/elasticsearch-head'
    action :run
    creates "/usr/share/elasticsearch/plugins/head"
  end
  execute 'install_elasticsearch_head' do
    command '/usr/share/elasticsearch/bin/plugin install lmenezes/elasticsearch-kopf/v2.1.1'
    action :run
    creates "/usr/share/elasticsearch/plugins/kopf"
  end
end

if datadogkey != "" then
  execute 'install_datadog' do
    command "DD_API_KEY=#{datadogkey} bash -c \"$(curl -L https://raw.githubusercontent.com/DataDog/datadog-agent/master/cmd/agent/install_script.sh)\""
    action :run
  end
  execute 'tag_instance' do
    command "echo tags:#{instance} >> /etc/datadog-agent/datadog.yaml"
    action :run
  end
end
