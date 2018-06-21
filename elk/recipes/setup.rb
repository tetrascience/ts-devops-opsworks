#
# Cookbook:: elk
# Recipe:: setup
#
# Copyright:: 2018, The Authors, All Rights Reserved.

include_recipe 'java'
include_recipe 'chef-sugar'

package_extension = 'deb' if node['platform_family'] == 'debian'
package_extension = 'rpm' if node['platform_family'] == 'rhel'

%w(* root elasticsearch kibana).each do |user|
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

%w(elasticsearch logstash kibana).each do |elk|
  remote_file "/tmp/#{elk}.deb" do
    source "#{node[elk]['download_urls'][node['platform_family']]}"
    action :create
  end
  dpkg_package "#{elk}" do
    source "/tmp/#{elk}.deb"
    action :install
  end
end if node['platform_family'] == 'debian'

execute 'chpwn_elasticseach_mount' do
  command 'chown -R elasticsearch:elasticsearch /var/lib/elasticsearch'
  action :run
  only_if { ::Dir.exist?("/var/lib/elasticsearch") }
end
