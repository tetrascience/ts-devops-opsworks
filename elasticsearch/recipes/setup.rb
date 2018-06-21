#
# Cookbook:: elasticsearch
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.

include_recipe 'java'
include_recipe 'apt'

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

execute 'chpwn_elasticseach_mount' do
  command 'chown -R elasticsearch:elasticsearch /var/lib/elasticsearch'
  action :run
  only_if { ::Dir.exist?("/var/lib/elasticsearch") }
end

execute 'create_elasticseach_repos' do
  command 'mkdir -p /var/repos/elastichsearch'
  action :run
end

execute 'chpwn_elasticseach_path' do
  command 'chown -R elasticsearch:elasticsearch /var/repos/elastichsearch'
  action :run
  only_if { ::Dir.exist?("/var/repos/elastichsearch") }
end

execute 'plugin_elasticseach_s3' do
  command '/usr/share/elasticsearch/bin/elasticsearch-plugin install repository-s3'
  action :run
end

execute 'system_manger' do
  command 'mkdir /tmp/ssm & wget https://s3.amazonaws.com/ec2-downloads-windows/SSMAgent/latest/debian_amd64/amazon-ssm-agent.deb & dpkg -i amazon-ssm-agent.deb'
  action :run
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
